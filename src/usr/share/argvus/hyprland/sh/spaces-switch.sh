#!/usr/bin/env sh
# spaces-switch - customize window gaps and Taskbar spacing.
# Usage: spaces-switch.sh [--status|--defaults|--get <key>|--set <key> <value>|--set-persist <key> <value>|--reset [key]|--apply-static|--apply]
# Keys: gaps_in, gaps_out_top, gaps_out_left, gaps_out_right, gaps_out_bottom,
# taskbar_top, taskbar_left, taskbar_right, taskbar_bottom.
# Values are user-controlled from 0 to 100 after each theme applies its mode reset.
# ARGVUS_SKIP_TASKBAR_RESTART=1 leaves Taskbar to the caller: the theme switch
# restarts the bars it stopped, so a restart here would only start them early.
# shellcheck disable=SC1090,SC1091,SC2034

set -u

ARGVUS_BOOTSTRAP="${ARGVUS_BOOTSTRAP:-${ARGVUS_SYSTEM_CONFIG:-/usr/share/argvus}/session/sh/bootstrap.sh}"
. "$ARGVUS_BOOTSTRAP"
ARGVUS_MUTABLE_CONFIG=1

STATE_DIR="${ARGVUS_CONFIG_HOME}/argvus/data"
SPACES_FILE="${STATE_DIR}/.spaces"
EFFECTIVE_FILE="$(paths_generated_config spaces-effective.conf)"
ACTIVE_FILE="${STATE_DIR}/.active-theme"
TASKBAR_CFG="$(paths_config taskbar/config/argvus-taskbar.jsonc)"
TASKBAR_SYSINFO="$(paths_config widget-telemetry/config/argvus-widget-telemetry.jsonc)"
DEFAULT_THEME="argvus-dark"
MAX_VALUE=100
SET_PERSIST=0

read_state() {
  _file="$1"
  _fallback="$2"
  if [ -s "$_file" ]; then
    sed -n '1p' "$_file"
  else
    printf '%s\n' "$_fallback"
  fi
}

read_state_values() {
  GAPS_IN=""
  GAPS_OUT_TOP=""
  GAPS_OUT_LEFT=""
  GAPS_OUT_RIGHT=""
  GAPS_OUT_BOTTOM=""
  GAPS_OUT_LEGACY=""
  TASKBAR_TOP=""
  TASKBAR_LEFT=""
  TASKBAR_RIGHT=""
  TASKBAR_BOTTOM=""
  TASKBAR_LEGACY=""
  TASKBAR_POS=""
  [ -f "$SPACES_FILE" ] || return 0
  while IFS= read -r _rs_line; do
    [ -n "$_rs_line" ] || continue
    _rs_key="${_rs_line%%=*}"
    _rs_val="${_rs_line#*=}"
    case "$_rs_key" in
      gaps_in)       GAPS_IN="$_rs_val" ;;
      gaps_out)      GAPS_OUT_LEGACY="$_rs_val" ;;
      gaps_out_top)  GAPS_OUT_TOP="$_rs_val" ;;
      gaps_out_left) GAPS_OUT_LEFT="$_rs_val" ;;
      gaps_out_right) GAPS_OUT_RIGHT="$_rs_val" ;;
      gaps_out_bottom) GAPS_OUT_BOTTOM="$_rs_val" ;;
      taskbar)        TASKBAR_LEGACY="$_rs_val" ;;
      taskbar_top)    TASKBAR_TOP="$_rs_val" ;;
      taskbar_left)   TASKBAR_LEFT="$_rs_val" ;;
      taskbar_right)  TASKBAR_RIGHT="$_rs_val" ;;
      taskbar_bottom) TASKBAR_BOTTOM="$_rs_val" ;;
      taskbar_pos)    TASKBAR_POS="$_rs_val" ;;
    esac
  done < "$SPACES_FILE"

  # Migrate the old single-margin preference without coupling the four edges.
  if [ -n "$TASKBAR_LEGACY" ]; then
    [ -n "$TASKBAR_TOP" ] || TASKBAR_TOP="$TASKBAR_LEGACY"
    [ -n "$TASKBAR_LEFT" ] || TASKBAR_LEFT="$TASKBAR_LEGACY"
    [ -n "$TASKBAR_RIGHT" ] || TASKBAR_RIGHT="$TASKBAR_LEGACY"
    [ -n "$TASKBAR_BOTTOM" ] || TASKBAR_BOTTOM="$TASKBAR_LEGACY"
  fi

  # Migrate the old single Hyprland outer-gap preference without coupling the
  # four new edges.
  if [ -n "$GAPS_OUT_LEGACY" ]; then
    [ -n "$GAPS_OUT_TOP" ] || GAPS_OUT_TOP="$GAPS_OUT_LEGACY"
    [ -n "$GAPS_OUT_LEFT" ] || GAPS_OUT_LEFT="$GAPS_OUT_LEGACY"
    [ -n "$GAPS_OUT_RIGHT" ] || GAPS_OUT_RIGHT="$GAPS_OUT_LEGACY"
    [ -n "$GAPS_OUT_BOTTOM" ] || GAPS_OUT_BOTTOM="$GAPS_OUT_LEGACY"
  fi
}

