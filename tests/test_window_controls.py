"""Opt-in real-client regression in an isolated nested Hyprland.

Set ARGVUS_TEST_ARGVUS, ARGVUS_TEST_HYPRBARS and ARGVUS_TEST_WAYBAR to built
artifacts. Optional ARGVUS_TEST_KEYBOARD names a virtual-keyboard test driver
that presses SUPER + ALT + Space. Without it, mode changes use the CLI.
Optional ARGVUS_TEST_POINTER names a click driver taking x, y, width, height.
The ordinary test run skips this test; it never uses the main
compositor or the user's persistent configuration as fixtures.
"""
import json
import os
from pathlib import Path
import shutil
import signal
import socket
import subprocess
import tempfile
import time
import unittest

ROOT = Path(__file__).resolve().parents[1]
WORKSPACE = ROOT.parent.parent
ARTIFACTS = [os.environ.get(key) for key in
             ("ARGVUS_TEST_ARGVUS", "ARGVUS_TEST_HYPRBARS", "ARGVUS_TEST_WAYBAR")]

@unittest.skipUnless(all(ARTIFACTS) and shutil.which("Hyprland") and shutil.which("foot"),
                     "built artifacts and a parent Wayland session are required")
class WindowControls(unittest.TestCase):
    def test_real_windows_bar_and_recovery(self):
        Path("/tmp/argvus").mkdir(exist_ok=True)
        with tempfile.TemporaryDirectory(prefix="w-", dir="/tmp/argvus") as temporary:
            root = Path(temporary)
            (root / "argvus").mkdir()
            (root / "bin").mkdir()
            (root / "bin/argvus").symlink_to(Path(ARTIFACTS[0]).resolve())
            (root / "bin/waybar").symlink_to(Path(ARTIFACTS[2]).resolve())
            parent_display = os.environ.get("ARGVUS_TEST_PARENT_WAYLAND") or os.environ.get("WAYLAND_DISPLAY")
            if not parent_display:
                self.skipTest("a parent Wayland display is required")
            if not Path(parent_display).is_absolute():
                parent_display = str(Path(os.environ["XDG_RUNTIME_DIR"]) / parent_display)
            env = dict(os.environ, PATH=str(root / "bin") + ":" + os.environ["PATH"],
                       AQ_BACKEND="wayland", XDG_RUNTIME_DIR=str(root),
                       WAYLAND_DISPLAY=parent_display,
                       ARGVUS_CONFIG_HOME=str(root / "config"), XDG_CONFIG_HOME=str(root / "config"),
                       ARGVUS_DATA_HOME=str(root / "config/argvus/data"),
                       XDG_STATE_HOME=str(root / "state"),
                       ARGVUS_I18N_DIR=str(WORKSPACE / "de/argvus/resources/locales"),
                       ARGVUS_SYSTEM_CONFIG=str(WORKSPACE / "de/argvus-taskbar/src/usr/share/argvus"),
                       ARGVUS_HYPRBARS_PLUGIN=str(Path(ARTIFACTS[1]).resolve()), ARGVUS_NO_RUNTIME="1")
            config = root / "nested.lua"
            mode_path = root / "config/argvus/data/generated/hypr/window-mode.lua"
            mode_path.parent.mkdir(parents=True)
            mode_path.write_text('return { mode = "floating" }\n')
            canonical = root / "config/argvus/config"
            canonical.mkdir(parents=True)
            (canonical / "hyprland.json").write_text(json.dumps({"window_mode":"floating"}))
            hyprland_source = (ROOT / "src/usr/share/argvus/hyprland/config/hyprland.lua").read_text()
            bind_start = hyprland_source.index("local function _argvus_bind(")
            bind_end = hyprland_source.index("\n-- Font state", bind_start)
            bind_wrapper = hyprland_source[bind_start:bind_end]
            mode_binding = next(line for line in hyprland_source.splitlines() if line.startswith('_argvus_bind("window.toggle_mode",'))
            overrides_path = root / "shortcut-overrides.lua"
            overrides_path.write_text("return {}\n")
            # Isolate virtual test-keyboard modifiers from the parent compositor.
            config.write_text('''hl.monitor({output="",mode="1280x720@60",scale=1})
hl.config({ input = { virtualkeyboard = { share_states = 0 } }, misc = { disable_hyprland_logo = true, disable_splash_rendering = true } })
-- Keep parent-compositor pointer events out of the isolated click tests.
hl.device({name="wl_pointer",enabled=false})
hl.window_rule({match={class="argvus-controls-dialog"},float=true})
local mode = "tile"
local file = io.open("''' + str(mode_path) + '''", "r")
if file then file:close(); mode = dofile("''' + str(mode_path) + '''").mode end
argvus_window_controls = dofile("''' + str(ROOT / "src/usr/share/argvus/hyprland/lua/window-controls.lua") + '''")
argvus_window_mode = dofile("''' + str(ROOT / "src/usr/share/argvus/hyprland/lua/window-mode.lua") + '''")(mode, argvus_window_controls)
''')
            with config.open("a") as file:
                file.write('\nlocal mod="SUPER"\nlocal _keybinding_overrides=dofile(' + json.dumps(str(overrides_path)) + ')\n' + bind_wrapper + '\n' + mode_binding + '\n')
            processes = []
            logs = []
            def spawn(arguments):
                log = (root / ("process-" + str(len(processes)) + ".log")).open("w")
                logs.append(log)
                process = subprocess.Popen(arguments, env=env, stdout=log, stderr=log, start_new_session=True)
                processes.append(process)
                return process
            def until(predicate):
                deadline = time.monotonic() + 12
                while time.monotonic() < deadline:
                    try:
                        value = predicate()
                        if value:
                            return value
                    except (OSError, ValueError, AssertionError):
                        pass
                    time.sleep(0.1)
                raise AssertionError("timed out: " + str([p.poll() for p in processes]))
            def cli(*arguments):
                result = subprocess.run([ARTIFACTS[0], *arguments], env=env, capture_output=True,
                                        text=True, timeout=15)
                self.assertEqual(result.returncode, 0, (arguments, result.stdout, result.stderr))
                return result.stdout
            def ipc(command):
                with socket.socket(socket.AF_UNIX) as stream:
                    stream.settimeout(5)
                    stream.connect(str(control_socket))
                    stream.sendall(command.encode())
                    data = b""
                    while chunk := stream.recv(65536):
                        data += chunk
                    return data.decode()
            def clients():
                return json.loads(ipc("j/clients"))
            def parked(window):
                return window["workspace"]["name"] == "special:argvus-minimized"
            try:
                spawn(["Hyprland", "--config", str(config)])
                control_socket = until(lambda: next((root / "hypr").glob("*/.socket.sock"), None))
                env["HYPRLAND_INSTANCE_SIGNATURE"] = control_socket.parent.name
                env["WAYLAND_DISPLAY"] = str(until(lambda: next((path for path in root.glob("wayland-*") if path.is_socket()), None)))
                until(lambda: any(monitor["width"] > 0 and monitor["height"] > 0 for monitor in json.loads(ipc("j/monitors"))))
                self.assertIn("hyprbars", until(lambda: ipc("/plugin list")))
                def mode_binds():
                    return [binding for binding in json.loads(ipc("j/binds")) if binding.get("key", "").lower() == "space" and binding["modmask"] == 72]
                self.assertEqual(len(mode_binds()), 1)
                self.assertFalse(mode_binds()[0]["repeat"])

                until(lambda: not json.loads(cli("config", "window-mode", "status", "--json"))["pending"])
                service = spawn([ARTIFACTS[0], "windows", "service"])
                until(lambda: json.loads(cli("windows", "list", "--json")))
                primary_config = root / "config/waybar/argvus-taskbar.jsonc"
                primary_config.parent.mkdir(parents=True, exist_ok=True)
                primary_style = root / "config/waybar/argvus-taskbar.css"
                primary_style.write_text("""@define-color th-right02-bg #111316;
@define-color th-foreground #eeeeee;
@define-color th-border-rights #3590bd;
@define-color th-decorate #3590bd;
window#waybar { background: #111316; color: #eeeeee; border: 2px solid @th-decorate; border-radius: 4px; }
""")
                primary_data = {"name":"argvus-taskbar", "position":"top", "layer":"top", "exclusive":True, "height":28, "modules-left":[]}
                primary_config.write_text(json.dumps(primary_data))
                spawn([ARTIFACTS[0], "windows", "bar"])
                primary = spawn([ARTIFACTS[2], "--config", str(primary_config), "--style", str(primary_style)])
                until(lambda: "argvus-taskbar" in ipc("j/layers"))
                for name in ["argvus-controls-normal", "argvus-controls-dialog"]:
                    spawn(["foot", "--app-id=" + name, "sh", "-c", "sleep 300"])
                until(lambda: len(clients()) == 2)
                normal = next(window["address"] for window in clients() if window["class"] == "argvus-controls-normal")
                dialog = next(window["address"] for window in clients() if window["class"] == "argvus-controls-dialog")
                self.assertEqual(ipc('/eval for _,w in ipairs(hl.get_windows()) do if w.address=="' + dialog + '" then hl.dispatch(hl.dsp.window.float({action="set",window=w})) end end'), "ok")
                cli("config", "window-mode", "set", "floating")
                until(lambda: json.loads(cli("windows", "list", "--json"))["ready"])
                # Taskbar clicks focus an inactive window, minimize the active
                # one, then restore it. Explicit activate never minimizes.
                def click_normal():
                    driver = os.environ.get("ARGVUS_TEST_POINTER")
                    if not driver:
                        cli("windows", "toggle", normal)
                        return
                    # Let the GTK consumer receive the preceding state update.
                    time.sleep(.2)
                    entries = json.loads(cli("windows", "list", "--json"))["windows"]
                    index = next(index for index, window in enumerate(entries) if window["address"] == normal)
                    layers = [entry for output in json.loads(ipc("j/layers")).values() for level in output["levels"].values() for entry in level]
                    bar = next(entry for entry in layers if entry["namespace"] == "argvus-window-bar")
                    monitor = json.loads(ipc("j/monitors"))[0]
                    x = int(bar["x"] + bar["w"] * (index + .5) / len(entries))
                    y = int(bar["y"] + bar["h"] / 2)
                    subprocess.run([driver, str(x), str(y), str(int(monitor["width"] / monitor["scale"])), str(int(monitor["height"] / monitor["scale"]))],env=env,check=True,timeout=10)
                cli("windows", "activate", dialog)
                click_normal()
                until(lambda: json.loads(ipc("j/activewindow"))["address"] == normal)
                self.assertFalse(any(parked(window) for window in clients()))
                pointer_before_toggle = json.loads(ipc("j/cursorpos"))
                click_normal()
                until(lambda: any(window["address"] == normal and parked(window) for window in clients()))
                click_normal()
                until(lambda: json.loads(ipc("j/activewindow"))["address"] == normal)
                self.assertFalse(any(parked(window) for window in clients()))
                self.assertEqual(json.loads(ipc("j/cursorpos")), pointer_before_toggle)
                cli("windows", "activate", normal)
                self.assertFalse(any(parked(window) for window in clients()))
                before = next(window for window in clients() if window["address"] == normal)
                cli("windows", "minimize", normal)
                until(lambda: any(parked(window) for window in clients()))
                self.assertIn("argvus-window-bar", ipc("j/layers"))
                reserved = json.loads(ipc("j/monitors"))[0]["reserved"]
                self.assertGreater(reserved[1], 0)
                self.assertGreater(reserved[3], 0)
                service.terminate()
                service.wait(timeout=5)
                service = spawn([ARTIFACTS[0], "windows", "service"])
                until(lambda: json.loads(cli("windows", "list", "--json"))["recovering"])
                cli("windows", "restore", normal)
                after = next(window for window in clients() if window["address"] == normal)
                self.assertEqual((after["at"], after["size"], after["workspace"]),
                                 (before["at"], before["size"], before["workspace"]))
                until(lambda: json.loads(cli("windows", "list", "--json"))["ready"])
                cli("windows", "maximize", normal)
                ipc('/eval hl.config({cursor={no_warps=false}}); hl.dispatch(hl.dsp.cursor.move({x=4,y=4}))')
                sticky_pointer = json.loads(ipc("j/cursorpos"))
                cli("windows", "minimize", normal)
                cli("windows", "restore", normal)
                self.assertEqual(json.loads(ipc("j/cursorpos")), sticky_pointer)
                self.assertEqual(next(window for window in clients() if window["address"] == normal)["fullscreen"], 1)
                cli("windows", "minimize", normal)
                keyboard = os.environ.get("ARGVUS_TEST_KEYBOARD")
                if keyboard:
                    subprocess.run([keyboard], env=env, check=True, timeout=10)
                    until(lambda: json.loads(cli("config", "window-mode", "status", "--json"))["preferred"] == "tile")
                else:
                    self.assertEqual(json.loads(cli("config", "window-mode", "toggle"))["preferred"], "tile")
                until(lambda: "argvus-window-bar" not in ipc("j/layers"))
                self.assertFalse(any(parked(window) for window in clients()))
                self.assertFalse(next(window for window in clients() if window["address"] == normal)["floating"])
                self.assertTrue(next(window for window in clients() if window["address"] == dialog)["floating"], clients())
                cli("windows", "position", "bottom")
                primary.terminate()
                primary.wait(timeout=5)
                primary_data["position"] = "bottom"
                primary_config.write_text(json.dumps(primary_data))
                primary = spawn([ARTIFACTS[2], "--config", str(primary_config), "--style", str(primary_style)])
                self.assertEqual(json.loads(cli("windows", "list", "--json"))["position"], "bottom")
                cli("config", "window-mode", "set", "floating")
                until(lambda: json.loads(cli("windows", "list", "--json"))["ready"])
                layers = ipc("j/layers")
                self.assertIn("argvus-window-bar", layers)
                entries = [entry for output in json.loads(layers).values() for level in output["levels"].values() for entry in level]
                main = next(entry for entry in entries if entry["namespace"] == "argvus-taskbar")
                secondary = next(entry for entry in entries if entry["namespace"] == "argvus-window-bar")
                self.assertLess(secondary["y"], main["y"])
                cli("windows", "position", "bottom")
                self.assertEqual(ipc("/reload"), "ok")
                self.assertEqual(len(mode_binds()), 1)
                overrides_path.write_text('return {["window.toggle_mode"]={keys="SUPER + ALT + T",enabled=true}}\n')
                self.assertEqual(ipc("/reload"), "ok")
                self.assertEqual(mode_binds(), [])
                self.assertTrue(any(binding["modmask"] == 72 and binding.get("key", "").lower() == "t" for binding in json.loads(ipc("j/binds"))))
                overrides_path.write_text('return {["window.toggle_mode"]={enabled=false}}\n')
                self.assertEqual(ipc("/reload"), "ok")
                self.assertEqual(mode_binds(), [])
                overrides_path.write_text("return {}\n")
                self.assertEqual(ipc("/reload"), "ok")
                self.assertEqual(len(mode_binds()), 1)
                until(lambda: not json.loads(cli("config", "window-mode", "status", "--json"))["pending"])
                # The default shortcut still works in both directions after reload.
                if keyboard:
                    for expected in ["tile", "floating"]:
                        subprocess.run([keyboard], env=env, check=True, timeout=10)
                        until(lambda: json.loads(cli("config", "window-mode", "status", "--json"))["preferred"] == expected)
                else:
                    for expected in ["tile", "floating"]:
                        self.assertEqual(json.loads(cli("config", "window-mode", "toggle"))["preferred"], expected)
                # Spaced geometry includes both bars, the title and window border.
                layout_path = canonical / "layout.json"
                layout_data = json.loads(layout_path.read_text())
                layout_data["variant"] = "spaced"
                layout_path.write_text(json.dumps(layout_data))
                primary_data.update({"margin-top":16,"margin-bottom":3,"margin-left":18,"margin-right":20})
                primary_config.write_text(json.dumps(primary_data))
                primary.terminate()
                primary.wait(timeout=5)
                primary = spawn([ARTIFACTS[2], "--config", str(primary_config), "--style", str(primary_style)])
                until(lambda: "argvus-taskbar" in ipc("j/layers"))
                ipc('/eval hl.config({animations={enabled=false},general={gaps_out={top=18,right=18,bottom=2,left=18},border_size=2}}); local w=hl.get_window("address:' + normal + '"); hl.dispatch(hl.dsp.window.fullscreen_state({internal=0,client=0,window=w})); hl.dispatch(hl.dsp.window.resize({x=5000,y=5000,window=w})); hl.dispatch(hl.dsp.window.move({x=0,y=0,relative=false,window=w}))')
                def visible_gaps():
                    window = next(window for window in clients() if window["address"] == normal)
                    layers = [entry for output in json.loads(ipc("j/layers")).values() for level in output["levels"].values() for entry in level
                              if entry["namespace"] in ("argvus-taskbar", "argvus-window-bar")]
                    if len(layers) != 2:
                        raise ValueError("bars not ready")
                    upper, lower = sorted(layers, key=lambda entry: entry["y"])
                    return (window["at"][1] - 28 - 2 - upper["y"] - upper["h"],
                            lower["y"] - window["at"][1] - window["size"][1] - 2)
                def fits():
                    window = next(window for window in clients() if window["address"] == normal)
                    monitor = json.loads(ipc("j/monitors"))[0]
                    above, below = visible_gaps()
                    return (window["at"][0] >= 20 and above >= 18 and below >= 18
                            and window["at"][0] + window["size"][0] <= monitor["width"] / monitor["scale"] - 20)
                until(fits)
                generated_bar = until(lambda: next((root / "argvus").glob("windows-*.bar.json"), None))
                until(lambda: json.loads(generated_bar.read_text()).get("margin-bottom") == 16)
                self.assertEqual(json.loads(generated_bar.read_text())["margin-top"], 3)
                ipc('/eval local w=hl.get_window("address:' + normal + '"); hl.dispatch(hl.dsp.window.resize({x=300,y=200,window=w})); hl.dispatch(hl.dsp.window.move({x=100,y=150,relative=false,window=w}))')
                until(fits)
                before_maximize = next(window for window in clients() if window["address"] == normal)
                self.assertTrue(json.loads(ipc("j/getoption plugin:hyprbars:bar_precedence_over_border"))["bool"])
                cli("windows", "maximize", normal)
                self.assertTrue(next(window for window in json.loads(cli("windows", "list", "--json"))["windows"] if window["address"] == normal)["maximized"])
                self.assertEqual(next(window for window in clients() if window["address"] == normal)["fullscreen"], 0)
                until(lambda: visible_gaps() == (18, 18))
                cli("windows", "position", "top")
                primary.terminate()
                primary.wait(timeout=5)
                primary_data["position"] = "top"
                primary_config.write_text(json.dumps(primary_data))
                primary = spawn([ARTIFACTS[2], "--config", str(primary_config), "--style", str(primary_style)])
                ipc('/eval hl.config({general={gaps_out={top=15,right=18,bottom=18,left=18}}})')
                until(lambda: visible_gaps() == (18, 18))
                until(lambda: json.loads(cli("windows", "list", "--json"))["ready"])
                cli("windows", "minimize", normal)
                service.terminate()
                service.wait(timeout=5)
                service = spawn([ARTIFACTS[0], "windows", "service"])
                until(lambda: json.loads(cli("windows", "list", "--json"))["recovering"])
                cli("windows", "restore", normal)
                until(fits)
                cli("windows", "maximize", normal)
                restored = next(window for window in clients() if window["address"] == normal)
                self.assertEqual((restored["at"],restored["size"]), (before_maximize["at"],before_maximize["size"]))
                ipc('/eval hl.config({cursor={no_warps=false}}); hl.dispatch(hl.dsp.cursor.move({x=4,y=4}))')
                pointer_before = json.loads(ipc("j/cursorpos"))
                cli("windows", "activate", normal)
                self.assertEqual(json.loads(ipc("j/cursorpos")), pointer_before)
                self.assertFalse(json.loads(ipc("j/getoption cursor:no_warps"))["bool"])
                until(lambda: json.loads(cli("windows", "list", "--json"))["ready"])
                cli("windows", "minimize", normal)
                cli("windows", "restore", normal)
                self.assertEqual(json.loads(ipc("j/cursorpos")), pointer_before)
                # Fullscreen continues to use the whole output.
                ipc('/eval hl.dispatch(hl.dsp.window.fullscreen({mode="fullscreen",action="set",window=hl.get_window("address:' + normal + '")}))')
                cli("windows", "list", "--json")
                self.assertEqual(next(window for window in clients() if window["address"] == normal)["fullscreen"], 2)
                ipc('/eval hl.dispatch(hl.dsp.window.fullscreen_state({internal=0,client=0,window=hl.get_window("address:' + normal + '")}))')
                self.assertEqual(ipc('/eval hl.dispatch(hl.dsp.window.move({workspace="name:argvus-named-test",follow=false,window=hl.get_window("address:' + normal + '")}))'), "ok")
                cli("windows", "minimize", normal)
                cli("windows", "restore", normal)
                self.assertEqual(next(window for window in clients() if window["address"] == normal)["workspace"]["name"], "argvus-named-test")
                cli("windows", "minimize", normal)
                cli("windows", "close", normal)
                until(lambda: all(window["address"] != normal for window in clients()))
                until(lambda: not json.loads(cli("windows", "list", "--json"))["recovering"])
                original_dialog = next(window for window in clients() if window["address"] == dialog)
                cli("windows", "maximize", dialog)
                cli("config", "window-mode", "set", "tile")
                restored_dialog = next(window for window in clients() if window["address"] == dialog)
                self.assertEqual((restored_dialog["at"], restored_dialog["size"]), (original_dialog["at"], original_dialog["size"]))
            except Exception:
                for log in root.glob("process-*.log"):
                    print(log.name, log.read_text()[-4000:])
                raise
            finally:
                for process in reversed(processes):
                    try:
                        os.killpg(process.pid, signal.SIGTERM)
                    except ProcessLookupError:
                        pass
                    try:
                        process.wait(timeout=5)
                    except subprocess.TimeoutExpired:
                        process.kill()
                        process.wait()
                for log in logs:
                    log.close()
