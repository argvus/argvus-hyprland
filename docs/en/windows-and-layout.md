---
title: Windows and layout
description: Understand gaps, borders, modes and panel space in ARGVUS.
---

ARGVUS uses Hyprland for tiled and floating window placement. The user-facing layout controls live in three Control Center pages: **Control Center → Appearance → Taskbar** (position, spaces and icons), **Control Center → Desktop & Input → Hyprland → Window spaces** and **Control Center → Desktop & Input → Hyprland → Borders**.

## The concepts

```text
┌────────────────────────────────────┐
│          outer space / panel       │
│   ┌────────────┐  inner  ┌──────┐  │
│   │   window   │   gap    │window│  │
│   └────────────┘          └──────┘  │
│     border around each window       │
└────────────────────────────────────┘
```

- **Window gaps** are the space between tiled windows and the outer edge of the tiled layout.
- **Taskbar or shell spacing** is the margin around desktop surfaces such as the taskbar and panel. It is not the same value as a window gap.
- **Borders** are the visible edge drawn around a window. **Edge thickness** controls the border width exposed by the appearance page.
- **Rounding** is part of the selected visual mode. It changes the window corner shape rather than moving the window.
- **Panel reservation and visible margin** are separate concerns: a panel can occupy or visually use space while Hyprland still lays out windows according to the active spacing state.

## Sticky and Spaced modes

The bundled theme modes provide two starting geometries:

| Mode | Window behavior | Surface treatment |
| --- | --- | --- |
| Sticky | Internal gap `2`, outer gap `0` by default | Square, compact and close to the screen edge |
| Spaced | Internal gap `10`, outer gap `18` by default | Rounded, shadowed and more spacious; taskbar/shell margin defaults to `18` |

These are defaults, not limits. The Window spaces and Taskbar spaces pages can store window gaps and taskbar margins independently. Changing a theme or mode can project different effective layout values.

## Layout controls

Each control is independent and lives on the page listed here:

- **Taskbar → Position** — taskbar position, top or bottom edge.
- **Taskbar → Spaces** — taskbar top, left, right and bottom margins, each from `0` to `100`. Sticky defaults the bottom margin to `2`; Spaced uses `18`.
- **Taskbar → Icons** — whether the taskbar utility group uses automatic or always-expanded behavior.
- **Hyprland → Window spaces** — inner gap and outer top/left/right/bottom gaps, each from `0` to `100`.
- **Hyprland → Borders** — general borders: enable rounded corners; when enabled, rounding is selectable from `2` to `10`. Edge thickness is set here too, from `0` to `10`.
- **Hyprland → Borders → Shadow** — the window shadow, off by default. It sets the range, render power, sharp corners, offsets and scale, and its color follows the theme accent with alpha `99` unless a color is typed.

These values are written to ARGVUS appearance state, and `argvus-config` projects them into the generated Hyprland files that the session then applies. A taskbar margin changes the shell surface's position; an outer window gap changes the tiled window area. They can produce a similar visual distance, but changing one does not change the other.

## Windows and workspaces

Tiled windows are arranged by Hyprland on the active workspace. ARGVUS also supports floating utility windows; `SUPER + SHIFT + Space` toggles the focused window between tiled and floating layouts. Workspace movement and window focus are controlled by the active keybinding manifest; see [Keyboard shortcuts](/docs/argvus-hyprland/keyboard-shortcuts/).

The packaged configuration opens the Control Center, Snake and Disk Usage Analyzer as floating, centered windows. Disk Usage Analyzer uses the same initial `1399 × 920` geometry as the taskbar memory popup, applied by its window class rule when the window opens. ARGVUS Focus and ARGVUS Clock are GTK layer-shell popups anchored beside the taskbar, so they are not tiled windows and do not use Hyprland window rules. The Clock alarm card is a separate layer surface (`argvus-clock-alarm`).

The Control Panel uses a full-monitor layer surface while its modal is open. The packaged rules float, center and pin the Polkit agent, GTK portal and KDialog windows so dialogs launched by the panel stay above the modal and can receive input.

`hyprpicker`, opened with `SUPER + P`, does not use Hyprland animations. This exception affects only the color picker; other animations continue to follow the global settings.

### Workspace placement for browsers and IDEs

No window rules are defined by default on a fresh install. You can add your own per-application workspace placement rules under `hyprland.window_rules` in `argvus-config`, for example:

```sh
argvus config get hyprland.window_rules
argvus config set hyprland.window_rules.browser.workspace 3
```

Each rule has a `workspace` from 1 to 10 and a `classes` list. Entries in `classes` are regular expressions matched against the window class (case sensitive), for example `[Cc]ode.*` or `jetbrains-.*`. Only letters, digits and `._*+?-[]()|^$` are accepted. `argvus-config` writes the rules to `generated/hypr/window-rules.lua`, which the Hyprland configuration loads. To replace the rules without changing the defaults, add `hl.window_rule` calls to `rules.lua` in your ARGVUS data directory; those load after the generated rules.

## What to change first

- If windows feel crowded, increase the window gap or use Spaced mode.
- If windows seem too far from the screen edge, reduce the outer/taskbar spacing or use Sticky mode.
- If the taskbar appears misaligned after changing its position, review taskbar position and all four taskbar/shell margins together.
- If windows overlap a visual panel, check the panel and taskbar layout settings before changing window gaps.

Changes are applied through the ARGVUS appearance/session integration. Use the page's reset action where available; do not edit generated Hyprland files directly.

## Related