write_spaces() {
  mkdir -p "$STATE_DIR"
  {
    [ -n "$GAPS_IN" ] && printf 'gaps_in=%s\n' "$GAPS_IN"
    [ -n "$GAPS_OUT_TOP" ] && printf 'gaps_out_top=%s\n' "$GAPS_OUT_TOP"
    [ -n "$GAPS_OUT_LEFT" ] && printf 'gaps_out_left=%s\n' "$GAPS_OUT_LEFT"
    [ -n "$GAPS_OUT_RIGHT" ] && printf 'gaps_out_right=%s\n' "$GAPS_OUT_RIGHT"
    [ -n "$GAPS_OUT_BOTTOM" ] && printf 'gaps_out_bottom=%s\n' "$GAPS_OUT_BOTTOM"
    [ -n "$TASKBAR_TOP" ] && printf 'taskbar_top=%s\n' "$TASKBAR_TOP"
    [ -n "$TASKBAR_LEFT" ] && printf 'taskbar_left=%s\n' "$TASKBAR_LEFT"
    [ -n "$TASKBAR_RIGHT" ] && printf 'taskbar_right=%s\n' "$TASKBAR_RIGHT"
    [ -n "$TASKBAR_BOTTOM" ] && printf 'taskbar_bottom=%s\n' "$TASKBAR_BOTTOM"
    [ -n "$TASKBAR_POS" ] && printf 'taskbar_pos=%s\n' "$TASKBAR_POS"
  } > "$SPACES_FILE"
  return 0
}

compute_defaults() {
  _theme="$(read_state "$ACTIVE_FILE" "$DEFAULT_THEME")"
  if command -v argvus >/dev/null 2>&1; then
    _variant="$(argvus config get /layout/variant --raw 2>/dev/null || true)"
    case "$_variant" in
      sticky) _theme="$DEFAULT_THEME" ;;
      spaced|float) _theme="${DEFAULT_THEME}-spaced" ;;
    esac
  fi
  # Window spacing is a mode reset, not a theme-specific value.

  case "$_theme" in
    *-spaced|*-float)
      # Documented Spaced mode: internal gap 10, outer gap 18 (same as the
      # argvus-config baseline for the spaced variant).
      GAPS_IN_DEF=10
      GAPS_OUT_TOP_DEF=18; GAPS_OUT_LEFT_DEF=18; GAPS_OUT_RIGHT_DEF=18; GAPS_OUT_BOTTOM_DEF=18
      TASKBAR_TOP_DEF=18; TASKBAR_LEFT_DEF=18; TASKBAR_RIGHT_DEF=18; TASKBAR_BOTTOM_DEF=18
      ;;
    *)
      GAPS_IN_DEF=2
      GAPS_OUT_TOP_DEF=0; GAPS_OUT_LEFT_DEF=0; GAPS_OUT_RIGHT_DEF=0; GAPS_OUT_BOTTOM_DEF=0
      TASKBAR_TOP_DEF=0; TASKBAR_LEFT_DEF=0; TASKBAR_RIGHT_DEF=0; TASKBAR_BOTTOM_DEF=2
      ;;
  esac
}

