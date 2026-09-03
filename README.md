# argvus-shell

Quickshell control panel, Waybar taskbar/sysinfo, rofi/wofi shell menus,
sidebar, cards and QML themes for ARGVUS.

This package owns the frontend shell files currently used by `argvus-sessionctl run shell`:

- `/usr/share/argvus/quickshell/argvus-control-panel`
- `/usr/share/argvus/waybar`
- `/usr/share/argvus/rofi`
- `/usr/share/argvus/wofi`
- `/usr/share/argvus/scripts/argvus/toggle-sidebar.sh`

The package intentionally keeps compatibility with `/usr/share/argvus` while the ARGVUS desktop is split into smaller component packages.

## Runtime Boundary

`argvus-shell` is a frontend package. It owns the ARGVUS taskbar config, but
`argvus-waybar` owns the patched Waybar binary/package. It may expose controls
for appearance, Bluetooth, display, notifications, power, default apps and
session actions, but the domain logic for those controls belongs to the matching
ARGVUS component package. Long-lived runtime lifecycle continues to flow through
`argvus-sessionctl` and `argvus-shell.service` from `argvus-session`.

## Install

```sh
make DESTDIR=/tmp/argvus-shell-dest PREFIX=/usr install
```

This installs shell UI assets under:

```text
/tmp/argvus-shell-dest/usr/share/argvus/quickshell/argvus-control-panel
/tmp/argvus-shell-dest/usr/share/argvus/waybar
/tmp/argvus-shell-dest/usr/share/argvus/rofi
/tmp/argvus-shell-dest/usr/share/argvus/wofi
```

and the sidebar toggle compatibility helper under:

```text
/tmp/argvus-shell-dest/usr/share/argvus/scripts/argvus/toggle-sidebar.sh
```

## Validate

```sh
make validate
```

Validation runs `sh -n`, `shellcheck` when available, and `qmllint` when available.

## Ecosystem Plan

Read the ecosystem plan before moving ownership boundaries:

```text
/home/boss/Projects/github/organizations/argvus/argvus-session/tmp/AGENT_PLAN.md
```