- [Appearance](/docs/user-guide/appearance/)
- [Themes](/docs/user-guide/appearance/)
- [Taskbar](/docs/argvus-taskbar/taskbar/)
- [Control Panel](/docs/argvus-control-panel/)

## Window wobble

Open **Desktop & Input → Hyprland → Animations → Windows** and use the
**Wobble** controls. Search for `wobble`, or open the page directly:

```sh
argvus control-center hyprland animations windows
```

Wobble is disabled by default. Its ARGVUS defaults are stiffness `100`, damping
`10`, mass `1`, intensity `1` and mesh resolution `8`. Stiffness and mass accept
`0.0001–1000`, damping `0–1000`, intensity `0–2`, and mesh an integer `2–32`.
Higher mesh resolution increases rendering cost. Use the arrow keys to adjust
values or Enter to type them. **Restore Wobble defaults** changes the draft;
**Apply** saves all pending animation edits and reloads Hyprland once, without
restarting the session. Going back within Animations keeps the shared draft.

The global Animations switch suppresses Wobble while retaining its individual
settings. The canonical values live under `effects.wobble_*` in ARGVUS state;
`hypr/state.lua` is generated and must not be edited manually.

This requires Hyprland **0.57.0 or newer**, enforced by `argvus-hyprland`'s
package dependency. Version 0.56 is unsupported for this configuration. The
intensity maximum follows the [released 0.57.0 source](https://github.com/hyprwm/Hyprland/blob/v0.57.0/src/config/values/ConfigValues.cpp),
which limits it to `2`, even though newer documentation may list `3`.

## Global window mode

Open **Control Center → Desktop & Input → Hyprland → Window Rules** and select **Tile Windows (Default)** or **Floating Windows**. The same selector is available from the window-mode icon in the taskbar utility group.

The preference applies to every monitor and workspace and is remembered after logout. Floating converts existing application windows and newly opened windows. Tile restores only windows that this policy converted; dialogs and other windows that were already floating remain floating. A window explicitly pinned while Floating is active also remains floating to preserve its pin. The tiled layout is recalculated; its exact previous split tree is not restored.

`SUPER + SHIFT + Space` keeps its normal per-window behavior in Tile. In Floating it does not switch a window back to tiling. Panels, the taskbar and notifications are layer-shell surfaces and are not affected. Fullscreen continues to use Hyprland's normal behavior; ARGVUS maximization preserves margins in Spaced.

The canonical preference is `/hyprland/window_mode` in `$XDG_CONFIG_HOME/argvus/config/hyprland.json`. Its generated projection is `data/generated/hypr/window-mode.lua`; do not edit it. The per-window restoration registry lives under `$XDG_RUNTIME_DIR/argvus`, scoped to the compositor instance, and survives configuration reloads. It is not reused in a new session.

If application is pending or fails, the interface distinguishes this from the saved preference. Select the option again to retry. Without a compositor, the preference is saved for the next login.

## Window buttons and application bar

Floating mode adds an ARGVUS title bar with **Minimize**, **Maximize / Restore**, and **Close** to normal application windows. Double-clicking the title bar toggles maximization. The additional decoration is hidden in Tile and fullscreen. Applications that draw their own controls may display both bars; uniform ARGVUS controls are intentional.

A second Waybar appears on every monitor, on the edge opposite the main taskbar. It lists only the windows of that monitor's current workspace, including its minimized windows. Hidden group tabs do not create extra entries. Minimized entries retain their original monitor/workspace association. Click an entry to restore/activate it; its context menu offers restore, minimize, maximize/restore and close. Unknown application icons fall back to a window symbol. Activating or restoring an entry preserves the pointer position. The secondary bar uses the effective primary CSS (colors, fonts, border and rounding), with its height and mirrored margins on the opposite edge.

`SUPER + Alt + Up` places the main bar at the top and the window bar at the bottom. `SUPER + Alt + Down` does the reverse. Repeating a direction leaves the positions unchanged. Tile has only the main bar. Returning to Tile restores all minimized windows before removing the window bar, and then preserves the original tiled/floating policy.

Minimization uses the reserved `special:argvus-minimized` workspace. Do not use that workspace manually. The `argvus windows service` process records identity, original workspace/monitor, geometry, fullscreen/maximization and pin state in a compositor-instance-specific runtime registry under `$XDG_RUNTIME_DIR/argvus`. Records survive a service restart or config reload, but do not cross compositor sessions. Closing a window removes its record. If a monitor disappears, restoration uses an available output. A missing or failed recovery bar prevents new minimizations; failed restoration retains the record and recovery bar.

The session owns `argvus-windows.service` and `argvus-window-bar.service`. The latter keeps its Waybar child dormant in Tile. The hyprbars plugin is bundled by `argvus-hyprland`, built for the Hyprland 0.57.0 ABI on x86_64; it is not compiled in the user's home directory. Rebuild the plugin with a compositor ABI update.

Commands: `argvus windows list --json`, `watch --json`, `position top|bottom`, `restore-all`, and `minimize|restore|activate|maximize|close ADDRESS`. The window addresses come from the list. `position top --persist` stores/projects the preference without restarting the main bar. Configuration and runtime error details are written to the journal; visible action failures also show a translated notification.

In **Spaced + Floating**, windows respect outer gaps and the areas reserved by both bars. The bounds include the border and title, which sits inside the same window border. Maximizing through ARGVUS controls fills this area with margins; restoring recovers the previous geometry, including after a service restart. Fullscreen still uses the whole output. Floating windows may overlap; tiling inner gaps do not separate them.
