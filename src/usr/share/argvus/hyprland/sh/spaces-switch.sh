#!/usr/bin/env sh
# spaces-switch - customize window gaps and Waybar spacing.
# Usage: spaces-switch.sh [--status|--defaults|--get <key>|--set <key> <value>|--set-persist <key> <value>|--reset [key]|--apply-static|--apply]
# Keys: gaps_in, gaps_out_top, gaps_out_left, gaps_out_right, gaps_out_bottom,
# waybar_top, waybar_left, waybar_right, waybar_bottom.
# Values are user-controlled from 0 to 100 after each theme applies its mode reset.
# shellcheck disable=SC1090,SC1091,SC2034

set -u

ARGVUS_BOOTSTRAP="${ARGVUS_BOOTSTRAP:-${ARGVUS_SYSTEM_CONFIG:-/usr/share/argvus}/session/sh/bootstrap.sh}"
. "$ARGVUS_BOOTSTRAP"
ARGVUS_MUTABLE_CONFIG=1

STATE_DIR="${ARGVUS_CONFIG_HOME}/argvus/data"
SPACES_FILE="${STATE_DIR}/.spaces"
EFFECTIVE_FILE="$(paths_generated_config spaces-effective.conf)"
ACTIVE_FILE="${STATE_DIR}/.active-theme"
WAYBAR_CFG="$(paths_config taskbar/config/argvus-taskbar.jsonc)"
WAYBAR_SYSINFO="$(paths_config widget-telemetry/config/argvus-widget-telemetry.jsonc)"
THEMES_DIR="$(paths_config appearance/config/hypr/themes)"
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
  WAYBAR_TOP=""
  WAYBAR_LEFT=""
  WAYBAR_RIGHT=""
  WAYBAR_BOTTOM=""
  WAYBAR_LEGACY=""
  WAYBAR_POS=""
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
      waybar)        WAYBAR_LEGACY="$_rs_val" ;;
      waybar_top)    WAYBAR_TOP="$_rs_val" ;;
      waybar_left)   WAYBAR_LEFT="$_rs_val" ;;
      waybar_right)  WAYBAR_RIGHT="$_rs_val" ;;
      waybar_bottom) WAYBAR_BOTTOM="$_rs_val" ;;
      waybar_pos)    WAYBAR_POS="$_rs_val" ;;
    esac
  done < "$SPACES_FILE"

  # Migrate the old single-margin preference without coupling the four edges.
  if [ -n "$WAYBAR_LEGACY" ]; then
    [ -n "$WAYBAR_TOP" ] || WAYBAR_TOP="$WAYBAR_LEGACY"
    [ -n "$WAYBAR_LEFT" ] || WAYBAR_LEFT="$WAYBAR_LEGACY"
    [ -n "$WAYBAR_RIGHT" ] || WAYBAR_RIGHT="$WAYBAR_LEGACY"
    [ -n "$WAYBAR_BOTTOM" ] || WAYBAR_BOTTOM="$WAYBAR_LEGACY"
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
    [ -n "$WAYBAR_TOP" ] && printf 'waybar_top=%s\n' "$WAYBAR_TOP"
    [ -n "$WAYBAR_LEFT" ] && printf 'waybar_left=%s\n' "$WAYBAR_LEFT"
    [ -n "$WAYBAR_RIGHT" ] && printf 'waybar_right=%s\n' "$WAYBAR_RIGHT"
    [ -n "$WAYBAR_BOTTOM" ] && printf 'waybar_bottom=%s\n' "$WAYBAR_BOTTOM"
    [ -n "$WAYBAR_POS" ] && printf 'waybar_pos=%s\n' "$WAYBAR_POS"
  } > "$SPACES_FILE"
  return 0
}

compute_defaults() {
  _theme="$(read_state "$ACTIVE_FILE" "$DEFAULT_THEME")"
  if command -v argvus-config >/dev/null 2>&1; then
    _variant="$(argvus-config get /layout/variant --raw 2>/dev/null || true)"
    case "$_variant" in
      sticky) _theme="$DEFAULT_THEME" ;;
      float) _theme="${DEFAULT_THEME}-float" ;;
    esac
  fi
  # Window spacing is a mode reset, not a theme-specific value.

  case "$_theme" in
    *-float)
      GAPS_IN_DEF=4
      GAPS_OUT_TOP_DEF=18; GAPS_OUT_LEFT_DEF=18; GAPS_OUT_RIGHT_DEF=18; GAPS_OUT_BOTTOM_DEF=18
      WAYBAR_TOP_DEF=18; WAYBAR_LEFT_DEF=18; WAYBAR_RIGHT_DEF=18; WAYBAR_BOTTOM_DEF=18
      ;;
    *)
      GAPS_IN_DEF=2
      GAPS_OUT_TOP_DEF=0; GAPS_OUT_LEFT_DEF=0; GAPS_OUT_RIGHT_DEF=0; GAPS_OUT_BOTTOM_DEF=0
      WAYBAR_TOP_DEF=0; WAYBAR_LEFT_DEF=0; WAYBAR_RIGHT_DEF=0; WAYBAR_BOTTOM_DEF=2
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
  [ -n "$WAYBAR_TOP" ] || WAYBAR_TOP="$WAYBAR_TOP_DEF"
  [ -n "$WAYBAR_LEFT" ] || WAYBAR_LEFT="$WAYBAR_LEFT_DEF"
  [ -n "$WAYBAR_RIGHT" ] || WAYBAR_RIGHT="$WAYBAR_RIGHT_DEF"
  [ -n "$WAYBAR_BOTTOM" ] || WAYBAR_BOTTOM="$WAYBAR_BOTTOM_DEF"
  [ -n "$WAYBAR_POS" ] || WAYBAR_POS="top"
}

