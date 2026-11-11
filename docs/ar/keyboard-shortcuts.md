---
title: Keyboard shortcuts
description: ARGVUS Hyprland.  ﻦﻳﻮﻜﺗ ﺔﻄﺳﺍﻮﺑ ﺔﻣﺪﻘﻤﻟﺍ ﺕﺍﺭﺎﺼﺘﺧﻻ﻿ﺍ ﻦﻋ ﺚﺤﺑﺍ
---

.argvus control-center keybindings ﻞﻴﻐﺸﺘﺑ ﻢﻗ ﻭﺃ ،**ﺢﻴﺗﺎﻔﻤﻟﺍ ﺔﺣﻮﻟ ﺕﺍﺭﺎﺼﺘﺧﺍ → ﻝﺎﺧﺩﻹ﻿ﺍﻭ ﺐﺘﻜﻤﻟﺍ ﺢﻄﺳ

## ﺔﺤﻔﺼﻟﺍ ﻪﻠﻌﻔﺗ ﻱﺬﻟﺍ ﺎﻣ







Custom shortcuts can be edited, enabled/disabled and deleted with confirmation. Conflicts with enabled shortcuts in the same context require replacement confirmation; protected bindings cannot be replaced. Restoring official defaults preserves custom records. If restoring would collide with an active custom shortcut, change or disable that custom shortcut first. Custom definitions are stored under `argvus control-center keybindings` in `SUPER + Y`. The generated `$XDG_CONFIG_HOME/argvus/config/keyboard_shortcuts.json` is loaded with the existing protected loader; invalid registrations are logged without aborting the rest of the configuration. Save failures preserve the draft; application failures report that the record was saved and can be retried.

.ﺎﻫﺅﺎﺸﻧﺇ ﻢﺗ ﻲﺘﻟﺍ ءﺍﺰﺟﻷ﻿ﺍ ﺮﻳﺮﺤﺘﺑ

## ﻲﻟﺎﺤﻟﺍ ﻊﺟﺮﻤﻟﺍ





`/keyboard_shortcuts` is the explicit runtime reload: it reloads Hyprland and restarts the ARGVUS taskbar, Control Panel and Widget Telemetry services. Configuration-driven reloads remain conditional and skip the graphical reload when the canonical state is unchanged.

## ﻲﺿﺍﺮﺘﻓﻻ﻿ﺍ ﺕﺍﺭﺎﺼﺘﺧﻻ﻿ﺍ ﻝﻭﺪﺟ

The table lists the bindings of the base manifest (`~/.config/argvus/data/generated/hypr/` /usr/share/argvus/hyprland/keybindings.json  SUPER + Shift + R  /usr/share/argvus/hyprland/  bindings.lua  argvus control-center shortcuts list  argvus control-center shortcuts create  data/generated/hypr/custom-shortcuts.lua  $XDG_CONFIG_HOME/argvus/config/hyprland.json  /hyprland/custom_shortcuts  Esc  {"action":"toggle"}  window.float  keybindings.toml  /hyprland/keybindings  drag_window__floating_window_only  window.drag_mouse  close_window  window.close  `null` ) with their default keys. Your own changes in Control Center replace the keys shown here for the affected bindings, and disabled bindings do not run.

### Navigation

