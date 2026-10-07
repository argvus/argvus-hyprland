---
title: Keyboard shortcuts
description: Find the shortcuts provided by the ARGVUS Hyprland configuration.
---

Open **Control Center → Locale & Region → Keyboard shortcuts**, or run `argvus-control-center keybindings`.

## What the page does

The page searches and groups the active keybinding manifest. You can select a binding, edit its key combination, capture a new combination, enable or disable a configurable binding and restore all shortcuts from the page's restore action. A shortcut must contain a non-modifier key; the editor normalizes names such as Super/Win, Ctrl, Alt, Shift, arrows, function keys and media keys. `SUPER + Y` opens **Control Center → Appearance → Wallpapers**.

Changes are stored in `config.json` under `/keyboard_shortcuts`; the generated Hyprland fragment is written below `~/.config/argvus/data/generated/hypr/`. A disabled shortcut is represented by `null`. Keys are stable English config keys, independent of the selected locale: a manifest ID such as `window.close` maps to `close_window`, while `window.drag_mouse` maps to `drag_window__floating_window_only`. The old `/hyprland/keybindings` section and `keybindings.toml` are migration-only. ARGVUS schedules a session reload only when the projection plan reports a real change.

The editor changes bindings already present in the ARGVUS manifest. To add a completely new manual binding or compositor action, use [`bindings.lua`](/docs/argvus-hyprland/hyprland-overrides/) instead of editing the generated fragment.

## Current reference

The base manifest and installed cheatsheets are under `/usr/share/argvus/hyprland/`. The active user override is not a replacement manifest: it changes the entries selected in Control Center. This is why a version-specific, manually copied list can become stale.

