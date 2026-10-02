---
title: Keyboard shortcuts
description: Find the shortcuts provided by the ARGVUS Hyprland configuration.
---

Open **Control Center → Locale & Region → Keyboard shortcuts**, or run `argvus-control-center keybindings`.

## What the page does

The page searches and groups the active keybinding manifest. You can select a binding, edit its key combination, capture a new combination, enable or disable a configurable binding and restore all shortcuts from the page's restore action. A shortcut must contain a non-modifier key; the editor normalizes names such as Super/Win, Ctrl, Alt, Shift, arrows, function keys and media keys. `SUPER + Y` opens **Control Center → Appearance → Wallpapers**.

Changes are stored in `config.json` under `/keyboard_shortcuts`; the generated Hyprland fragment is written below `~/.config/argvus/data/generated/hypr/`. A disabled shortcut is represented by `null`. Keys are stable English config keys, independent of the selected locale: a manifest ID such as `window.close` maps to `close_window`, while `window.drag_mouse` maps to `drag_window__floating_window_only`. The old `/hyprland/keybindings` section and `keybindings.toml` are migration-only. ARGVUS schedules a session reload only when the projection plan reports a real change.

The editor changes bindings already present in the ARGVUS manifest. To add a completely new manual binding or compositor action, use [`bindings.lua`](./hyprland-overrides/) instead of editing the generated fragment.

## Current reference

The base manifest and installed cheatsheets are under `/usr/share/argvus/hyprland/`. The active user override is not a replacement manifest: it changes the entries selected in Control Center. This is why a version-specific, manually copied list can become stale.

Some useful built-in actions include moving focus and workspaces, toggling floating windows, screenshots and recording, opening the launcher/terminal, changing appearance, locking the session, controlling media and reloading Hyprland. The complete list belongs to the installed manifest and can be searched in Control Center.

`SUPER + Shift + R` is the explicit runtime reload: it reloads Hyprland and restarts the ARGVUS taskbar, Control Panel and Widget Telemetry services. Configuration-driven reloads remain conditional and skip the graphical reload when the canonical state is unchanged.

See [Windows and layout](./windows-and-layout/) for floating and workspace behavior and [Control Center](../control-center/) for the settings workflow.
