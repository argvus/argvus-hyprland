#!/usr/bin/env sh
# borders-switch - customize window and taskbar corner rounding.
# Usage: borders-switch.sh [--status|--defaults|--get <key>|--set <key> <value>|--reset|--apply]
# shellcheck disable=SC1090,SC1091,SC2034

set -u

ARGVUS_BOOTSTRAP="${ARGVUS_BOOTSTRAP:-${ARGVUS_SYSTEM_CONFIG:-/usr/share/argvus}/session/sh/bootstrap.sh}"
. "$ARGVUS_BOOTSTRAP"
ARGVUS_MUTABLE_CONFIG=1

STATE_DIR="${ARGVUS_CONFIG_HOME}/argvus"
BORDERS_FILE="${STATE_DIR}/.borders"
ACTIVE_FILE="${STATE_DIR}/.active-theme"
THEMES_DIR="$(paths_config appearance/config/hypr/themes)"
WAYBAR_CSS="$(paths_config taskbar/config/argvus-taskbar.css)"
WAYBAR_SYSINFO_CSS="$(paths_config widget-telemetry/config/argvus-widget-telemetry.css)"
ROFI_THEME="$(paths_config launcher/config/theme.rasi)"
DEFAULT_THEME="argvus-dark-aether"
MIN_ROUNDING=2
MAX_ROUNDING=10

read_state() {
  _file="$1"
  _fallback="$2"
  if [ -s "$_file" ]; then
    sed -n '1p' "$_file"
  else
    printf '%s\n' "$_fallback"
  fi
}

compute_defaults() {
  _theme="$(read_state "$ACTIVE_FILE" "$DEFAULT_THEME")"
  case "$_theme" in
    *-float)
      ROUNDED_DEF=1
      ROUNDING_DEF=4
      ;;
    *)
      ROUNDED_DEF=0
      ROUNDING_DEF=0
      ;;
  esac
}

read_state_values() {
  ROUNDED=""
  ROUNDING=""
  [ -f "$BORDERS_FILE" ] || return 0
  while IFS= read -r _line; do
    _border_key="${_line%%=*}"
    _border_value="${_line#*=}"
    case "$_border_key" in
      rounded) ROUNDED="$_border_value" ;;
      rounding) ROUNDING="$_border_value" ;;
    esac
  done < "$BORDERS_FILE"
}

write_state() {
  mkdir -p "$STATE_DIR"
  {
    [ -n "$ROUNDED" ] && printf 'rounded=%s\n' "$ROUNDED"
    [ -n "$ROUNDING" ] && printf 'rounding=%s\n' "$ROUNDING"
  } > "$BORDERS_FILE"
  return 0
}

effective_values() {
  compute_defaults
  read_state_values
  [ -n "$ROUNDED" ] || ROUNDED="$ROUNDED_DEF"
  [ -n "$ROUNDING" ] || ROUNDING="$ROUNDING_DEF"
}

apply_file_rounding() {
  _rounding_file="$1"
  [ -f "$_rounding_file" ] || return 0
  _waybar_rounding="$ROUNDING"
  [ "$ROUNDED" = 1 ] || _waybar_rounding=0
  sed -i -E "s|border-radius: [0-9]+(px)?;|border-radius: ${_waybar_rounding}px;|g" "$_rounding_file"
}

apply_waybar_rounding() {
  apply_file_rounding "$WAYBAR_CSS"
  apply_file_rounding "$WAYBAR_SYSINFO_CSS"
  apply_file_rounding "$ROFI_THEME"
}

apply_runtime() {
  [ "${ARGVUS_NO_RUNTIME:-0}" = 1 ] && return 0
  command -v hyprctl >/dev/null 2>&1 || return 0
  _applied_rounding="$ROUNDING"
  [ "$ROUNDED" = 1 ] || _applied_rounding=0
  hyprctl keyword decoration:rounding "$_applied_rounding" >/dev/null 2>&1
}

set_key() {
  _key="$1"
  _value="$2"
  effective_values
  case "$_key" in
    rounded)
      case "$_value" in
        0|1)
          ROUNDED="$_value"
          if [ "$_value" = 1 ]; then
            case "$ROUNDING" in
              ''|0|1) ROUNDING=2 ;;
            esac
          fi
          ;;
        *) argvus_tr hyprland borders.invalid_rounded "value=$_value" >&2; return 1 ;;
      esac
      ;;
    rounding)
      case "$_value" in
        *[!0-9]*|'') argvus_tr hyprland borders.invalid_rounding "value=$_value" >&2; return 1 ;;
      esac
      [ "$_value" -ge "$MIN_ROUNDING" ] && [ "$_value" -le "$MAX_ROUNDING" ] || {
        argvus_tr hyprland borders.rounding_range "minimum=$MIN_ROUNDING" "maximum=$MAX_ROUNDING" >&2
        return 1
      }
      ROUNDING="$_value"
      ;;
    *) argvus_tr hyprland borders.invalid_key "key=$_key" >&2; return 1 ;;
  esac
  write_state
  apply_waybar_rounding
}

reset_state() {
  ROUNDED=""
  ROUNDING=""
  write_state
  effective_values
  apply_waybar_rounding
  apply_runtime
}

print_pairs() {
  printf 'rounded=%s\n' "$ROUNDED"
  printf 'rounding=%s\n' "$ROUNDING"
}

case "${1:-}" in
  --status) effective_values; print_pairs ;;
  --defaults)
    compute_defaults
    ROUNDED="$ROUNDED_DEF"
    ROUNDING="$ROUNDING_DEF"
    print_pairs
    ;;
  --get)
    [ -n "${2:-}" ] || { argvus_tr hyprland borders.missing_key >&2; exit 1; }
    effective_values
    case "$2" in
      rounded) printf '%s\n' "$ROUNDED" ;;
      rounding) printf '%s\n' "$ROUNDING" ;;
      *) argvus_tr hyprland borders.invalid_key "key=$2" >&2; exit 1 ;;
    esac
    ;;
  --set)
    [ -n "${2:-}" ] && [ -n "${3:-}" ] || { argvus_tr hyprland borders.missing_key_value >&2; exit 1; }
    set_key "$2" "$3"
    ;;
  --reset) reset_state ;;
  --apply) effective_values; apply_waybar_rounding; apply_runtime ;;
  --apply-static) effective_values; apply_waybar_rounding ;;
  *)
    effective_values
    argvus_tr hyprland borders.usage >&2
    print_pairs
    ;;
esac