effective_values() {
  compute_defaults
  read_state_values
  [ -n "$GAPS_IN" ] || GAPS_IN="$GAPS_IN_DEF"
  [ -n "$GAPS_OUT_TOP" ] || GAPS_OUT_TOP="$GAPS_OUT_TOP_DEF"
  [ -n "$GAPS_OUT_LEFT" ] || GAPS_OUT_LEFT="$GAPS_OUT_LEFT_DEF"
  [ -n "$GAPS_OUT_RIGHT" ] || GAPS_OUT_RIGHT="$GAPS_OUT_RIGHT_DEF"
  [ -n "$GAPS_OUT_BOTTOM" ] || GAPS_OUT_BOTTOM="$GAPS_OUT_BOTTOM_DEF"
  [ -n "$TASKBAR_TOP" ] || TASKBAR_TOP="$TASKBAR_TOP_DEF"
  [ -n "$TASKBAR_LEFT" ] || TASKBAR_LEFT="$TASKBAR_LEFT_DEF"
  [ -n "$TASKBAR_RIGHT" ] || TASKBAR_RIGHT="$TASKBAR_RIGHT_DEF"
  [ -n "$TASKBAR_BOTTOM" ] || TASKBAR_BOTTOM="$TASKBAR_BOTTOM_DEF"
  # Position is owned by the canonical Rust backend, including theme/reload
  # adapters that still consume the legacy geometry file.
  _canonical_pos="$(argvus config get /layout/taskbar/position --raw 2>/dev/null || true)"
  case "$_canonical_pos" in top|bottom) TASKBAR_POS="$_canonical_pos" ;; esac
  [ -n "$TASKBAR_POS" ] || TASKBAR_POS="top"
}

calculate_effective_geometry() {
  EFFECTIVE_TOP="$GAPS_OUT_TOP"
  EFFECTIVE_RIGHT="$GAPS_OUT_RIGHT"
  EFFECTIVE_BOTTOM="$GAPS_OUT_BOTTOM"
  EFFECTIVE_LEFT="$GAPS_OUT_LEFT"

  case "$TASKBAR_POS" in
    top)
      EFFECTIVE_TOP=$((GAPS_OUT_TOP - TASKBAR_BOTTOM))
      [ "$EFFECTIVE_TOP" -ge 0 ] || EFFECTIVE_TOP=0
      ;;
    bottom)
      EFFECTIVE_BOTTOM=$((GAPS_OUT_BOTTOM - TASKBAR_TOP))
      [ "$EFFECTIVE_BOTTOM" -ge 0 ] || EFFECTIVE_BOTTOM=0
      ;;
  esac
}

write_effective_geometry() {
  calculate_effective_geometry
  _effective_dir="${EFFECTIVE_FILE%/*}"
  _effective_tmp="${EFFECTIVE_FILE}.$$"
  mkdir -p "$_effective_dir" || return 1
  umask 077
  if {
    printf 'effective_top=%s\n' "$EFFECTIVE_TOP"
    printf 'effective_right=%s\n' "$EFFECTIVE_RIGHT"
    printf 'effective_bottom=%s\n' "$EFFECTIVE_BOTTOM"
    printf 'effective_left=%s\n' "$EFFECTIVE_LEFT"
  } >"$_effective_tmp"; then
    if mv -f "$_effective_tmp" "$EFFECTIVE_FILE"; then
      return 0
    fi
  else
    :
  fi
  rm -f "$_effective_tmp"
  return 1
}

