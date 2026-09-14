PREFIX ?= /usr
DESTDIR ?=

.DEFAULT_GOAL := help

.PHONY: help install uninstall validate build clean

help:
	@echo "Available targets:"
	@echo "  make build"
	@echo "  make install"
	@echo "  make uninstall"
	@echo "  make validate"

install:
	install -dm755 "$(DESTDIR)$(PREFIX)/share/argvus/hyprland"
	cp -R --no-preserve=ownership src/usr/share/argvus/hyprland/. "$(DESTDIR)$(PREFIX)/share/argvus/hyprland/"
	find "$(DESTDIR)$(PREFIX)/share/argvus/hyprland/sh" -type f -name '*.sh' -exec chmod 755 {} \; 2>/dev/null || true
	install -Dm644 LICENSE "$(DESTDIR)$(PREFIX)/share/licenses/argvus-hyprland/LICENSE"

uninstall:
	rm -rf "$(DESTDIR)$(PREFIX)/share/argvus/hyprland"
	rm -f "$(DESTDIR)$(PREFIX)/share/licenses/argvus-hyprland/LICENSE"

validate:
	@command -v luac >/dev/null 2>&1 && luac -p src/usr/share/argvus/hyprland/config/hyprland.lua || { echo "luac not found; skipping Lua syntax check"; }
	@if find src -name '*.sh' | grep -q .; then \
		for script in $$(find src -name '*.sh'); do sh -n "$$script"; done; \
		if command -v shellcheck >/dev/null 2>&1; then for script in $$(find src -name '*.sh'); do shellcheck -e SC1090 -e SC2034 "$$script"; done; else echo "shellcheck not found; skipping shell lint"; fi; \
	fi
	@test -d src/usr/share/argvus/hyprland/config
	@test -d src/usr/share/argvus/hyprland/docs
	@test -d src/usr/share/argvus/hyprland/sh
	@test ! -e src/rofi
	@test ! -e config
	@echo "argvus-hyprland validation ok"

.PHONY: build

build:
	@tools/build-local-package.sh

clean:
	rm -rf dist
	rm -f packaging/arch/*.zst packaging/arch/*.tar.gz
