#!/usr/bin/env sh

# Toggle the terminal scratchpad on a Hyprland special workspace.
# Usage: scratchpad.sh
#
# Hyprland 0.56 evaluates `hyprctl dispatch` arguments as Lua, so dispatches
# use the hl.dsp API. Errors are not suppressed: a failed dispatch must exit
# non-zero instead of silently doing nothing.

set -eu

readonly CLASS="argvus-scratchpad"
readonly SPECIAL="special:$CLASS"

command -v hyprctl >/dev/null 2>&1 || exit 1
command -v jq >/dev/null 2>&1 || exit 1

find_address() {
  hyprctl clients -j | jq -r --arg class "$CLASS" '[.[] | select(.class == $class)][0].address // empty'
}

find_monitor() {
  hyprctl clients -j | jq -r --arg class "$CLASS" '[.[] | select(.class == $class)][0].monitor // empty'
}

special_on_monitor() {
  hyprctl monitors -j | jq -r --argjson id "$1" '.[] | select(.id == $id) | .specialWorkspace.name // empty'
}

dispatch() {
  hyprctl dispatch "$1" >/dev/null
}

address="$(find_address)"

if [ -z "$address" ]; then
  argvus-terminal --class "$CLASS" >/dev/null 2>&1 &

  attempts=0
  while [ -z "$address" ] && [ "$attempts" -lt 40 ]; do
    sleep 0.05
    address="$(find_address)"
    attempts=$((attempts + 1))
  done
  [ -n "$address" ] || exit 1

  dispatch "hl.dsp.window.move({ workspace = \"$SPECIAL\", window = \"address:$address\" })"

  # Moving a window into a special workspace shows it on the first run, so
  # toggling again here would hide it immediately.
  if [ "$(special_on_monitor "$(find_monitor)")" = "$SPECIAL" ]; then
    exit 0
  fi
fi

dispatch "hl.dsp.workspace.toggle_special(\"$CLASS\")"
