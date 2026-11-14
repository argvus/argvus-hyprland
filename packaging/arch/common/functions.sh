#!/usr/bin/env bash
# shellcheck shell=bash
# shellcheck disable=SC2154
# srcdir, pkgdir, pkgname, and pkgver are supplied by makepkg.

arch_normalize_source_tree() {
	local expected="${srcdir}/${pkgname}-${pkgver}"
	local -a roots=()

	while IFS= read -r -d '' root; do
		roots+=("$root")
	done < <(find "$srcdir" -mindepth 1 -maxdepth 1 -type d -print0)

	if (( ${#roots[@]} != 1 )); then
		printf 'error: expected exactly one extracted source directory in %s\n' "$srcdir" >&2
		return 1
	fi

	if [[ "${roots[0]}" != "$expected" ]]; then
		[[ ! -e "$expected" ]] || {
			printf 'error: source destination already exists: %s\n' "$expected" >&2
			return 1
		}
		mv -- "${roots[0]}" "$expected"
	fi
}

arch_check_hyprland_payload() {
	local source_root="${srcdir}/${pkgname}-${pkgver}"

	test -f "${source_root}/src/usr/share/argvus/hyprland/config/hyprland.lua"
	test -f "${source_root}/src/usr/share/argvus/hyprland/keybindings.json"
	test -f "${source_root}/src/usr/share/libalpm/hooks/95-argvus-ai-hyprland.hook"
	jq -e '
      (.version == 1) and (.bindings | type == "array") and
      (all(.bindings[]; (.id | type == "string" and length > 0) and
        (.category | type == "string" and length > 0) and
        (.description_key | type == "string" and length > 0) and
        (.keys | type == "string" and length > 0) and
        (.action | type == "string" and length > 0))) and
      (all(.bindings[].flags[]?; . == "locked" or . == "repeating" or . == "release" or . == "mouse")) and
      (([.bindings[].id] | length) == ([.bindings[].id] | unique | length))
    ' "${source_root}/src/usr/share/argvus/hyprland/keybindings.json" >/dev/null
	test -d "${source_root}/src/usr/share/argvus/hyprland/docs"
	test -d "${source_root}/src/usr/share/argvus/hyprland/sh"
	find "${source_root}/src/usr/share/argvus/hyprland/sh" -type f -name '*.sh' -exec test -x {} \;
}

arch_package_hyprland_payload() {
	local source_root="${srcdir}/${pkgname}-${pkgver}"
  local compositor_package dependency
  compositor_package="$(pacman -Q hyprland)" || return 1
  compositor_package="${compositor_package#hyprland }"
  for dependency in "${!depends[@]}"; do
    if [[ "${depends[dependency]}" == hyprland* ]]; then
      depends[dependency]="hyprland=${compositor_package}"
    fi
  done

	install -Dm755 "${srcdir}/hyprland-plugins-${_plugins_commit}/hyprbars/hyprbars.so" \
		"${pkgdir}/usr/lib/argvus/hyprland/hyprbars.so"
	install -Dm644 "${srcdir}/hyprland-plugins-${_plugins_commit}/LICENSE" \
		"${pkgdir}/usr/share/licenses/${pkgname}/hyprbars-LICENSE"
	install -Dm644 "${source_root}/src/usr/share/argvus/theme/consumers.d/window-controls.toml" \
		"${pkgdir}/usr/share/argvus/theme/consumers.d/window-controls.toml"
	install -dm755 "${pkgdir}/usr/share/argvus/hyprland"
	cp -a "${source_root}/src/usr/share/argvus/hyprland/." \
		"${pkgdir}/usr/share/argvus/hyprland/"
	find "${pkgdir}/usr/share/argvus/hyprland" -type f -name '*.sh' -exec chmod 755 {} +
	install -Dm644 "${source_root}/src/usr/share/libalpm/hooks/95-argvus-ai-hyprland.hook" \
		"${pkgdir}/usr/share/libalpm/hooks/95-argvus-ai-hyprland.hook"
	install -Dm644 "${source_root}/src/usr/share/libalpm/hooks/96-argvus-hyprland-reload.hook" \
		"${pkgdir}/usr/share/libalpm/hooks/96-argvus-hyprland-reload.hook"
	install -Dm644 "${source_root}/LICENSE" \
		"${pkgdir}/usr/share/licenses/${pkgname}/LICENSE"
}

arch_prepare_hyprbars() {
	local source_root="${srcdir}/${pkgname}-${pkgver}"
  tar -xzf "${srcdir}/hyprbars-${_plugins_commit}.tar.gz" -C "$srcdir"
  patch -Np1 -d "${srcdir}/hyprland-plugins-${_plugins_commit}" < "$source_root/packaging/arch/hyprbars-window-address.patch"
}

arch_build_hyprbars() {
  local headers_version
  headers_version="$(pkg-config --modversion hyprland)" || return 1
  if (( $(vercmp "$headers_version" "0.57.0") < 0 )); then
    printf 'error: hyprbars requires Hyprland >=0.57.0 headers; found %s\n' "$headers_version" >&2
    return 1
  fi
  # The upstream target does not track installed header dependencies.
  make -B -C "${srcdir}/hyprland-plugins-${_plugins_commit}/hyprbars" all
}
