# argvus-hyprland

Hyprland configuration and Hyprland-specific scripts for ARGVUS.

This package owns `/usr/share/argvus/hypr/hyprland.lua` and the Hyprland
integration scripts. Session lifecycle remains owned by `argvus-session` and
is controlled through `argvus-sessionctl`.

This package owns the Hyprland-specific assets:

- `/usr/share/argvus/hypr/hyprland.lua`
- `/usr/share/argvus/hypr/docs`
- `/usr/share/argvus/scripts/argvus/spaces-switch.sh`
- `/usr/share/argvus/scripts/apps/hypr-screenshot.sh`
- `/usr/share/argvus/scripts/apps/cheatsheets.sh`

The package intentionally keeps compatibility with `/usr/share/argvus` while the ARGVUS desktop is split into smaller component packages.

## Runtime Boundary

The shared `/usr/share/argvus` namespace is intentional. `argvus-session` owns
the session launcher, lifecycle controller and systemd user units; its
`argvus-start` command consumes the packaged Lua configuration from this
package. Runtime reloads continue through `argvus-sessionctl` when the session
package is installed, but the compositor configuration itself does not depend
on the session manager.

## Install

```sh
make DESTDIR=/tmp/argvus-hyprland-dest PREFIX=/usr install
```

This installs Hyprland assets under:

```text
/tmp/argvus-hyprland-dest/usr/share/argvus/hypr/hyprland.lua
/tmp/argvus-hyprland-dest/usr/share/argvus/scripts/argvus/spaces-switch.sh
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