apply_taskbar_margins() {
  [ ! -f "$(paths_system_config shell/qml/shell.qml)" ] || return 0
  [ -n "${TASKBAR_TOP:-}" ] || return 0
  [ -n "${TASKBAR_POS:-}" ] || TASKBAR_POS="top"
  calculate_effective_geometry

  # The vertical telemetry bar follows the matching three monitor edges.
  if [ -f "$TASKBAR_SYSINFO" ]; then
    sed -i \
      -e "s|\"margin-top\": [0-9-]*|\"margin-top\": $EFFECTIVE_TOP|" \
      -e "s|\"margin-left\": [0-9-]*|\"margin-left\": $EFFECTIVE_LEFT|" \
      -e "s|\"margin-bottom\": [0-9-]*|\"margin-bottom\": $EFFECTIVE_BOTTOM|" \
      "$TASKBAR_SYSINFO"
  fi

  [ -f "$TASKBAR_CFG" ] || return 0
  sed -i \
    -e "s|\"position\": \"[a-z]*\"|\"position\": \"$TASKBAR_POS\"|" \
    -e "s|\"margin-top\": [0-9-]*|\"margin-top\": $TASKBAR_TOP|" \
    -e "s|\"margin-left\": [0-9-]*|\"margin-left\": $TASKBAR_LEFT|" \
    -e "s|\"margin-right\": [0-9-]*|\"margin-right\": $TASKBAR_RIGHT|" \
    -e "s|\"margin-bottom\": [0-9-]*|\"margin-bottom\": $TASKBAR_BOTTOM|" \
    "$TASKBAR_CFG"
}

apply_gaps_runtime() {
  [ "${ARGVUS_NO_RUNTIME:-0}" = 1 ] && return 0
  command -v hyprctl >/dev/null 2>&1 || return 0
  # `hyprctl keyword` is rejected by the Lua parser ("use eval"), so runtime
  # gaps must go through `hyprctl eval`, the same config path as hyprland.lua.
  [ -n "${GAPS_OUT_TOP:-}" ] || return 0

  calculate_effective_geometry

  hyprctl eval "hl.config({ general = { gaps_in = ${GAPS_IN:-0}, gaps_out = { top = $EFFECTIVE_TOP, right = $EFFECTIVE_RIGHT, bottom = $EFFECTIVE_BOTTOM, left = $EFFECTIVE_LEFT } } })" \
    >/dev/null 2>&1 || true
}

restart_taskbar() {
  [ "${ARGVUS_NO_RUNTIME:-0}" = 1 ] && return 0
  [ "${ARGVUS_SKIP_TASKBAR_RESTART:-0}" = 1 ] && return 0
  command -v argvus >/dev/null 2>&1 || return 0
  argvus sessionctl restart taskbar >/dev/null 2>&1 || true
}

set_key() {
  _key="$1"
  _value="$2"
  compute_defaults
  read_state_values

  case "$_key" in
    taskbar_pos)
      if [ "$SET_PERSIST" -eq 1 ]; then
        argvus windows position "$_value" --persist
      else
        argvus windows position "$_value"
      fi
      return $?
      ;;
  esac

  case "$_key" in
    gaps_in|gaps_out|gaps_out_top|gaps_out_left|gaps_out_right|gaps_out_bottom|taskbar|taskbar_top|taskbar_left|taskbar_right|taskbar_bottom) ;;
    *) argvus_tr hyprland spaces.invalid_key "key=$_key" >&2; return 1 ;;
  esac

  case "$_value" in
    *[!0-9]*|'') argvus_tr hyprland spaces.invalid_value "value=$_value" >&2; return 1 ;;
  esac
  [ "$_value" -le "$MAX_VALUE" ] || {
    argvus_tr hyprland spaces.value_exceeds_maximum "value=$_value" "maximum=$MAX_VALUE" >&2
    return 1
  }

  case "$_key" in
    gaps_in) GAPS_IN="$_value" ;;
    gaps_out)
      GAPS_OUT_TOP="$_value"; GAPS_OUT_LEFT="$_value"; GAPS_OUT_RIGHT="$_value"; GAPS_OUT_BOTTOM="$_value"
      ;;
    gaps_out_top) GAPS_OUT_TOP="$_value" ;;
    gaps_out_left) GAPS_OUT_LEFT="$_value" ;;
    gaps_out_right) GAPS_OUT_RIGHT="$_value" ;;
    gaps_out_bottom) GAPS_OUT_BOTTOM="$_value" ;;
    taskbar)
      TASKBAR_TOP="$_value"; TASKBAR_LEFT="$_value"; TASKBAR_RIGHT="$_value"; TASKBAR_BOTTOM="$_value"
      ;;
    taskbar_top) TASKBAR_TOP="$_value" ;;
    taskbar_left) TASKBAR_LEFT="$_value" ;;
    taskbar_right) TASKBAR_RIGHT="$_value" ;;
    taskbar_bottom) TASKBAR_BOTTOM="$_value" ;;
  esac
  write_spaces
}