| Shortcut | Description |
| --- | --- |
|  `window.close`  `close_window`  `window.drag_mouse`  `drag_window__floating_window_only`  `/hyprland/keybindings`  `keybindings.toml`  `window.float`  `{"action":"toggle"}`  `Esc`  `/hyprland/custom_shortcuts`  `$XDG_CONFIG_HOME/argvus/config/hyprland.json`  `data/generated/hypr/custom-shortcuts.lua`  `argvus control-center shortcuts create`  `argvus control-center shortcuts list`  `bindings.lua`  `/usr/share/argvus/hyprland/`  `SUPER + Shift + R`  `/usr/share/argvus/hyprland/keybindings.json` `SUPER + Left Arrow` | Focus tiled window by direction |
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
| `SUPER + CTRL + 1` to `SUPER + CTRL + 9`                                              ﻦﻣ ﻊﺿﻮﻤﻟﺍ ﻚﻟﺫ ﻲﻓ ﻉﻭﺮﺸﻤﻟﺍ ﺢﺘﻔﻳ | `argvus projects` |
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
| `SUPER + [`| (ﺎﻬﺋﺎﻔﺧﻹ﻿ ﻯﺮﺧﺃ ﺓﺮﻣ ﻂﻐﺿﺍ ؛ﺔﺻﺎﺧ ﻞﻤﻋ ﺔﺣﺎﺴﻣ ﻲﻓ ﺔﻟﺪﺴﻨﻣ ﺔﻤﺋﺎﻗ) ﺔﻴﻓﺮﻄﻟﺍ ﺕﺎﻈﺣﻼ﻿ﻣ ﺮﺘﻓﺩ 
| `SUPER + Space` | File Manager |
| `SUPER + CTRL + Space` | System monitor |
| `SUPER + Shift + D` | Removable devices menu |
| `SUPER + Shift + F` | ARGVUS Focus (Pomodoro and focus sessions) |
| `SUPER + Shift + C` | ARGVUS Clock (clock, timers and alarms) |
| `SUPER + D` | Program Launcher |
| `SUPER + B` | Default Browser |
| `SUPER + C` | Calculator |
| `SUPER + ALT + S` | SSH host picker (`argvus ssh`) |
| `SUPER + ALT + N` | Snippet picker (`argvus snippets`) |
| `SUPER + ALT + G`) ﺭﺎﺘﺨﻤﻟﺍ ﻉﻭﺮﺸﻤﻟﺍ ﻲﻓ (gitui ﻭﺃ lazygit) git ـﻟ ﺔﻴﺼﻨﻟﺍ ﻡﺪﺨﺘﺴﻤﻟﺍ ﺔﻬﺟﺍﻭ ﻢﺛ ،ﻉﻭﺮﺸﻤ`argvus git`) |

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

### ﻞﻴﺠﺴﺗﻭ ﺔﺷﺎﺸﻟﺍ ﺕﺎﻄﻘﻟ

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
| `SUPER + Shift + M` | Open Sticky/Spaced mode picker |
| `SUPER + F5`                          | ﺢﺗﺎﻔﻟﺍ ARGVUS ﻭ ﻦﻛﺍﺪﻟﺍ ARGVUS ﺕﺎﻤﻴﺛ ﻦﻴﺑ ﻞﻳﺪﺒﺘﻟﺍ | 
| `SUPER + F6` | Toggle animations |
| `SUPER + Shift + B` | Open brightness selector and Night Light toggle |

### (SUPER + R ﺪﻌﺑ) ﻢﺠﺤﻟﺍ ﺮﻴﻴﻐﺗ ﻊﺿﻭ

.ﻊﺿﻮﻟﺍ ﻙﺮﺘﻳ Enter ﻭﺃ `Esc` .ﻢﺠﺤﻟﺍ ﺮﻴﻴﻐﺗ ﻊﺿﻭ ﻞﻴﻌﻔﺗ ءﺎﻨﺛ

| Shortcut | Description |
| --- | --- |
|  `Enter` `Right Arrow` | Resize |
| `Left Arrow` | Resize |
| `Up Arrow` | Resize |
| `Down Arrow` | Resize |
| `Shift + Right Arrow` | Move window |
| `Shift + Left Arrow` | Move window |
| `Shift + Up Arrow` | Move window |
| `Shift + Down Arrow` | Move window |
| `escape` | Exit resize mode |
| `Enter` | Exit resize mode |