calculate_effective_geometry() {
  EFFECTIVE_TOP="$GAPS_OUT_TOP"
  EFFECTIVE_RIGHT="$GAPS_OUT_RIGHT"
  EFFECTIVE_BOTTOM="$GAPS_OUT_BOTTOM"
  EFFECTIVE_LEFT="$GAPS_OUT_LEFT"

  case "$WAYBAR_POS" in
    top)
      EFFECTIVE_TOP=$((GAPS_OUT_TOP - WAYBAR_BOTTOM))
      [ "$EFFECTIVE_TOP" -ge 0 ] || EFFECTIVE_TOP=0
      ;;
    bottom)
      EFFECTIVE_BOTTOM=$((GAPS_OUT_BOTTOM - WAYBAR_TOP))
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

apply_waybar_margins() {
  [ -n "${WAYBAR_TOP:-}" ] || return 0
  [ -n "${WAYBAR_POS:-}" ] || WAYBAR_POS="top"
  calculate_effective_geometry

  # The vertical telemetry bar follows the matching three monitor edges.
  if [ -f "$WAYBAR_SYSINFO" ]; then
    sed -i \
      -e "s|\"margin-top\": [0-9-]*|\"margin-top\": $EFFECTIVE_TOP|" \
      -e "s|\"margin-left\": [0-9-]*|\"margin-left\": $EFFECTIVE_LEFT|" \
      -e "s|\"margin-bottom\": [0-9-]*|\"margin-bottom\": $EFFECTIVE_BOTTOM|" \
      "$WAYBAR_SYSINFO"
  fi

  [ -f "$WAYBAR_CFG" ] || return 0
  sed -i \
    -e "s|\"position\": \"[a-z]*\"|\"position\": \"$WAYBAR_POS\"|" \
    -e "s|\"margin-top\": [0-9-]*|\"margin-top\": $WAYBAR_TOP|" \
    -e "s|\"margin-left\": [0-9-]*|\"margin-left\": $WAYBAR_LEFT|" \
    -e "s|\"margin-right\": [0-9-]*|\"margin-right\": $WAYBAR_RIGHT|" \
    -e "s|\"margin-bottom\": [0-9-]*|\"margin-bottom\": $WAYBAR_BOTTOM|" \
    "$WAYBAR_CFG"
}

apply_gaps_runtime() {
  [ "${ARGVUS_NO_RUNTIME:-0}" = 1 ] && return 0
  command -v hyprctl >/dev/null 2>&1 || return 0
  [ -n "${GAPS_IN:-}" ] && hyprctl keyword general:gaps_in "$GAPS_IN" >/dev/null 2>&1
  [ -n "${GAPS_OUT_TOP:-}" ] || return 0

  calculate_effective_geometry

  hyprctl keyword general:gaps_out \
    "$EFFECTIVE_TOP $EFFECTIVE_RIGHT $EFFECTIVE_BOTTOM $EFFECTIVE_LEFT" \
    >/dev/null 2>&1
}

restart_waybar() {
  [ "${ARGVUS_NO_RUNTIME:-0}" = 1 ] && return 0
  command -v argvus-sessionctl >/dev/null 2>&1 || return 0
  argvus-sessionctl restart waybar >/dev/null 2>&1 || true
}