reset_key() {
  _key="${1:-all}"
  read_state_values
  case "$_key" in
    all)
      argvus windows position top --persist || return $?
      GAPS_IN=""
      GAPS_OUT_TOP=""; GAPS_OUT_LEFT=""; GAPS_OUT_RIGHT=""; GAPS_OUT_BOTTOM=""
      TASKBAR_TOP=""; TASKBAR_LEFT=""; TASKBAR_RIGHT=""; TASKBAR_BOTTOM=""
      TASKBAR_POS=""
      ;;
    gaps_in) GAPS_IN="" ;;
    gaps_out|gaps_out_top|gaps_out_left|gaps_out_right|gaps_out_bottom)
      case "$_key" in
        gaps_out) GAPS_OUT_TOP=""; GAPS_OUT_LEFT=""; GAPS_OUT_RIGHT=""; GAPS_OUT_BOTTOM="" ;;
        gaps_out_top) GAPS_OUT_TOP="" ;;
        gaps_out_left) GAPS_OUT_LEFT="" ;;
        gaps_out_right) GAPS_OUT_RIGHT="" ;;
        gaps_out_bottom) GAPS_OUT_BOTTOM="" ;;
      esac
      ;;
    taskbar|taskbar_top|taskbar_left|taskbar_right|taskbar_bottom)
      case "$_key" in
        taskbar) TASKBAR_TOP=""; TASKBAR_LEFT=""; TASKBAR_RIGHT=""; TASKBAR_BOTTOM="" ;;
        taskbar_top) TASKBAR_TOP="" ;;
        taskbar_left) TASKBAR_LEFT="" ;;
        taskbar_right) TASKBAR_RIGHT="" ;;
        taskbar_bottom) TASKBAR_BOTTOM="" ;;
      esac
      ;;
    taskbar_pos) argvus windows position top; return $? ;;
    *) argvus_tr hyprland spaces.invalid_key "key=$_key" >&2; return 1 ;;
  esac
  write_spaces
  effective_values
  write_effective_geometry || return $?
  apply_gaps_runtime
  apply_taskbar_margins
  restart_taskbar
}

apply_all() {
  effective_values
  write_effective_geometry || return $?
  apply_gaps_runtime
  apply_taskbar_margins
  restart_taskbar
}

print_pairs() {
  printf 'taskbar_top=%s\n' "$TASKBAR_TOP"
  printf 'taskbar_left=%s\n' "$TASKBAR_LEFT"
  printf 'taskbar_right=%s\n' "$TASKBAR_RIGHT"
  printf 'taskbar_bottom=%s\n' "$TASKBAR_BOTTOM"
  printf 'taskbar_pos=%s\n' "$TASKBAR_POS"
  printf 'gaps_in=%s\n' "$GAPS_IN"
  printf 'gaps_out_top=%s\n' "$GAPS_OUT_TOP"
  printf 'gaps_out_left=%s\n' "$GAPS_OUT_LEFT"
  printf 'gaps_out_right=%s\n' "$GAPS_OUT_RIGHT"
  printf 'gaps_out_bottom=%s\n' "$GAPS_OUT_BOTTOM"
  # Keep the legacy aggregate status line for older TUI consumers. New
  # consumers must use the four edge-specific keys above.
  printf 'gaps_out=%s\n' "$GAPS_OUT_TOP"
}