See [Windows and layout](/docs/argvus-hyprland/hyprland-overrides/) for floating and workspace behavior and [Control Center](#default-shortcut-table) for the settings workflow.

## ﻞﻴﻠﻟﺍ ءﻮﺿ

**SUPER + Shift + B** ءﺍﺮﺟﺈﺑ ﻆﻔﺘﺤﻳ `appearance.brightness` ﻲﻓ ﻉﻮﻄﺴﻟﺍ ﺔﻤﺋﺎﻗ ﻡﺪﻘﻳ ﺎﻤﻛ 








## 

.ﻡﺎﻋ ﻞﻜﺸﺑ Hyprland ﻰﻠﻋ ﺎﻬﻘﻴﺒﻄﺗ ﻦﻣ ًﻻ﻿ﺪﺑ ،**ﻡﺰﺤﻟﺍ < ﻡﺎﻈﻨﻟﺍ ﺓﺭﺍﺩﺇ < ﻢﻜﺤﺘﻟﺍ ﺰﻛﺮﻣ** `F8`                                                       ،ﺔﻠﻣﺎﻌﻤﻟﺍ ﺔﻄﺤﻣ ﺢﺘﻓ ﺪﻴﻌﻳ`Esc`                                                      ،ﺔﻴﻠﻤﻌﻟﺍ ﻑﺎﻘﻳﺇ ﻥﻭﺩ ﻪﻴﻔﺨﻳ`Shift+PageUp/PageDown`                                                                 ﺮﻳﺮﻤﺘﻟﺍ ﺦﻳﺭﺎﺗ`Shift+End`                                                        ﻭ ﻲﺤﻟﺍ ﺝﺍﺮﺧﻹ﻿ﺍ ﻰﻟﺇ ﺩﻮﻌﻳ`Ctrl+C`                     .ﺢﻴﺗﺎﻔﻤﻟﺍ ﺲﻔﻧ ﺔﺘﺒﺜﻤﻟﺍ ﺶﻐﻟﺍ ﺔﻗﺭﻭ ﻦﻤﻀﺘﺗ .ﺰﻛﺮﻤﻟﺍ ﻞﻔﻄﻟﺍ ﻊﻃﺎﻘﻳ

                                                                     ،ﻡﺰﺤﻟﺍ ﻲﻓ`/`                                               .ﻱﻮﻠﻌﻟﺍ **ﺚﺤﺒﻟﺍ** ﻂﻳﺮﺷ ﻰﻠﻋ ﺰﻛﺮﻳ`Enter`.ﺔﺑﺎﺘﻜﻟﺍ ءﺎﻨﺛﺃ ﺚﻳﺪﺤﺘﻟﺍﻭ ﺔﻟﺍﺯﻹ﻿ﺍ ﻢﺋﺍﻮﻗ ﺔﻴﻔﺼﺗ ؛ AUR / ﻲﻤﺳﺮﻟﺍ ﺖﻴﺒﺜﺘﻟﺍ ﻦﻋ ﺚﺤﺒﻟﺍ ﺕﺎﻴ`Down`                                                            ،ﺞﺋﺎﺘﻨﻟﺍ ﻰﻟﺇ ﻞﻘﺘﻨﻳ`Up`                                           ﻭ ،ﺚﺤﺒﻟﺍ ﻰﻟﺇ ﺩﻮﻌﻳ ﻰﻟﻭﻷ﻿ﺍ ﺔﺠﻴﺘﻨﻟﺍ ﻰﻠﻋ`Esc`.ﺎﻬﺑ ﺔﺻﺎﺨﻟﺍ ﺔﻣﺰﺤﻟﺍ ءﺍﺮﺟﺇ ﺬﻔﻨﻳ ﺔﺠﻴﺘﻧ ﻰﻠﻋ ﻂﻐﻀﻟﺍ .ﺔﻤﺋﺎﻘﻟﺍ ﻰﻟﺇ ﺩﻮﻌﻳﻭ ﻡﻼ﻿ﻌﺘﺳﻻ﻿ﺍ ﻆﻔﺤﻳ 

Run argvus control-center shortcuts create or argvus control-center shortcuts list to open either page. For advanced submaps, mouse bindings or flags, [bindings.lua](/docs/argvus-hyprland/windows-and-layout/) remains available. Never edit the generated fragments.

Some useful built-in actions include moving focus and workspaces, toggling floating windows, screenshots and recording, opening the launcher/terminal, changing appearance, locking the session, controlling media and reloading Hyprland. The default bindings are listed in the [default shortcut table](/docs/components/argvus-control-center/) below; the Control Center page shows the bindings as they are currently configured.
