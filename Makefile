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
	install -dm755 "$(DESTDIR)$(PREFIX)/share/argvus"
	cp -R --no-preserve=ownership src/. "$(DESTDIR)$(PREFIX)/share/argvus/"
	find "$(DESTDIR)$(PREFIX)/share/argvus/scripts" -type f -name '*.sh' -exec chmod 755 {} \; 2>/dev/null || true
	install -Dm644 LICENSE "$(DESTDIR)$(PREFIX)/share/licenses/argvus-hyprland/LICENSE"

uninstall:
	rm -rf "$(DESTDIR)$(PREFIX)/share/argvus/hypr"
	rm -f "$(DESTDIR)$(PREFIX)/share/argvus/scripts/apps/hypr-screenshot.sh"
	rm -f "$(DESTDIR)$(PREFIX)/share/argvus/scripts/apps/cheatsheets.sh"
	rm -f "$(DESTDIR)$(PREFIX)/share/argvus/scripts/argvus/spaces-switch.sh"
	rm -f "$(DESTDIR)$(PREFIX)/share/licenses/argvus-hyprland/LICENSE"

validate:
	@if find src -name '*.sh' | grep -q .; then \
		for script in $$(find src -name '*.sh'); do sh -n "$$script"; done; \
		if command -v shellcheck >/dev/null 2>&1; then for script in $$(find src -name '*.sh'); do shellcheck -e SC1090 -e SC2034 "$$script"; done; else echo "shellcheck not found; skipping shell lint"; fi; \
	fi
	@test -d src/hypr
	@test ! -e src/rofi
	@test ! -e config
	@echo "argvus-hyprland validation ok"

.PHONY: build

build:
	@tools/build-local-package.sh

clean:
	rm -rf dist
	rm -f packaging/arch/*.zst packaging/arch/*.tar.gz