case "${1:-}" in
  --status)
    effective_values
    print_pairs
    ;;
  --defaults)
    compute_defaults
    TASKBAR_TOP="$TASKBAR_TOP_DEF"; TASKBAR_LEFT="$TASKBAR_LEFT_DEF"
    TASKBAR_RIGHT="$TASKBAR_RIGHT_DEF"; TASKBAR_BOTTOM="$TASKBAR_BOTTOM_DEF"
    TASKBAR_POS="top"; GAPS_IN="$GAPS_IN_DEF"
    GAPS_OUT_TOP="$GAPS_OUT_TOP_DEF"; GAPS_OUT_LEFT="$GAPS_OUT_LEFT_DEF"
    GAPS_OUT_RIGHT="$GAPS_OUT_RIGHT_DEF"; GAPS_OUT_BOTTOM="$GAPS_OUT_BOTTOM_DEF"
    print_pairs
    ;;
  --get)
    [ -n "${2:-}" ] || { argvus_tr hyprland spaces.missing_key >&2; exit 1; }
    effective_values
    case "$2" in
      gaps_in) printf '%s\n' "$GAPS_IN" ;;
      gaps_out) printf '%s\n' "$GAPS_OUT_TOP" ;;
      gaps_out_top) printf '%s\n' "$GAPS_OUT_TOP" ;;
      gaps_out_left) printf '%s\n' "$GAPS_OUT_LEFT" ;;
      gaps_out_right) printf '%s\n' "$GAPS_OUT_RIGHT" ;;
      gaps_out_bottom) printf '%s\n' "$GAPS_OUT_BOTTOM" ;;
      taskbar) printf '%s\n' "$TASKBAR_TOP" ;;
      taskbar_top) printf '%s\n' "$TASKBAR_TOP" ;;
      taskbar_left) printf '%s\n' "$TASKBAR_LEFT" ;;
      taskbar_right) printf '%s\n' "$TASKBAR_RIGHT" ;;
      taskbar_bottom) printf '%s\n' "$TASKBAR_BOTTOM" ;;
      taskbar_pos) printf '%s\n' "$TASKBAR_POS" ;;
      *) argvus_tr hyprland spaces.invalid_key "key=$2" >&2; exit 1 ;;
    esac
    ;;
  --set|--set-persist)
    [ -n "${2:-}" ] && [ -n "${3:-}" ] || { argvus_tr hyprland spaces.missing_key_value >&2; exit 1; }
    [ "$1" = "--set-persist" ] && SET_PERSIST=1
    set_key "$2" "$3"
    ;;
  --reset) reset_key "${2:-all}" ;;
  --apply-static) effective_values; write_effective_geometry || exit $?; apply_taskbar_margins ;;
  --apply) apply_all ;;
  *)
    effective_values
    argvus_tr hyprland spaces.usage >&2
    printf 'Current: gaps_in=%s gaps_out_top=%s gaps_out_left=%s gaps_out_right=%s gaps_out_bottom=%s taskbar_top=%s taskbar_left=%s taskbar_right=%s taskbar_bottom=%s taskbar_pos=%s\n' \
      "$GAPS_IN" "$GAPS_OUT_TOP" "$GAPS_OUT_LEFT" "$GAPS_OUT_RIGHT" "$GAPS_OUT_BOTTOM" "$TASKBAR_TOP" "$TASKBAR_LEFT" "$TASKBAR_RIGHT" "$TASKBAR_BOTTOM" "$TASKBAR_POS"
    ;;
esac
