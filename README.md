# argvus-hyprland

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
