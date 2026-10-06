---
title: Windows and layout
description: Understand gaps, borders, modes and panel space in ARGVUS.
---

ARGVUS uses Hyprland for tiled and floating window placement. The user-facing layout controls are grouped in **Control Center → Appearance → Spaces, Borders & Position** and are also reflected by the Control Panel's corresponding appearance card.

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

## Sticky and Float modes

The bundled theme modes provide two starting geometries:

| Mode | Window behavior | Surface treatment |
| --- | --- | --- |
| Sticky | Internal gap `2`, outer gap `0` by default | Square, compact and close to the screen edge |
| Float | Internal gap `10`, outer gap `18` by default | Rounded, shadowed and more spacious; taskbar/shell margin defaults to `18` |

These are defaults, not limits. The Spaces, Borders & Position page can store edge gaps and taskbar margins independently. Changing a theme or mode can project different effective layout values.

## Spaces, Borders & Position controls

The page exposes these independent controls:

- **Taskbar position** — top or bottom edge.
- **Taskbar spaces** — top, left, right and bottom margins, each from `0` to `100`.
- **Window spaces** — inner gap and outer top/left/right/bottom gaps, each from `0` to `100`.
- **General borders** — enable rounded corners; when enabled, rounding is selectable from `2` to `10`.
- **Edge thickness** — border thickness from `0` to `10`.
- **Utility group** — whether the taskbar utility group uses automatic or always-expanded behavior.

These values are written to ARGVUS appearance state, and `argvus-config` projects them into the generated Hyprland files that the session then applies. A taskbar margin changes the shell surface's position; an outer window gap changes the tiled window area. They can produce a similar visual distance, but changing one does not change the other.

## Windows and workspaces

Tiled windows are arranged by Hyprland on the active workspace. ARGVUS also supports floating utility windows; `SUPER + SHIFT + Space` toggles the focused window between tiled and floating layouts. Workspace movement and window focus are controlled by the active keybinding manifest; see [Keyboard shortcuts](/docs/argvus-hyprland/keyboard-shortcuts/).

### Workspace placement for browsers and IDEs

New windows of browsers open on workspace 2 and IDEs open on workspace 1 by default. The rules live in `hyprland.window_rules` in `argvus-config`:

```sh
argvus-config get hyprland.window_rules
argvus-config set hyprland.window_rules.browser.workspace 3
```

Each rule has a `workspace` from 1 to 10 and a `classes` list. Entries in `classes` are regular expressions matched against the window class (case sensitive), for example `[Cc]ode.*` or `jetbrains-.*`. Only letters, digits and `._*+?-[]()|^$` are accepted. `argvus-config` writes the rules to `generated/hypr/window-rules.lua`, which the Hyprland configuration loads. To replace the rules without changing the defaults, add `hl.window_rule` calls to `rules.lua` in your ARGVUS data directory; those load after the generated rules.

## What to change first

- If windows feel crowded, increase the window gap or use Float mode.
- If windows seem too far from the screen edge, reduce the outer/taskbar spacing or use Sticky mode.
- If the taskbar appears misaligned after changing its position, review taskbar position and all four taskbar/shell margins together.
- If windows overlap a visual panel, check the panel and taskbar layout settings before changing window gaps.

Changes are applied through the ARGVUS appearance/session integration. Use the page's reset action where available; do not edit generated Hyprland files directly.

## Related

- [Appearance](/docs/user-guide/appearance/)
- [Themes](/docs/argvus-themes/)
- [Taskbar](/docs/argvus-taskbar/taskbar/)
- [Control Panel](/docs/argvus-control-panel/)