Some useful built-in actions include moving focus and workspaces, toggling floating windows, screenshots and recording, opening the launcher/terminal, changing appearance, locking the session, controlling media and reloading Hyprland. The default bindings are listed in the [default shortcut table](#default-shortcut-table) below; the Control Center page shows the bindings as they are currently configured.

`SUPER + Shift + R` is the explicit runtime reload: it reloads Hyprland and restarts the ARGVUS taskbar, Control Panel and Widget Telemetry services. Configuration-driven reloads remain conditional and skip the graphical reload when the canonical state is unchanged.

## Default shortcut table

The table lists the bindings of the base manifest (`/usr/share/argvus/hyprland/keybindings.json`) with their default keys. Your own changes in Control Center replace the keys shown here for the affected bindings, and disabled bindings do not run.

### Navigation

| Shortcut | Description |
| --- | --- |
| `ALT + Tab` | Cycle through all windows |
| `ALT + Shift + Tab` | Cycle through all windows |
| `SUPER + Left Arrow` | Focus tiled window by direction |
| `SUPER + Right Arrow` | Focus tiled window by direction |
| `SUPER + Up Arrow` | Focus tiled window by direction |
| `SUPER + Down Arrow` | Focus tiled window by direction |
| `SUPER + CTRL + Left Arrow` | Cycle focus between windows (tiled and floating) |
| `SUPER + CTRL + Right Arrow` | Cycle focus between windows (tiled and floating) |

### Workspaces

| Shortcut | Description |
| --- | --- |
| `CTRL + ALT + Right Arrow` | Moving between work areas |
| `CTRL + ALT + Left Arrow` | Moving between work areas |
| `Mouse extra button (mouse:276)` | Moving between work areas |
| `Mouse side button (mouse:275)` | Moving between work areas |
| `SUPER + 1` | Workspace 1 |
| `SUPER + 2` | Workspace 2 |
| `SUPER + 3` | Workspace 3 |
| `SUPER + 4` | Workspace 4 |
| `SUPER + 5` | Workspace 5 |
| `SUPER + 6` | Workspace 6 |
| `SUPER + 7` | Workspace 7 |
| `SUPER + 8` | Workspace 8 |
| `SUPER + 9` | Workspace 9 |
| `SUPER + ALT + 1` to `SUPER + ALT + 9` | Opens the project in that position of `argvus-projects` |
| `SUPER + Shift + 1` | Move window to desktop 1 |
| `SUPER + Shift + 2` | Move window to desktop 2 |
| `SUPER + Shift + 3` | Move window to desktop 3 |
| `SUPER + Shift + 4` | Move window to desktop 4 |
| `SUPER + Shift + 5` | Move window to desktop 5 |
| `SUPER + Shift + 6` | Move window to desktop 6 |
| `SUPER + Shift + 7` | Move window to desktop 7 |
| `SUPER + Shift + 8` | Move window to desktop 8 |
| `SUPER + Shift + 9` | Move window to desktop 9 |

### Windows

| Shortcut | Description |
| --- | --- |
| `SUPER + S` | Maximize window (toggle) |
| `SUPER + Q` | Close window |
| `SUPER + Shift + Space` | Enable/Disable Floating Window |
| `SUPER + F` | Full screen window |
| `SUPER + E` | Split vertical/horizontal toggle |
| `SUPER + W` | Group/Ungroup into tabs |
| `SUPER + Tab` | Navigate between tabs |
| `SUPER + Shift + Left Arrow` | Move window |
| `SUPER + Shift + Right Arrow` | Move window |
| `SUPER + Shift + Up Arrow` | Move window |
| `SUPER + Shift + Down Arrow` | Move window |
| `SUPER + Left mouse button (mouse:272)` | Drag window (floating window only) |
| `SUPER + Right mouse button (mouse:273)` | Window resize mode (floating window only) |
| `SUPER + R` | Enter window resize mode (floating window only) |

### Applications

| Shortcut | Description |
| --- | --- |
| `SUPER + Enter` | Terminal |
| `SUPER + [` | Terminal scratchpad (dropdown on a special workspace; press again to hide) |
| `SUPER + Space` | File Manager |
| `SUPER + CTRL + Space` | System monitor |
| `SUPER + Shift + D` | Removable devices menu |
| `SUPER + D` | Program Launcher |
| `SUPER + B` | Default Browser |
| `SUPER + C` | Calculator |

### Media

| Shortcut | Description |
| --- | --- |
| `XF86AudioRaiseVolume` | Volume up |
| `Volume Down` | Volume down |
| `Mute` | Mute |
| `Brightness Up` | Brightness up |
| `Brightness Down` | Brightness down |
| `Play/Pause` | Play/Pause |
| `Next Track` | Next track |
| `Previous Track` | Previous track |
| `Stop` | Stop track |

### Screenshots and recording

| Shortcut | Description |
| --- | --- |
| `Print` | Capture selected area |
| `SUPER + Print` | Capture focused window |
| `SUPER + Shift + Print` | Capture entire screen |
| `SUPER + G` | Start/Pause/Resume screen recording |
| `SUPER + Shift + G` | Stop and save screen recording |

### Session

| Shortcut | Description |
| --- | --- |
| `SUPER + L` | Lock system |
| `SUPER + escape` | Exit system |
| `SUPER + Shift + R` | Reload Hyprland |
| `SUPER + Shift + S` | Turn monitor off/on (not suspend system) |
| `SUPER + Shift + L` | Choose inactivity lock timeout |
| `SUPER + ALT + W` | Toggle Keep Awake |

### System

| Shortcut | Description |
| --- | --- |
| `SUPER + Shift + /` | Hyprland Cheatsheets |
| `SUPER + CTRL + /` | Kitty Cheatsheets |
| `SUPER + F1` | Open About ARGVUS |
| `SUPER + ALT + C` | Open Control Center |
| `SUPER + P` | Color Picker |
| `SUPER + .` | Emoji Picker |
| `SUPER + H` | Clipboard History |
| `SUPER + Shift + H` | Clear Clipboard History |

### Widgets

| Shortcut | Description |
| --- | --- |
| `SUPER + ,` | Open/Close notification sidebar |
| `Middle mouse button (mouse:274)` | Open/Close notification sidebar |
| `SUPER + Backspace` | Toggle Waybar top |
| `SUPER + Shift + W` | Configure weather location |
| `SUPER + ALT + Up Arrow` | Move taskbar to top |
| `SUPER + ALT + Down Arrow` | Move taskbar to bottom |

### Appearance

| Shortcut | Description |
| --- | --- |
| `SUPER + Y` | Open Control Center wallpapers |
| `SUPER + Shift + T` | Open theme selector |
| `SUPER + Shift + M` | Open Sticky/Float mode picker |
| `SUPER + F5` | Toggle GTK Dark and Light themes |
| `SUPER + F6` | Toggle animations |
| `SUPER + Shift + B` | Open brightness selector |

### Resize mode (after SUPER + R)

These shortcuts work only while resize mode is active. `Esc` or `Enter` leaves the mode.

| Shortcut | Description |
| --- | --- |
| `Right Arrow` | Resize |
| `Left Arrow` | Resize |
| `Up Arrow` | Resize |
| `Down Arrow` | Resize |
| `Shift + Right Arrow` | Move window |
| `Shift + Left Arrow` | Move window |
| `Shift + Up Arrow` | Move window |
| `Shift + Down Arrow` | Move window |
| `escape` | Exit resize mode |
| `Enter` | Exit resize mode |


See [Windows and layout](/docs/argvus-hyprland/windows-and-layout/) for floating and workspace behavior and [Control Center](/docs/argvus-control-center/) for the settings workflow.
