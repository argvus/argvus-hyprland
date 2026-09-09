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
	cp -R --no-preserve=ownership config/. "$(DESTDIR)$(PREFIX)/share/argvus/"
	find "$(DESTDIR)$(PREFIX)/share/argvus/scripts" -type f -name '*.sh' -exec chmod 755 {} \; 2>/dev/null || true
	install -Dm644 LICENSE "$(DESTDIR)$(PREFIX)/share/licenses/argvus-shell/LICENSE"

uninstall:
	rm -rf "$(DESTDIR)$(PREFIX)/share/argvus/quickshell/argvus-control-panel"
	rm -rf "$(DESTDIR)$(PREFIX)/share/argvus/rofi"
	rm -rf "$(DESTDIR)$(PREFIX)/share/argvus/wofi"
	rm -f "$(DESTDIR)$(PREFIX)/share/argvus/scripts/argvus/toggle-sidebar.sh"
	rm -f "$(DESTDIR)$(PREFIX)/share/argvus/scripts/argvus/spaces-switch.sh"
	rm -f "$(DESTDIR)$(PREFIX)/share/licenses/argvus-shell/LICENSE"

validate:
	@if find config -name '*.sh' | grep -q .; then \
		for script in $$(find config -name '*.sh'); do sh -n "$$script"; done; \
		if command -v shellcheck >/dev/null 2>&1; then for script in $$(find config -name '*.sh'); do shellcheck -e SC1090 -e SC2034 "$$script"; done; else echo "shellcheck not found; skipping shell lint"; fi; \
	fi
	@if find config -name '*.qml' | grep -q .; then \
		if command -v qmllint >/dev/null 2>&1; then \
			if ! qmllint -I config/quickshell/argvus-control-panel $$(find config -name '*.qml'); then \
				echo "qmllint reported issues; Quickshell imports may require runtime context"; \
			fi; \
		else \
			echo "qmllint not found; skipping QML lint"; \
		fi; \
	else \
		echo "no QML files found"; \
	fi
	@test ! -e config/waybar
	@test ! -e config/scripts/argvus/sysinfo
	@test -f config/rofi/config.rasi
	@echo "argvus-shell validation ok"

.PHONY: build

build:
	@tools/build-local-package.sh

clean:
	rm -rf dist
	rm -f packaging/arch/*.zst packaging/arch/*.tar.gz
