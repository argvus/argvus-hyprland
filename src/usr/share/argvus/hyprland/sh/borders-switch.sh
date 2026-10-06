#!/usr/bin/env sh
# borders-switch - customize window and taskbar corner rounding.
# Usage: borders-switch.sh [--status|--defaults|--get <key>|--set <key> <value>|--set-persist <key> <value>|--reset|--apply]
# shellcheck disable=SC1090,SC1091,SC2034

set -u

ARGVUS_BOOTSTRAP="${ARGVUS_BOOTSTRAP:-${ARGVUS_SYSTEM_CONFIG:-/usr/share/argvus}/session/sh/bootstrap.sh}"
. "$ARGVUS_BOOTSTRAP"
ARGVUS_MUTABLE_CONFIG=1

STATE_DIR="${ARGVUS_CONFIG_HOME}/argvus/data"
BORDERS_FILE="${STATE_DIR}/.borders"
ACTIVE_FILE="${STATE_DIR}/.active-theme"
THEMES_DIR="$(paths_config appearance/config/hypr/themes)"
WAYBAR_CSS="$(paths_config taskbar/config/argvus-taskbar.css)"
WAYBAR_SYSINFO_CSS="$(paths_config widget-telemetry/config/argvus-widget-telemetry.css)"
ROFI_THEME="$(paths_config launcher/config/theme.rasi)"
DEFAULT_THEME="argvus-dark"
MIN_ROUNDING=2
MAX_ROUNDING=10
MIN_THICKNESS=0
MAX_THICKNESS=10
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

compute_defaults() {
  _theme="$(read_state "$ACTIVE_FILE" "$DEFAULT_THEME")"
  # /layout/variant is the canonical variant. The .active-theme suffix is only a
  # fallback for profiles that have not run argvus-config migration yet; without
  # this, a manual layout.json edit moved spacing while borders stayed sticky.
  if command -v argvus-config >/dev/null 2>&1; then
    _variant="$(argvus-config get /layout/variant --raw 2>/dev/null || true)"
    case "$_variant" in
      sticky) _theme="$DEFAULT_THEME" ;;
      float) _theme="${DEFAULT_THEME}-float" ;;
    esac
  fi
  case "$_theme" in
    *-float)
      ROUNDED_DEF=1
      ROUNDING_DEF=4
      THICKNESS_DEF=1
      ;;
    *)
      ROUNDED_DEF=0
      ROUNDING_DEF=0
      THICKNESS_DEF=1
      ;;
  esac
}

read_state_values() {
  ROUNDED=""
  ROUNDING=""
  THICKNESS=""
  [ -f "$BORDERS_FILE" ] || return 0
  while IFS= read -r _line; do
    _border_key="${_line%%=*}"
    _border_value="${_line#*=}"
    case "$_border_key" in
      rounded) ROUNDED="$_border_value" ;;
      rounding) ROUNDING="$_border_value" ;;
      thickness) THICKNESS="$_border_value" ;;
    esac
  done < "$BORDERS_FILE"
}

write_state() {
  mkdir -p "$STATE_DIR"
  {
    [ -n "$ROUNDED" ] && printf 'rounded=%s\n' "$ROUNDED"
    [ -n "$ROUNDING" ] && printf 'rounding=%s\n' "$ROUNDING"
    [ -n "$THICKNESS" ] && printf 'thickness=%s\n' "$THICKNESS"
  } > "$BORDERS_FILE"
  return 0
}

effective_values() {
  compute_defaults
  read_state_values
  # If .borders file is empty/missing, try to load values from layout.json via argvus-config
  # before falling back to variant defaults. This ensures that user-set values are respected
  # even if .borders is stale or missing.
  if [ -z "$ROUNDED" ] && [ -z "$ROUNDING" ] && [ -z "$THICKNESS" ]; then
    if command -v argvus-config >/dev/null 2>&1; then
      _layout_rounded="$(argvus-config get /layout/window/rounded --raw 2>/dev/null || true)"
      _layout_rounding="$(argvus-config get /layout/window/rounding --raw 2>/dev/null || true)"
      _layout_border_size="$(argvus-config get /layout/window/border_size --raw 2>/dev/null || true)"
      # argvus-config prints JSON booleans as true/false; .borders uses 1/0.
      case "$_layout_rounded" in
        true) _layout_rounded=1 ;;
        false) _layout_rounded=0 ;;
      esac
      [ -n "$_layout_rounded" ] && ROUNDED="$_layout_rounded"
      [ -n "$_layout_rounding" ] && ROUNDING="$_layout_rounding"
      [ -n "$_layout_border_size" ] && THICKNESS="$_layout_border_size"
    fi
  fi
  [ -n "$ROUNDED" ] || ROUNDED="$ROUNDED_DEF"
  [ -n "$ROUNDING" ] || ROUNDING="$ROUNDING_DEF"
  [ -n "$THICKNESS" ] || THICKNESS="$THICKNESS_DEF"
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
  hyprctl keyword general:border_size "$THICKNESS" >/dev/null 2>&1
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
    thickness)
      case "$_value" in
        *[!0-9]*|'') argvus_tr hyprland borders.invalid_thickness "value=$_value" >&2; return 1 ;;
      esac
      [ "$_value" -ge "$MIN_THICKNESS" ] && [ "$_value" -le "$MAX_THICKNESS" ] || {
        argvus_tr hyprland borders.thickness_range "minimum=$MIN_THICKNESS" "maximum=$MAX_THICKNESS" >&2
        return 1
      }
      THICKNESS="$_value"
      ;;
    *) argvus_tr hyprland borders.invalid_key "key=$_key" >&2; return 1 ;;
  esac
  write_state
  [ "$SET_PERSIST" -eq 1 ] && return 0
  apply_waybar_rounding
}

reset_state() {
  ROUNDED=""
  ROUNDING=""
  THICKNESS=""
  write_state
  effective_values
  apply_waybar_rounding
  apply_runtime
}

print_pairs() {
  printf 'rounded=%s\n' "$ROUNDED"
  printf 'rounding=%s\n' "$ROUNDING"
  printf 'thickness=%s\n' "$THICKNESS"
}

case "${1:-}" in
  --status) effective_values; print_pairs ;;
  --defaults)
    compute_defaults
    ROUNDED="$ROUNDED_DEF"
    ROUNDING="$ROUNDING_DEF"
    THICKNESS="$THICKNESS_DEF"
    print_pairs
    ;;
  --get)
    [ -n "${2:-}" ] || { argvus_tr hyprland borders.missing_key >&2; exit 1; }
    effective_values
    case "$2" in
      rounded) printf '%s\n' "$ROUNDED" ;;
      rounding) printf '%s\n' "$ROUNDING" ;;
      thickness) printf '%s\n' "$THICKNESS" ;;
      *) argvus_tr hyprland borders.invalid_key "key=$2" >&2; exit 1 ;;
    esac
    ;;
  --set)
    [ -n "${2:-}" ] && [ -n "${3:-}" ] || { argvus_tr hyprland borders.missing_key_value >&2; exit 1; }
    set_key "$2" "$3"
    ;;
  --set-persist)
    [ -n "${2:-}" ] && [ -n "${3:-}" ] || { argvus_tr hyprland borders.missing_key_value >&2; exit 1; }
    SET_PERSIST=1
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