set_key() {
  _key="$1"
  _value="$2"
  compute_defaults
  read_state_values

  case "$_key" in
    waybar_pos)
      case "$_value" in
        top|bottom)
          WAYBAR_POS="$_value"
          write_spaces
          [ "$SET_PERSIST" -eq 1 ] && return 0
          effective_values
          apply_waybar_margins
          apply_gaps_runtime
          restart_waybar
          return 0
          ;;
        *) argvus_tr hyprland spaces.invalid_value_position "value=$_value" >&2; return 1 ;;
      esac
      ;;
  esac

  case "$_key" in
    gaps_in|gaps_out|gaps_out_top|gaps_out_left|gaps_out_right|gaps_out_bottom|waybar|waybar_top|waybar_left|waybar_right|waybar_bottom) ;;
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
    waybar)
      WAYBAR_TOP="$_value"; WAYBAR_LEFT="$_value"; WAYBAR_RIGHT="$_value"; WAYBAR_BOTTOM="$_value"
      ;;
    waybar_top) WAYBAR_TOP="$_value" ;;
    waybar_left) WAYBAR_LEFT="$_value" ;;
    waybar_right) WAYBAR_RIGHT="$_value" ;;
    waybar_bottom) WAYBAR_BOTTOM="$_value" ;;
  esac
  write_spaces
}

reset_key() {
  _key="${1:-all}"
  read_state_values
  case "$_key" in
    all)
      GAPS_IN=""
      GAPS_OUT_TOP=""; GAPS_OUT_LEFT=""; GAPS_OUT_RIGHT=""; GAPS_OUT_BOTTOM=""
      WAYBAR_TOP=""; WAYBAR_LEFT=""; WAYBAR_RIGHT=""; WAYBAR_BOTTOM=""
      WAYBAR_POS=""
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
    waybar|waybar_top|waybar_left|waybar_right|waybar_bottom)
      case "$_key" in
        waybar) WAYBAR_TOP=""; WAYBAR_LEFT=""; WAYBAR_RIGHT=""; WAYBAR_BOTTOM="" ;;
        waybar_top) WAYBAR_TOP="" ;;
        waybar_left) WAYBAR_LEFT="" ;;
        waybar_right) WAYBAR_RIGHT="" ;;
        waybar_bottom) WAYBAR_BOTTOM="" ;;
      esac
      ;;
    waybar_pos) WAYBAR_POS="" ;;
    *) argvus_tr hyprland spaces.invalid_key "key=$_key" >&2; return 1 ;;
  esac
  write_spaces
  effective_values
  write_effective_geometry || return $?
  apply_gaps_runtime
  apply_waybar_margins
  restart_waybar
}

apply_all() {
  effective_values
  write_effective_geometry || return $?
  apply_gaps_runtime
  apply_waybar_margins
  restart_waybar
}

print_pairs() {
  printf 'waybar_top=%s\n' "$WAYBAR_TOP"
  printf 'waybar_left=%s\n' "$WAYBAR_LEFT"
  printf 'waybar_right=%s\n' "$WAYBAR_RIGHT"
  printf 'waybar_bottom=%s\n' "$WAYBAR_BOTTOM"
  printf 'waybar_pos=%s\n' "$WAYBAR_POS"
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
    WAYBAR_TOP="$WAYBAR_TOP_DEF"; WAYBAR_LEFT="$WAYBAR_LEFT_DEF"
    WAYBAR_RIGHT="$WAYBAR_RIGHT_DEF"; WAYBAR_BOTTOM="$WAYBAR_BOTTOM_DEF"
    WAYBAR_POS="top"; GAPS_IN="$GAPS_IN_DEF"
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
      waybar) printf '%s\n' "$WAYBAR_TOP" ;;
      waybar_top) printf '%s\n' "$WAYBAR_TOP" ;;
      waybar_left) printf '%s\n' "$WAYBAR_LEFT" ;;
      waybar_right) printf '%s\n' "$WAYBAR_RIGHT" ;;
      waybar_bottom) printf '%s\n' "$WAYBAR_BOTTOM" ;;
      waybar_pos) printf '%s\n' "$WAYBAR_POS" ;;
      *) argvus_tr hyprland spaces.invalid_key "key=$2" >&2; exit 1 ;;
    esac
    ;;
  --set|--set-persist)
    [ -n "${2:-}" ] && [ -n "${3:-}" ] || { argvus_tr hyprland spaces.missing_key_value >&2; exit 1; }
    [ "$1" = "--set-persist" ] && SET_PERSIST=1
    set_key "$2" "$3"
    ;;
  --reset) reset_key "${2:-all}" ;;
  --apply-static) effective_values; write_effective_geometry || exit $?; apply_waybar_margins ;;
  --apply) apply_all ;;
  *)
    effective_values
    argvus_tr hyprland spaces.usage >&2
    printf 'Current: gaps_in=%s gaps_out_top=%s gaps_out_left=%s gaps_out_right=%s gaps_out_bottom=%s waybar_top=%s waybar_left=%s waybar_right=%s waybar_bottom=%s waybar_pos=%s\n' \
      "$GAPS_IN" "$GAPS_OUT_TOP" "$GAPS_OUT_LEFT" "$GAPS_OUT_RIGHT" "$GAPS_OUT_BOTTOM" "$WAYBAR_TOP" "$WAYBAR_LEFT" "$WAYBAR_RIGHT" "$WAYBAR_BOTTOM" "$WAYBAR_POS"
    ;;
esac
