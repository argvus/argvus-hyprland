---
title: Mouse and touchpad
description: Configure pointer and touchpad behavior in ARGVUS.
---

Open **Control Center → Locale & Region → Mouse & Touchpad**, or run `argvus-control-center input`.

## Mouse

When a mouse is detected, the page exposes:

- sensitivity from `-1.0` to `1.0`;
- adaptive or flat acceleration profile;
- scroll factor from `0.1` to `10.0`;
- natural scrolling;
- left-handed button layout.

Sensitivity, scroll factor and the toggles apply through Hyprland while the page is open, then the complete input state is saved. The page reads the current compositor value when no ARGVUS input file exists.

## Touchpad

When a touchpad is detected, the page exposes natural scrolling, tap to click, tap-and-drag, two-finger right click and disable-while-typing. These options are only shown as useful controls when the running session reports a touchpad.

## Hardware-dependent controls

Advanced mouse controls backed by `ratbag` are shown only for supported devices. ARGVUS does not claim that every mouse supports DPI, profiles or polling changes. If a device is not detected or the optional device service is unavailable, those controls cannot be applied by this page.

## Persistence and reset

The settings are stored as user state and a generated Hyprland input fragment is regenerated for the session. Use the page's reset action when present; do not edit the generated fragment directly. A setting can apply only to the current compositor when the session cannot reload the relevant device state.

See [Control Center](../control-center/) and [Where to configure things](../where-to-configure/).
