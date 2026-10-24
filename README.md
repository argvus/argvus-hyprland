# argvus-hyprland

<div align="center">

[![CI](https://github.com/argvus/argvus-hyprland/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/argvus/argvus-hyprland/actions/workflows/ci.yml)
[![License](https://img.shields.io/github/license/argvus/argvus-hyprland)](./LICENSE)
[![Language: Shell](https://img.shields.io/badge/Shell-POSIX-4EAA25?logo=gnubash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Platform: Arch Linux | Wayland](https://img.shields.io/badge/platform-Arch%20Linux%20%7C%20Wayland-1793D1?logo=archlinux&logoColor=white)](https://archlinux.org/)
[![Compositor: Hyprland 0.56.2](https://img.shields.io/badge/compositor-Hyprland%200.56.2-58E1FF)](https://hyprland.org/)
[![Pull requests](https://img.shields.io/github/issues-pr/argvus/argvus-hyprland)](https://github.com/argvus/argvus-hyprland/pulls)
[![Issues](https://img.shields.io/github/issues/argvus/argvus-hyprland)](https://github.com/argvus/argvus-hyprland/issues)
[![Last commit](https://img.shields.io/github/last-commit/argvus/argvus-hyprland)](https://github.com/argvus/argvus-hyprland/commits/main)
[![Docs](https://img.shields.io/badge/docs-project-blue)](./docs/)

</div>

Hyprland configuration and Hyprland-specific scripts for the ARGVUS desktop.

The package owns the compositor configuration and assets under
`/usr/share/argvus/hyprland`. Session lifecycle remains owned by
`argvus-session` and is controlled through `argvus sessionctl`.

## Build and validate

```sh
make validate
make build
```

`make build` creates the local source archive and package under `build/`, using
the standard Arch packaging layout in `packaging/arch/{ci,local}`.

The installed payload contains `config/hyprland.lua`, the Hyprland cheatsheets,
and the compositor-specific shell scripts. The shared `/usr/share/argvus`
namespace is intentional because ARGVUS components are packaged separately.

## Contributing and policies

- [CONTRIBUTING.md](https://github.com/argvus/.github/blob/main/CONTRIBUTING.md) — contribution workflow
- [SECURITY.md](https://github.com/argvus/.github/blob/main/SECURITY.md) — private vulnerability reports
- [Code of Conduct](https://github.com/argvus/.github/blob/main/policies/CODE_OF_CONDUCT.md) — community standards
- [AI usage policy](https://github.com/argvus/.github/blob/main/policies/IA_USAGE.md) — rules for AI-assisted contributions
