"""Window policy regression tests executed inside Hyprland's Lua runtime."""
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]

@unittest.skipUnless(shutil.which("Hyprland"), "Hyprland is required")
class WorkspaceNavigation(unittest.TestCase):
    def test_monitor_local_navigation(self):
        Path("/tmp/argvus").mkdir(exist_ok=True)
        with tempfile.TemporaryDirectory(prefix="wm-", dir="/tmp/argvus") as directory:
            runtime = Path(directory)
            (runtime / "argvus").mkdir()
            environment = dict(os.environ, XDG_RUNTIME_DIR=directory,
                               HYPRLAND_INSTANCE_SIGNATURE="argvus-test",
                               ARGVUS_WORKSPACE_MODULE=str(ROOT / "src/usr/share/argvus/hyprland/lua/workspaces.lua"))
            result = subprocess.run(["Hyprland", "--verify-config", "--config", str(ROOT / "tests/workspaces.lua")],
                                    env=environment, capture_output=True, text=True, timeout=30)
            output = result.stdout + result.stderr
            self.assertEqual(result.returncode, 0, output)
            self.assertIn("workspace assertions passed", output)
            self.assertIn("config ok", output)
