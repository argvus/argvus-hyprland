#!/usr/bin/env sh

# Show the Hyprland cheatsheet through the ARGVUS launcher.
# Usage: cheatsheets.sh [hypr]

# shellcheck disable=SC1091
ARGVUS_BOOTSTRAP="${ARGVUS_BOOTSTRAP:-${ARGVUS_SYSTEM_CONFIG:-/usr/share/argvus}/session/sh/bootstrap.sh}"
. "$ARGVUS_BOOTSTRAP"

exec sh "$(paths_config launcher/sh/cheatsheets.sh)" hypr
