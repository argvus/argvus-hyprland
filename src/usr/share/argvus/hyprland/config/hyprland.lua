-- ===================================
--  Hyprland 0.56+
--  Author: William C. Canin
-- ===================================

-- Theme loader ------------------------------------------------------------------------------------
local _home = os.getenv("HOME") or ""
local _config_home = os.getenv("ARGVUS_CONFIG_HOME")
  or os.getenv("XDG_CONFIG_HOME")
  or (_home .. "/.config")
local _system_config = os.getenv("ARGVUS_SYSTEM_CONFIG") or "/usr/share/argvus"
local _debug_session = os.getenv("ARGVUS_DEBUG") == "1"
local _state_home = _config_home .. "/argvus"
local _data_home = _state_home .. "/data"
local _xdg_state_home = os.getenv("XDG_STATE_HOME") or (_home .. "/.local/state")
local _generated_config = _data_home .. "/generated"

local function _path_exists(path)
  local file = io.open(path, "r")
  if file then
    file:close()
    return true
  end
  return false
end

local function _first_existing(paths)
  for _, path in ipairs(paths) do
    if _path_exists(path) then
      return path
    end
  end
  return paths[1]
end

local function _config_path(relative_path, legacy_path)
  if not legacy_path then
    local script = relative_path:match("/sh/([^/]+)$")
    legacy_path = script and ("scripts/argvus/" .. script) or relative_path
  end
  return _first_existing({
    _config_home .. "/" .. legacy_path,
    _config_home .. "/" .. relative_path,
    _data_home .. "/" .. legacy_path,
    _data_home .. "/" .. relative_path,
    _state_home .. "/" .. legacy_path,
    _state_home .. "/" .. relative_path,
    _generated_config .. "/" .. legacy_path,
    _generated_config .. "/" .. relative_path,
    _system_config .. "/" .. relative_path,
  })
end

-- Rofi themes are mutable ARGVUS config, not native ~/.config/launcher files.
-- Keep every Hyprland-launched Rofi action on the same precedence used by
-- paths_config: native legacy override, ARGVUS user copy, generated copy,
-- then the packaged launcher config.
local function _rofi_config_path()
  return _config_path("launcher/config/config.rasi", "rofi/config.rasi")
end

local function _load_user_override(relative_path)
  local path = _data_home .. "/hypr/" .. relative_path
  if _path_exists(path) then
    dofile(path)
  end
end

local function _sh(path)
  return "sh " .. string.format("%q", path)
end

local function _read_first_line(paths)
  for _, path in ipairs(paths) do
    local file = io.open(path, "r")
    if file then
      local line = file:read("*l")
      file:close()
      if line and line ~= "" then
        return line
      end
    end
  end
  return nil
end

local function _load_generated_table(relative_path)
  local path = _generated_config .. "/" .. relative_path
  if not _path_exists(path) then
    return nil
  end
  local ok, value = pcall(dofile, path)
  if ok and type(value) == "table" then
    return value
  end
  print("ARGVUS: ignoring invalid generated config: " .. path)
  return nil
end

-- Keybinding overrides are intentionally sparse: the packaged calls below are
-- the defaults, while this table contains only user differences. Invalid or
-- missing generated state therefore leaves the packaged defaults untouched.
local _keybinding_overrides = _load_generated_table("hypr/keybindings.lua") or {}
local function _argvus_bind(id, default_keys, action, options)
  local override = _keybinding_overrides[id]
  if override and override.enabled == false then
    return
  end
  local keys = (override and type(override.keys) == "string" and override.keys) or default_keys
  hl.bind(keys, action, options)
end

-- Font state is a config.json projection. Keep the legacy root fallback only
-- for profiles that have not run argvus-config migration yet.
local _font_state_path = _first_existing({
  _generated_config .. "/fonts.conf",
  _state_home .. "/fonts.conf",
})
local function _projected_font_state_value(key, fallback)
  local file = io.open(_font_state_path, "r")
  if file then
    for line in file:lines() do
      local candidate_key, value = line:match("^%s*([^=#]+)%s*=%s*(.-)%s*$")
      if candidate_key == key and value and value ~= "" then
        file:close()
        return value
      end
    end
    file:close()
  end
  return fallback
end

local _argvus_font_family = _projected_font_state_value("system_family", _projected_font_state_value("default_family", "IBM Plex Mono"))
local _argvus_font_size = tonumber(_projected_font_state_value("system_size", _projected_font_state_value("default_size", "13"))) or 13

local _argvus_input = {
  kb_layout = "br,us",
  kb_variant = "abnt2",
  kb_options = "grp:alt_shift_toggle",
}

local _generated_input = _load_generated_table("hypr/input.lua")
if _generated_input then
  for key, value in pairs(_generated_input) do
    if type(key) == "string" and type(value) == "string" then
      _argvus_input[key] = value
    end
  end
end

local _argvus_input_settings = _load_generated_table("hypr/input-settings.lua") or {}
local _argvus_touchpad_settings = _argvus_input_settings.touchpad or {}

local function _input_bool(table, key, fallback)
  local value = table[key]
  if type(value) == "boolean" then
    return value
  end
  return fallback
end

-- Default applications (written by ARGVUS Control Center Apps) --------------------------------------
local _defaults_fallback = {
  terminal = "argvus-terminal",
  file_manager = "argvus --spf",
  text_editor = "mousepad",
  terminal_editor = "vim",
  browser = "xdg-open",
  image_viewer = "imv",
  pdf_viewer = "zathura",
  video_player = "mpv",
  audio_player = "audacious",
  archive = "xarchiver",
  launcher = "rofi",
}

local _default_values = {}
local _reads_defaults = false
local function _get_default(category)
  -- Resolve the values file once, then serve cached lookups.
  if not _reads_defaults then
    _reads_defaults = true
    local path = _first_existing({
      _state_home .. "/data/control-center/defaults.json",
      _config_home .. "/argvus/defaults.json",
      _xdg_state_home .. "/argvus/defaults.json",
      _system_config .. "/defaults.json",
    })
    local file = io.open(path)
    if file then
      for _line in file:lines() do
        local key, value = _line:match('^%s*"([%w_]+)"%s*:%s*"([^"]*)"')
        if key and value ~= "" then
          _default_values[key] = value
        end
      end
      file:close()
    end
  end
  return _default_values[category] or _defaults_fallback[category]
end

-- The active theme is a config.json projection that lives under `data/`. Every
-- writer (theme-switch.sh, argvus-config project) emits `data/`, so reading the
-- legacy root first made this file resolve Sticky for every session that had
-- run the migration. Keep the root as a read-only fallback for profiles that
-- have not migrated yet.
local _theme_name = "argvus-dark"
local _active_theme = _read_first_line({
  _data_home .. "/.active-theme",
  _state_home .. "/.active-theme",
  _config_home .. "/.active-theme",
})
if _active_theme then
  _theme_name = _active_theme
end

-- Sticky/Float is independent of the theme (`/layout/variant`, owned by
-- mode-switch.sh/argvus-config apply-mode): `_theme_name` no longer carries a
-- `-float` suffix. The paired `<theme>-float` asset directory only differs
-- from `<theme>` in rounding/gaps (never color), so pick the on-disk variant
-- by the current mode instead of by the theme name.
local _layout_variant = "sticky"
local _variant_bin = io.popen("argvus-config get /layout/variant --raw 2>/dev/null")
if _variant_bin then
  local _variant_value = _variant_bin:read("*l") or ""
  if _variant_value == "float" then
    _layout_variant = "float"
  end
  _variant_bin:close()
end
local _theme_asset_name = _theme_name
if _layout_variant == "float" and not _theme_name:match("%-float$") then
  _theme_asset_name = _theme_name .. "-float"
end

local _theme_path = _first_existing({
  _config_home .. "/hypr/themes/" .. _theme_asset_name .. "/theme.lua",
  _config_home .. "/argvus/hypr/themes/" .. _theme_asset_name .. "/theme.lua",
  _generated_config .. "/hypr/themes/" .. _theme_asset_name .. "/theme.lua",
  _system_config .. "/appearance/config/hypr/themes/" .. _theme_asset_name .. "/theme.lua",
})
local theme = dofile(_theme_path)

-- Window spacing is also a mode reset. A theme may declare another value,
-- but Sticky and Float both start from the ARGVUS mode contract.
theme.gaps_in = _layout_variant == "float" and 4 or 2

-- Theme files own the active border color. A manual accent is the only
-- exception, and is opt-in in canonical config.json; the legacy accent file
-- is not enough to distinguish a theme default from a user override.
local _accent_custom = false
local _config_bin = io.popen("argvus-config get /appearance/accent_custom --raw 2>/dev/null")
if _config_bin then
  _accent_custom = (_config_bin:read("*l") or "") == "true"
  _config_bin:close()
end
if _accent_custom then
  local _accent_line = _read_first_line({
    _data_home .. "/.accent-color",
    _state_home .. "/.accent-color",
    _config_home .. "/.accent-color",
  })
  if _accent_line then
    local _line = _accent_line:lower():gsub("^%s+", ""):gsub("%s+$", ""):gsub("#", "")
    if _line:match("^[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]$") then
      theme.border_active = "rgba(" .. _line .. "ff)"
      theme.groupbar_active = "rgba(" .. _line .. "ff)"
    end
  end
end

-- Window spacing is projected from /layout into data/.spaces by
-- argvus-config project. Prefer that copy so a manual layout.json edit reaches
-- the compositor instead of silently falling back to the mode heuristic.
local _spaces_path = _first_existing({
  _data_home .. "/.spaces",
  _state_home .. "/.spaces",
  _config_home .. "/.spaces",
})
local _spaces_file = io.open(_spaces_path)
local _spaces_waybar_top = _layout_variant == "float" and 18 or 0
local _spaces_waybar_left = _spaces_waybar_top
local _spaces_waybar_right = _spaces_waybar_top
local _spaces_waybar_bottom = _layout_variant == "float" and 18 or 2
local _spaces_waybar_pos = "top"
local _spaces_waybar_legacy
local _spaces_gaps_out_top = _layout_variant == "float" and 18 or 0
local _spaces_gaps_out_left = _spaces_gaps_out_top
local _spaces_gaps_out_right = _spaces_gaps_out_top
local _spaces_gaps_out_bottom = _spaces_gaps_out_top
local _spaces_gaps_out_legacy
local _spaces_waybar_top_set = false
local _spaces_waybar_left_set = false
local _spaces_waybar_right_set = false
local _spaces_waybar_bottom_set = false
local _spaces_gaps_out_top_set = false
local _spaces_gaps_out_left_set = false
local _spaces_gaps_out_right_set = false
local _spaces_gaps_out_bottom_set = false
if _spaces_file then
  for _line in _spaces_file:lines() do
    local _key, _val = _line:match("^([%w_]+)=(%d+)$")
    if _key == "gaps_in" then theme.gaps_in = tonumber(_val) end
    if _key == "gaps_out" then _spaces_gaps_out_legacy = tonumber(_val) end
    if _key == "gaps_out_top" then _spaces_gaps_out_top = tonumber(_val); _spaces_gaps_out_top_set = true end
    if _key == "gaps_out_left" then _spaces_gaps_out_left = tonumber(_val); _spaces_gaps_out_left_set = true end
    if _key == "gaps_out_right" then _spaces_gaps_out_right = tonumber(_val); _spaces_gaps_out_right_set = true end
    if _key == "gaps_out_bottom" then _spaces_gaps_out_bottom = tonumber(_val); _spaces_gaps_out_bottom_set = true end
    if _key == "waybar" then _spaces_waybar_legacy = tonumber(_val) end
    if _key == "waybar_top" then _spaces_waybar_top = tonumber(_val); _spaces_waybar_top_set = true end
    if _key == "waybar_left" then _spaces_waybar_left = tonumber(_val); _spaces_waybar_left_set = true end
    if _key == "waybar_right" then _spaces_waybar_right = tonumber(_val); _spaces_waybar_right_set = true end
    if _key == "waybar_bottom" then _spaces_waybar_bottom = tonumber(_val); _spaces_waybar_bottom_set = true end
    local _pos_key, _pos_val = _line:match("^([%w_]+)=([%a]+)$")
    if _pos_key == "waybar_pos" and (_pos_val == "top" or _pos_val == "bottom") then _spaces_waybar_pos = _pos_val end
  end
  _spaces_file:close()
end

if _spaces_waybar_legacy then
  if not _spaces_waybar_top_set then _spaces_waybar_top = _spaces_waybar_legacy end
  if not _spaces_waybar_left_set then _spaces_waybar_left = _spaces_waybar_legacy end
  if not _spaces_waybar_right_set then _spaces_waybar_right = _spaces_waybar_legacy end
  if not _spaces_waybar_bottom_set then _spaces_waybar_bottom = _spaces_waybar_legacy end
end

if _spaces_gaps_out_legacy then
  if not _spaces_gaps_out_top_set then _spaces_gaps_out_top = _spaces_gaps_out_legacy end
  if not _spaces_gaps_out_left_set then _spaces_gaps_out_left = _spaces_gaps_out_legacy end
  if not _spaces_gaps_out_right_set then _spaces_gaps_out_right = _spaces_gaps_out_legacy end
  if not _spaces_gaps_out_bottom_set then _spaces_gaps_out_bottom = _spaces_gaps_out_legacy end
end

-- spaces-switch.sh materializes this derived file before startup/reload. Lua
-- consumes it so startup and Apply use exactly the same effective geometry.
local _effective_spaces_path = _generated_config .. "/spaces-effective.conf"
local _effective_spaces_file = io.open(_effective_spaces_path)
local _spaces_effective_top
local _spaces_effective_right
local _spaces_effective_bottom
local _spaces_effective_left
if _effective_spaces_file then
  for _line in _effective_spaces_file:lines() do
    local _key, _val = _line:match("^([%w_]+)=(%d+)$")
    if _key == "effective_top" then _spaces_effective_top = tonumber(_val) end
    if _key == "effective_right" then _spaces_effective_right = tonumber(_val) end
    if _key == "effective_bottom" then _spaces_effective_bottom = tonumber(_val) end
    if _key == "effective_left" then _spaces_effective_left = tonumber(_val) end
  end
  _effective_spaces_file:close()
end

-- Bootstrap normally creates the generated file. Keep a deterministic
-- fallback for a direct compositor start before the first session prepare.
if not _spaces_effective_top or not _spaces_effective_right or
   not _spaces_effective_bottom or not _spaces_effective_left then
  _spaces_effective_top = _spaces_gaps_out_top
  _spaces_effective_right = _spaces_gaps_out_right
  _spaces_effective_bottom = _spaces_gaps_out_bottom
  _spaces_effective_left = _spaces_gaps_out_left
  if _spaces_waybar_pos == "top" then
    _spaces_effective_top = math.max(0, _spaces_gaps_out_top - _spaces_waybar_bottom)
  elseif _spaces_waybar_pos == "bottom" then
    _spaces_effective_bottom = math.max(0, _spaces_gaps_out_bottom - _spaces_waybar_top)
  end
end

theme.gaps_out = {
  top = _spaces_effective_top,
  right = _spaces_effective_right,
  bottom = _spaces_effective_bottom,
  left = _spaces_effective_left,
}

-- Border rounding/thickness follow /layout through data/.borders for the same
-- reason as .spaces: the projection is authoritative, not the theme suffix.
local _borders_path = _first_existing({
  _data_home .. "/.borders",
  _state_home .. "/.borders",
  _config_home .. "/.borders",
})
local _borders_file = io.open(_borders_path)
local _borders_rounded = _layout_variant == "float" and 1 or 0
local _borders_rounding = _layout_variant == "float" and 4 or 0
local _borders_thickness = 1
if _borders_file then
  for _line in _borders_file:lines() do
    local _key, _val = _line:match("^([%w_]+)=(%d+)$")
    if _key == "rounded" then _borders_rounded = tonumber(_val) end
    if _key == "rounding" then _borders_rounding = tonumber(_val) end
    if _key == "thickness" then _borders_thickness = tonumber(_val) end
  end
  _borders_file:close()
end

-- A disabled Rounded switch deliberately makes window corners straight. The
-- configured value is retained so enabling it again restores that value.
if _borders_rounded == 1 then
  theme.rounding = math.min(math.max(_borders_rounding, 2), 10)
else
  theme.rounding = 0
end
theme.border_size = math.min(math.max(_borders_thickness, 0), 10)

-- Virtual machine compatibility -------------------------------------------------------------------
-- ARGVUS_VIRTUALIZATION is published by argvus-start and is the authoritative
-- answer for the running session. Only probe systemd-detect-virt when it is
-- absent. Both report the literal "none" on a physical machine, so that string
-- must never be treated as a VM: doing so silently turned every effect off
-- (animations, transparency, blur, shadows) and forced software rendering.
local function _is_virtual_machine()
  local published = os.getenv("ARGVUS_VIRTUALIZATION")
  if published and published ~= "" then
    return published ~= "none"
  end

  local pipe = io.popen("systemd-detect-virt --vm 2>/dev/null")
  if not pipe then
    return false
  end

  local virt = pipe:read("*l")
  pipe:close()

  if not virt or virt == "" or virt == "none" then
    return false
  end

  return true
end

local _is_vm = _is_virtual_machine()
local _low_power_session = os.getenv("ARGVUS_LOW_POWER") == "1" or _is_vm
local _legacy_effects_state = _read_first_line({
  _data_home .. "/state/effects",
  _state_home .. "/state/effects",
  _state_home .. "/effects",
})
local function _component_enabled(component)
  local state = _read_first_line({
    _data_home .. "/state/" .. component,
    _state_home .. "/state/" .. component,
    _state_home .. "/" .. component,
  }) or _legacy_effects_state
  return state == "enabled" or (state ~= "disabled" and not _low_power_session)
end
local _animations_enabled = _component_enabled("animations")
local _transparency_enabled = _component_enabled("transparency")
local function _canonical_value(pointer)
  local pipe = io.popen("argvus-config get " .. pointer .. " --effective --raw 2>/dev/null")
  if not pipe then return nil end
  local value = pipe:read("*l")
  pipe:close()
  return value
end
local _global_blur_enabled = _canonical_value("/effects/blur_global_enabled")
  ~= "false"
local _global_blur_value = tonumber(_canonical_value("/effects/blur_global_value")) or 50
_global_blur_value = math.min(math.max(_global_blur_value, 0), 100)
local _blur_enabled = _component_enabled("blur") and _global_blur_enabled

local _theme_effects_path = _first_existing({
  _data_home .. "/state/effects/" .. _theme_name .. ".conf",
  _state_home .. "/state/effects/" .. _theme_name .. ".conf",
})
local function _theme_effect_value(key, fallback)
  local file = io.open(_theme_effects_path, "r")
  if not file then
    return fallback
  end
  local value = fallback
  for line in file:lines() do
    local candidate, raw = line:match("^([%w%-]+%.[%w%-]+)=(%d+)$")
    if candidate == key then
      local parsed = tonumber(raw)
      if parsed then
        value = math.min(math.max(parsed, 0), 100)
      end
    end
  end
  file:close()
  return value
end

local function _theme_effect_enabled(key, fallback)
  local file = io.open(_theme_effects_path, "r")
  if not file then return fallback end
  for line in file:lines() do
    local name, value = line:match("^([^=]+)=(%S+)$")
    if name == key .. ".enabled" then
      file:close()
      return value == "enabled"
    end
  end
  file:close()
  return fallback
end

-- ARGVUS never applies compositor opacity. Dimming is produced by exactly two
-- mechanisms: transparency, where the client renders its own background with
-- alpha derived from /effects/transparency_*, and blur, where the compositor
-- blurs whatever sits behind the surface. Hyprland opacity multipliers scale
-- the whole surface including its content, which is a different visual and
-- makes the Control Center settings disagree with what is actually rendered.
-- The terminal follows the same contract: argvus-terminal reads
-- /effects/transparency_terminal_* and writes the Kitty background_opacity
-- itself, so the compositor has nothing to dim there.

if _is_vm then
  hl.env("LIBGL_ALWAYS_SOFTWARE", "1")
  hl.env("ARGVUS_LOW_POWER", "1")
end

-- Monitor -----------------------------------------------------------------------------------------
-- Default fallback: any monitor, preferred mode, auto position, scale 1.
-- Generated state from argvus-display may override this.
hl.monitor({
  output = "", -- "" = any monitor
  mode = "preferred", -- "preferred" = any mode
  position = "auto", -- "auto" = automatic
  scale = 1,
})

-- Generated monitor state (produced by argvus-display / nwg-displays adapter)
local _generated_monitors = _generated_config .. "/hypr/monitors.lua"
if _path_exists(_generated_monitors) then
  local _ok, _err = pcall(dofile, _generated_monitors)
  if not _ok then
    print("ARGVUS: ignoring invalid generated monitor config: " .. tostring(_err))
  end
end

-- Environment variables ---------------------------------------------------------------------------

-- Cursor size
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_SIZE", "24")
-- Forces Qt apps to use Kvantum as their theme engine
-- hl.env("QT_STYLE_OVERRIDE", "kvantum")
-- Use qt6ct to configure Qt (font, icons, style)
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
-- Use Hyprland's Qt Quick Controls style for Hypr* Qt/QML apps
hl.env("QT_QUICK_CONTROLS_STYLE", "org.hyprland.style")
-- Forces Firefox to run natively on Wayland
hl.env("MOZ_ENABLE_WAYLAND", "1")
-- XDGs
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
-- This file is re-evaluated on every hyprctl reload (theme switches trigger one), and the
-- compositor keeps the value between evaluations. Entries are deduplicated so XDG_CONFIG_DIRS
-- stays bounded instead of gaining the ARGVUS block again on each reload.
local _argvus_config_dirs = {
  _system_config .. "/portal/config",
  _system_config .. "/appearance/config",
  _system_config .. "/app-profiles/config",
  _system_config .. "/terminal/config",
  _system_config .. "/launcher/config",
  _system_config .. "/notifications/config",
  _system_config .. "/network/config",
  _system_config .. "/control-panel/config",
  _system_config .. "/taskbar/config",
  _system_config,
}

local function _merge_config_dirs(inherited)
  local seen, merged = {}, {}
  local function add(dir)
    if dir ~= "" and not seen[dir] then
      seen[dir] = true
      merged[#merged + 1] = dir
    end
  end
  for _, dir in ipairs(_argvus_config_dirs) do
    add(dir)
  end
  for dir in string.gmatch(inherited .. ":", "([^:]*):") do
    add(dir)
  end
  return table.concat(merged, ":")
end

hl.env("XDG_CONFIG_DIRS", _merge_config_dirs(os.getenv("XDG_CONFIG_DIRS") or "/etc/xdg"))
local _active_theme_for_yazi = _read_first_line({
  _data_home .. "/.active-theme",
  _state_home .. "/.active-theme",
  _system_config .. "/argvus/.active-theme",
}) or "argvus-dark"
local _native_yazi_config = _config_home .. "/yazi"
local _argvus_yazi_config = _data_home .. "/yazi"
local _yazi_config_home = _system_config .. "/app-profiles/config/yazi"
if _path_exists(_native_yazi_config .. "/flavors/" .. _active_theme_for_yazi .. ".yazi/flavor.toml") then
  _yazi_config_home = _native_yazi_config
elseif _path_exists(_argvus_yazi_config .. "/flavors/" .. _active_theme_for_yazi .. ".yazi/flavor.toml") then
  _yazi_config_home = _data_home .. "/yazi"
end
hl.env("YAZI_CONFIG_HOME", _yazi_config_home)
-- Theme
-- hl.env("GTK2_RC_FILES", "/dev/null")
-- hl.env("GTK_THEME", "Hyprland-Dark-Teal")

-- Variables ---------------------------------------------------------------------------------------
local mod = "SUPER"
local _terminal_bin = _get_default("terminal")
-- Keep explicit config paths for terminals that do not read Argvus' per-user tree.
local terminal
if _terminal_bin == "kitty" then
  terminal = "kitty"
elseif _terminal_bin == "argvus-terminal" then
  terminal = "argvus-terminal"
elseif _terminal_bin == "foot" then
  -- Legacy sessions may still select foot, which ARGVUS no longer ships.
  -- Map it to kitty so the binding does not target a missing binary.
  terminal = "kitty"
else
  terminal = _terminal_bin
end
-- Default File Manager: the state may hold a TUI (runs in the terminal) or a
-- GUI file manager. TUI ones launch through the terminal like the old spf.
local _tui_file_managers = {
  ["argvus --spf"] = true, ["argvus --yazy"] = true, ["argvus --yazi"] = true,
  spf = true, superfile = true, yazi = true, ranger = true, lf = true,
  joshuto = true, broot = true, mc = true, nnn = true,
}
local _argvus_file_manager_wrappers = {
  spf = "argvus --spf",
  superfile = "argvus --spf",
  yazi = "argvus --yazy",
}
local _file_manager_bin = _get_default("file_manager")
local _file_manager_cmd = _argvus_file_manager_wrappers[_file_manager_bin] or _file_manager_bin
local file_manager
if _tui_file_managers[_file_manager_cmd] then
  file_manager = "argvus-tui-terminal --class argvus-file-manager --term kitty -- " .. _file_manager_cmd
else
  file_manager = _file_manager_cmd
end
local rofi_config = string.format("%q", _rofi_config_path())

-- Global configuration ----------------------------------------------------------------------------
hl.config({
  general = {
    gaps_in = theme.gaps_in,
    gaps_out = theme.gaps_out,
    border_size = theme.border_size,

    col = {
      active_border = theme.border_active,
      inactive_border = theme.border_inactive,
    },
    layout = "dwindle",
    allow_tearing = false,
  },

  group = {
    merge_groups_on_drag = true,
    col = {
      border_active = theme.border_active,
      border_inactive = theme.border_inactive,
      border_locked_active = theme.border_active,
      border_locked_inactive = theme.border_inactive,
    },

    groupbar = {
      enabled = true,
      font_family = _argvus_font_family,
      font_size = _argvus_font_size,
      render_titles = false,
      text_color = "rgba(ffffffff)",
      col = {
        active = theme.groupbar_active,
        inactive = theme.groupbar_inactive,
        locked_active = theme.groupbar_active,
        locked_inactive = theme.groupbar_inactive,
      },
    },
  },

  decoration = {
    rounding = theme.rounding,
    rounding_power = theme.rounding_power,
    dim_inactive = false,
    dim_strength = 0.08,

    shadow = {
      enabled = _transparency_enabled,
      range = _transparency_enabled and 6 or 0,
      render_power = 2,
      color = theme.shadow_color,
      color_inactive = theme.shadow_color_inactive,
    },

    blur = {
      enabled = _blur_enabled and _global_blur_value > 0,
      size = math.max(1, math.floor(_global_blur_value / 10)),
      passes = 1,
      new_optimizations = true,
      xray = false,
      noise = 0.0,
      contrast = 0.9,
      brightness = 0.8,
      vibrancy = 0.1,
      ignore_opacity = false,
      popups = false,
    },
  },

  animations = {
    enabled = _animations_enabled,
  },

  dwindle = {
    preserve_split = true,
  },

  master = {
    new_status = "master",
  },

  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    -- The default splash fallback is #101218. Dynamic theme colors are drawn
    -- by the layer-shell client once its first frame arrives.
    background_color = "rgb(16, 18, 24)",
    font_family = _argvus_font_family,
    splash_font_family = _argvus_font_family,
  },

  debug = {
    disable_logs = not _debug_session,
    enable_stdout_logs = _debug_session,
    colored_stdout_logs = false,
  },

  cursor = {
    no_hardware_cursors = 2,
    use_cpu_buffer = 2,
  },

  render = {
    new_render_scheduling = true,
  },

  -- XWayland enabled/disabled
  xwayland = { enabled = true },

  input = {
    kb_layout = _argvus_input.kb_layout,
    kb_variant = _argvus_input.kb_variant,
    kb_options = _argvus_input.kb_options,
    numlock_by_default = true,
    follow_mouse = 1,
    -- Mouse acceleration (disable)
    sensitivity = _argvus_input_settings.sensitivity or 0,
    accel_profile = _argvus_input_settings.accel_profile or "flat",
    natural_scroll = _argvus_input_settings.natural_scroll or false,
    scroll_factor = _argvus_input_settings.scroll_factor or 1,
    left_handed = _argvus_input_settings.left_handed or false,
    --
    touchpad = {
      natural_scroll = _input_bool(_argvus_touchpad_settings, "natural_scroll", false),
      tap_to_click = _input_bool(_argvus_touchpad_settings, "tap_to_click", true),
      tap_and_drag = _input_bool(_argvus_touchpad_settings, "tap_and_drag", true),
      clickfinger_behavior = _input_bool(_argvus_touchpad_settings, "clickfinger_behavior", false),
      disable_while_typing = _input_bool(_argvus_touchpad_settings, "disable_while_typing", true),
      middle_button_emulation = true,
      drag_lock = true,
    },
  },
})

-- Gestures ----------------------------------------------------------------------------------------
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- XWayland ----------------------------------------------------------------------------------------
-- -- Prevent invisible XWayland ghost windows from stealing focus
-- -- Use with: xwayland = { enabled = true }
hl.window_rule({
  match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
  no_focus = true,
})

-- Animations --------------------------------------------------------------------------------------
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("smoothOut", { type = "bezier", points = { { 0.36, 0 }, { 0.66, -0.56 } } })
hl.curve("smoothIn", { type = "bezier", points = { { 0.25, 1 }, { 0.5, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })

hl.animation({ leaf = "global", enabled = _animations_enabled, speed = 1, bezier = "default" })
hl.animation({
  leaf = "windows",
  enabled = _animations_enabled,
  speed = 5,
  bezier = "myBezier",
})
hl.animation({
  leaf = "windowsIn",
  enabled = _animations_enabled,
  speed = 5,
  bezier = "myBezier",
  style = "popin 80%",
})
hl.animation({
  leaf = "windowsOut",
  enabled = _animations_enabled,
  speed = 4,
  bezier = "smoothOut",
  style = "popin 80%",
})
hl.animation({ leaf = "border", enabled = _animations_enabled, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade", enabled = _animations_enabled, speed = 5, bezier = "smoothIn" })
hl.animation({
  leaf = "fadeOut",
  enabled = _animations_enabled,
  speed = 4,
  bezier = "smoothOut",
})
hl.animation({
  leaf = "workspaces",
  enabled = _animations_enabled,
  speed = 5,
  bezier = "myBezier",
  style = "slide",
})

-- Blur --------------------------------------------------------------------------------------------
-- Hyprland runs a single global blur pass. Layer rules only opt individual layer
-- surfaces in; translucent toplevels such as argvus-terminal take part as soon
-- as the global pass is on, because their background alpha is the surface.
-- Hyprland 0.56 has no positive per-window blur effect, so the terminal is never
-- listed here: adding a window rule could only ever subtract from the global
-- pass. Its blurred backdrop comes from the background alpha that
-- argvus-terminal derives from /effects/transparency_terminal_*.
--
-- The per-surface switches below come from the theme effects state written by
-- the Control Center, so the compositor and the UI never disagree about which
-- ARGVUS surfaces are blurred. A surface without a switch follows the global
-- blur state.
local _blur_layer_surfaces = {
  { namespace = "argvus-taskbar", surface = "taskbar" },
  -- SidebarWindow pins argvus-control-panel. Older builds fall back to the
  -- Quickshell default namespace, so keep matching that too.
  { namespace = "argvus-control-panel|quickshell", surface = "control-panel" },
  { namespace = "argvus-widget-telemetry", surface = "widget-telemetry" },
  { namespace = "argvus-launcher|rofi", surface = "launcher" },
  { namespace = "dunst" },
}

if _blur_enabled then
  local _blur_default = _component_enabled("blur")
  for _, layer in ipairs(_blur_layer_surfaces) do
    local surface = layer.surface
    if surface == nil or _theme_effect_enabled(surface .. ".blur", _blur_default) then
      hl.layer_rule({ match = { namespace = layer.namespace }, blur = true })
    end
  end
end

-- Window Rules  -----------------------------------------------------------------------------------
-- Transparency is a client-side contract: any surface that wants the wallpaper
-- visible behind it renders its own background with alpha from the
-- /effects/transparency_* pointers. The compositor only contributes blur, so no
-- rule below sets opacity. Layer surfaces are handled by their own CSS.

hl.window_rule({
  match = { class = "org.gnome.Nautilus" },
  float = false,
  size = "1399 920",
  center = true,
})
hl.window_rule({
  match = { class = "hyprfm" },
  float = false,
  size = "1399 920",
  center = true,
})
hl.window_rule({
  match = { class = ".*pwvucontrol.*" },
  float = true,
  size = "700 450",
  center = true,
})
hl.window_rule({ match = { class = ".*pavucontrol.*" }, float = true })
hl.window_rule({ match = { class = "org.gnome.FileRoller" }, float = true })
hl.window_rule({ match = { class = "org.gnome.Calculator" }, float = true })
hl.window_rule({ match = { class = "nm-connection-editor" }, float = true })
hl.window_rule({
  match = { class = "kitty", title = ".*nmtui.*" },
  float = true,
  size = "900 900",
  center = true,
})
hl.window_rule({ match = { class = "blueman-manager" }, float = true })
hl.window_rule({ match = { class = "nwg-displays" }, float = true, size = "1100 768", center = true })
hl.window_rule({ match = { class = "xdg-desktop-portal-gtk" }, float = true })
hl.window_rule({
  match = { class = "argvus-cpu|argvus-mem|argvus-taskbar-cpu|argvus-taskbar-mem|cpu-temp-popup|gpu-temp-popup" },
  float = true,
  size = "1399 920",
  center = true,
})
hl.window_rule({
  match = { class = "firefox", title = ".*Picture-in-Picture.*" },
  float = true,
  pin = true,
  size = "420 320",
  center = true,
  keep_aspect_ratio = true,
})
hl.window_rule({ match = { class = "mpv" }, float = true })

-- ARGVUS Control Center: open as a floating, centered terminal window -------------------------------
hl.window_rule({
  match = { class = "argvus-control-center" },
  float = true,
  maximize = false,
  center = true,
  size = "1380 840",
})
hl.window_rule({
  match = { class = "kitty", title = ".*argvus-control-center$" },
  float = true,
  maximize = false,
  center = true,
  size = "1380 840",
})
hl.window_rule({
  match = { class = "argvus-game-snake" },
  float = true,
  maximize = false,
  center = true,
  size = "1380 840",
})
hl.window_rule({
  match = { class = "kitty", title = ".*argvus-game-snake$" },
  float = true,
  maximize = false,
  center = true,
  size = "1380 840",
})

-- Agente de autenticação do PolicyKit (pkexec) ------------------------------------------------------
-- Sem esta regra, a janela do hyprpolkitagent entra no layout em tile atrás/abaixo
-- da argvus-control-panel (que roda em layer-shell "aboveWindows"). O diálogo acaba invisível
-- ou sem foco de teclado, então o usuário nunca consegue digitar a senha e o pkexec
-- expira/falha (ex.: "argvus-accounts name" chamado pelo UserCard). Forçar float + center
-- + pin garante que o prompt sempre apareça no centro da tela, em foco, em qualquer workspace.
hl.window_rule({
  match = { class = "hyprpolkitagent" },
  float = true,
  center = true,
  pin = true,
  size = "420 260",
})

-- ================ Keybindings ================

-- Moving between windows (Using: snappy-switcher) -------------------------------------------------
_argvus_bind("navigation.alt_tab_next", "ALT + Tab", hl.dsp.exec_cmd("snappy-switcher next --mod alt"))
_argvus_bind("navigation.alt_tab_previous", "ALT + SHIFT + Tab", hl.dsp.exec_cmd("snappy-switcher prev --mod alt"))

-- All cheatsheets -----------------------------------------------------------------------------------------------------
_argvus_bind("system.hyprland_cheatsheet", mod .. " + SHIFT + slash", hl.dsp.exec_cmd(_sh(_config_path("hyprland/sh/cheatsheets.sh")) .. " hypr"))

-- Cheatsheets Kitty -------------------------------------------------------------------------------
_argvus_bind("system.kitty_cheatsheet", mod .. " + CTRL + slash", hl.dsp.exec_cmd(_sh(_config_path("launcher/sh/cheatsheets.sh")) .. " kitty"))

-- About ARGVUS ------------------------------------------------------------------------------------
_argvus_bind("system.about", mod .. " + F1", hl.dsp.exec_cmd("argvus --about"))

-- Open Terminal -----------------------------------------------------------------------------------
_argvus_bind("app.terminal", mod .. " + Return", hl.dsp.exec_cmd(terminal))

-- File Manager ------------------------------------------------------------------------------------
_argvus_bind("app.file_manager", mod .. " + Space", hl.dsp.exec_cmd(file_manager))

-- Removable storage -------------------------------------------------------------------------------
_argvus_bind("app.removable_devices", mod .. " + SHIFT + D", hl.dsp.exec_cmd("argvus --removable-devices"))

-- Sidebar Settings --------------------------------------------------------------------------------
_argvus_bind("widget.sidebar", mod .. " + comma", hl.dsp.exec_cmd(_sh(_config_path("control-panel/sh/toggle-sidebar.sh"))))
_argvus_bind("widget.sidebar_mouse", "mouse:274", hl.dsp.exec_cmd(_sh(_config_path("control-panel/sh/toggle-sidebar.sh"))), { mouse = true })

-- Toggle Waybar top -------------------------------------------------------------------------------
_argvus_bind("widget.taskbar_toggle", mod .. " + BackSpace", hl.dsp.exec_cmd("systemctl --user kill --signal=SIGUSR1 argvus-taskbar.service"))

-- Wallpaper settings ------------------------------------------------------------------------------
_argvus_bind("appearance.wallpaper", mod .. " + Y", hl.dsp.exec_cmd("argvus --control-center appearance wallpapers"))

-- Theme switcher ----------------------------------------------------------------------------------
_argvus_bind("appearance.theme", mod .. " + SHIFT + T", hl.dsp.exec_cmd(_sh(_config_path("appearance/sh/theme-switch.sh"))))

-- Sticky/Float layout mode (independent of theme) --------------------------------------------------
-- Named "layout_mode" rather than "mode" to avoid colliding with the
-- pre-existing "appearance.mode" id, which toggles GTK light/dark.
_argvus_bind("appearance.layout_mode", mod .. " + SHIFT + M", hl.dsp.exec_cmd(_sh(_config_path("appearance/sh/layout-mode-menu.sh"))))

-- Inactivity lock timeout -------------------------------------------------------------------------
_argvus_bind("session.idle_timeout", mod .. " + SHIFT + L", hl.dsp.exec_cmd(_sh(_config_path("power/sh/idle-timeout.sh"))))
_argvus_bind("session.keep_awake", mod .. " + ALT + W", hl.dsp.exec_cmd(_sh(_config_path("power/sh/keep-awake.sh")) .. " toggle"))

-- Brightness --------------------------------------------------------------------------------------
_argvus_bind("appearance.brightness", mod .. " + SHIFT + B", hl.dsp.exec_cmd(_sh(_config_path("appearance/sh/brightness-switch.sh"))))

-- Weather location --------------------------------------------------------------------------------
_argvus_bind("widget.weather", mod .. " + SHIFT + W", hl.dsp.exec_cmd(_sh(_config_path("control-panel/sh/weather-location.sh"))))

-- GTK Theme Dark/Light ----------------------------------------------------------------------------
_argvus_bind("appearance.mode", mod .. " + F5", hl.dsp.exec_cmd(_sh(_config_path("appearance/sh/toggle-mode.sh"))))

-- Visual effects ----------------------------------------------------------------------------------
_argvus_bind("appearance.animations", mod .. " + F6", hl.dsp.exec_cmd(_sh(_config_path("session/sh/effects-toggle.sh")) .. " animations toggle"))

-- Finder ------------------------------------------------------------------------------------------
local _launcher_bin = _get_default("launcher")
local _launcher_cmd
if _launcher_bin == "rofi" or _launcher_bin == "" then
  _launcher_cmd = "argvus-launcher --config " .. rofi_config
else
  _launcher_cmd = _launcher_bin .. " --show drun"
end
_argvus_bind("app.launcher", mod .. " + D", hl.dsp.exec_cmd(_launcher_cmd))

-- ARGVUS Control Center ----------------------------------------------------------------------------
_argvus_bind("system.control_center", mod .. " + ALT + C", hl.dsp.exec_cmd("argvus --control-center"))

-- Maximize Window ---------------------------------------------------------------------------------
_argvus_bind("window.maximize", mod .. " + S", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))

-- Closed Window -----------------------------------------------------------------------------------
_argvus_bind("window.close", mod .. " + Q", hl.dsp.window.close())

-- Enable/Disable Floating Window ------------------------------------------------------------------
_argvus_bind("window.toggle_floating", mod .. " + SHIFT + space", function()
  hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
  hl.exec_scheduled_prop_refresh_immediately()

  local win = hl.get_active_window()

  if win and win.floating then
    hl.dispatch(hl.dsp.window.resize({
      x = 1399,
      y = 920,
    }))

    hl.dispatch(hl.dsp.window.center())
  end
end)

-- Window fullscreen -------------------------------------------------------------------------------
_argvus_bind("window.fullscreen", mod .. " + F", hl.dsp.window.fullscreen())

-- Split vertical/horizontal -----------------------------------------------------------------------
_argvus_bind("window.toggle_split", mod .. " + E", hl.dsp.layout("togglesplit"))

-- Tabbed windows ----------------------------------------------------------------------------------
-- Groups all windows in the current workspace into tabs.
_argvus_bind("window.group_tabs", mod .. " + W", function()
  local active = hl.get_active_window()
  if not active then
    return
  end

  local ws = active.workspace.id

  hl.dispatch(hl.dsp.group.toggle())

  for _, w in ipairs(hl.get_windows()) do
    if w.workspace.id == ws and w.address ~= active.address then
      hl.dispatch(hl.dsp.focus({
        window = "address:" .. w.address,
      }))

      for _, dir in ipairs({ "l", "r", "u", "d" }) do
        pcall(function()
          hl.dispatch(hl.dsp.window.move({
            into_group = dir,
          }))
        end)
      end
    end
  end

  hl.dispatch(hl.dsp.focus({
    window = "address:" .. active.address,
  }))
end)

-- Navigate between tabs ---------------------------------------------------------------------------
_argvus_bind("window.next_tab", mod .. " + Tab", hl.dsp.group.next())

-- Navigate between windows ------------------------------------------------------------------------
_argvus_bind("focus.left", mod .. " + left", hl.dsp.focus({ direction = "left" }))
_argvus_bind("focus.right", mod .. " + right", hl.dsp.focus({ direction = "right" }))
_argvus_bind("focus.up", mod .. " + up", hl.dsp.focus({ direction = "up" }))
_argvus_bind("focus.down", mod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Cycle focus between all windows in current workspace (including floating) -----------------------
_argvus_bind("focus.cycle_right", mod .. " + CTRL + right", function()
  local wins = hl.get_windows()
  local active = hl.get_active_window()
  if not active then
    return
  end

  -- Filter only current workspace
  local ws_wins = {}
  for _, w in ipairs(wins) do
    if w.workspace.id == active.workspace.id then
      table.insert(ws_wins, w)
    end
  end

  for i, w in ipairs(ws_wins) do
    if w.address == active.address then
      local next = ws_wins[i + 1] or ws_wins[1]
      hl.dispatch(hl.dsp.focus({ window = "address:" .. next.address }))
      break
    end
  end
end)

_argvus_bind("focus.cycle_left", mod .. " + CTRL + left", function()
  local wins = hl.get_windows()
  local active = hl.get_active_window()
  if not active then
    return
  end

  local ws_wins = {}
  for _, w in ipairs(wins) do
    if w.workspace.id == active.workspace.id then
      table.insert(ws_wins, w)
    end
  end

  for i, w in ipairs(ws_wins) do
    if w.address == active.address then
      local prev = ws_wins[i - 1] or ws_wins[#ws_wins]
      hl.dispatch(hl.dsp.focus({ window = "address:" .. prev.address }))
      break
    end
  end
end)

-- Cycle workspaces in loop (like GNOME) -----------------------------------------------------------
local function get_sorted_workspaces()
  local workspaces = hl.get_workspaces()
  local ws_ids = {}

  for _, ws in ipairs(workspaces) do
    if ws.id > 0 then
      table.insert(ws_ids, ws.id)
    end
  end

  table.sort(ws_ids)
  return ws_ids
end

local function cycle_workspace(offset)
  local active = hl.get_active_workspace()
  if not active then
    return
  end

  local ws_ids = get_sorted_workspaces()
  if #ws_ids == 0 then
    return
  end

  for i, id in ipairs(ws_ids) do
    if id == active.id then
      local target_index = ((i - 1 + offset) % #ws_ids) + 1

      hl.dispatch(hl.dsp.focus({
        workspace = ws_ids[target_index],
      }))

      return
    end
  end
end

local function workspace_next()
  cycle_workspace(1)
end

local function workspace_prev()
  cycle_workspace(-1)
end

_argvus_bind("workspace.next", "CTRL + ALT + right", workspace_next)
_argvus_bind("workspace.previous", "CTRL + ALT + left", workspace_prev)
_argvus_bind("workspace.next_mouse", "mouse:276", workspace_next, { mouse = true })
_argvus_bind("workspace.previous_mouse", "mouse:275", workspace_prev, { mouse = true })

-- Move window float -------------------------------------------------------------------------------
_argvus_bind("window.move_left", mod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
_argvus_bind("window.move_right", mod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
_argvus_bind("window.move_up", mod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
_argvus_bind("window.move_down", mod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))

-- Workspaces 1–9 ----------------------------------------------------------------------------------
for i = 1, 9 do
  _argvus_bind("workspace.switch." .. i, mod .. " + " .. i, hl.dsp.focus({ workspace = i }))
  _argvus_bind("workspace.move." .. i, mod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Volume ------------------------------------------------------------------------------------------
_argvus_bind("session.volume_up",
  "XF86AudioRaiseVolume",
  hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true }
)
-- Keep the remaining media defaults in the same override contract.
_argvus_bind("session.volume_down", "XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
_argvus_bind("session.mute", "XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })

-- Brightness --------------------------------------------------------------------------------------
_argvus_bind("session.brightness_up", "XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"), { locked = true, repeating = true })
_argvus_bind("session.brightness_down", "XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })

-- Multimidia --------------------------------------------------------------------------------------
_argvus_bind("session.play_pause", "XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
_argvus_bind("session.next_track", "XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
_argvus_bind("session.previous_track", "XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
_argvus_bind("session.stop_track", "XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"))

-- Turn the monitor off/on -------------------------------------------------------------------------
_argvus_bind("session.dpms", mod .. " + SHIFT + S", hl.dsp.dpms({ action = "toggle" }))

-- Default browser ---------------------------------------------------------------------------------
local _browser_bin = _get_default("browser")
local _browser_cmd
if _browser_bin == "xdg-open" or _browser_bin == "" then
  _browser_cmd = "xdg-open https://"
else
  _browser_cmd = _browser_bin .. " https://"
end
_argvus_bind("app.browser", mod .. " + B", hl.dsp.exec_cmd(_browser_cmd))

-- Screen recording --------------------------------------------------------------------------------
_argvus_bind("record.toggle", mod .. " + G", hl.dsp.exec_cmd(_sh(_config_path("hyprland/sh/hypr-screenshot.sh")) .. " --video-full"))
_argvus_bind("record.stop", mod .. " + SHIFT + G", hl.dsp.exec_cmd(_sh(_config_path("hyprland/sh/hypr-screenshot.sh")) .. " --video-full-stop"))

-- Clipboard history -------------------------------------------------------------------------------
_argvus_bind("system.clipboard", mod .. " + H", hl.dsp.exec_cmd("cliphist list | rofi -config " .. rofi_config .. " -dmenu -i -p \"$(argvus-i18n get hyprland clipboard.search)\" | cliphist decode | wl-copy"))
_argvus_bind("system.clipboard_clear", mod .. " + SHIFT + H", hl.dsp.exec_cmd('cliphist wipe && notify-send "$(argvus-i18n get hyprland clipboard.title)" "$(argvus-i18n get hyprland clipboard.history_erased)"'))

-- Screenshot / Print ------------------------------------------------------------------------------
_argvus_bind("screenshot.region", "Print", hl.dsp.exec_cmd(_sh(_config_path("hyprland/sh/hypr-screenshot.sh")) .. " --image-region"))
_argvus_bind("screenshot.window", mod .. " + Print", hl.dsp.exec_cmd(_sh(_config_path("hyprland/sh/hypr-screenshot.sh")) .. " --image-window"))
_argvus_bind("screenshot.fullscreen", mod .. " + SHIFT + Print", hl.dsp.exec_cmd(_sh(_config_path("hyprland/sh/hypr-screenshot.sh")) .. " --image-full"))

-- Mode Resize Window (keyboard) -------------------------------------------------------------------
local _in_resize = false

_argvus_bind("resize.enter", mod .. " + R", function()
  local w = hl.get_active_window()
  if w == nil then
    return
  end

  -- Toggle off
  if _in_resize then
    _in_resize = false
    hl.dispatch(hl.dsp.submap("reset"))
    return
  end

  -- Only enter resize if window is floating
  if not w.floating then
    return
  end

  _in_resize = true
  hl.dispatch(hl.dsp.submap("resize"))
end)

hl.define_submap("resize", function()
  _argvus_bind("resize.right", "right", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
  _argvus_bind("resize.left", "left", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
  _argvus_bind("resize.down", "down", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
  _argvus_bind("resize.up", "up", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })

  -- Move window
  _argvus_bind("resize.move_right", "SHIFT + right", hl.dsp.window.move({ x = 20, y = 0, relative = true }), { repeating = true })
  _argvus_bind("resize.move_left", "SHIFT + left", hl.dsp.window.move({ x = -20, y = 0, relative = true }), { repeating = true })
  _argvus_bind("resize.move_down", "SHIFT + down", hl.dsp.window.move({ x = 0, y = 20, relative = true }), { repeating = true })
  _argvus_bind("resize.move_up", "SHIFT + up", hl.dsp.window.move({ x = 0, y = -20, relative = true }), { repeating = true })

  -- Escape/Return: exits submap
  _argvus_bind("resize.cancel_escape", "escape", function()
    _in_resize = false
    hl.dispatch(hl.dsp.submap("reset"))
  end)
  _argvus_bind("resize.cancel_return", "Return", function()
    _in_resize = false
    hl.dispatch(hl.dsp.submap("reset"))
  end)
end)

-- Mode Resize Window (witch mouse) ----------------------------------------------------------------
_argvus_bind("window.drag_mouse", mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
_argvus_bind("window.resize_mouse", mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Emoji picker ------------------------------------------------------------------------------------
_argvus_bind("system.emoji_picker", mod .. " + period", hl.dsp.exec_cmd(_sh(_config_path("launcher/sh/emoji-picker.sh"))))

-- Color Picker ------------------------------------------------------------------------------------
_argvus_bind("system.color_picker", mod .. " + P", hl.dsp.exec_cmd("hyprpicker -a"))

-- Calculator --------------------------------------------------------------------------------------
_argvus_bind("app.calculator", mod .. " + C", hl.dsp.exec_cmd("rofi -config " .. rofi_config .. " -show calc -modi calc -no-show-match -no-sort"))

-- Exit Hyprland -----------------------------------------------------------------------------------
_argvus_bind("session.exit", mod .. " + escape", hl.dsp.exec_cmd(_sh(_config_path("power/sh/hypr-power-menu.sh"))))

-- Lock session ------------------------------------------------------------------------------------
_argvus_bind("session.lock", mod .. " + L", hl.dsp.exec_cmd(_sh(_config_path("power/sh/hypr-power-menu.sh")) .. " --lock"))

-- Reload Hyprland ---------------------------------------------------------------------------------
_argvus_bind("session.reload", mod .. " + SHIFT + R", hl.dsp.exec_cmd("argvus-sessionctl reload"))

-- Move the waybar status bar to the top/bottom ----------------------------------------------------
-- Use absolute paths so the bind works even when hyprland's env is minimal.
-- Bind arrow keys to move the waybar; keep a single binding per direction
_argvus_bind("widget.waybar_top", mod .. " + ALT + up", hl.dsp.exec_cmd("sh /usr/share/argvus/hyprland/sh/spaces-switch.sh --set waybar_pos top"))
_argvus_bind("widget.waybar_bottom", mod .. " + ALT + down", hl.dsp.exec_cmd("sh /usr/share/argvus/hyprland/sh/spaces-switch.sh --set waybar_pos bottom"))

-- User overrides ----------------------------------------------------------------------------------
-- monitors.lua: generated state loaded above, then user override takes precedence.
_load_user_override("monitors.lua")
_load_user_override("rules.lua")
_load_user_override("bindings.lua")
_load_user_override("user.lua")

-- Autostart ---------------------------------------------------------------------------------------
hl.on("hyprland.start", function()
  hl.exec_cmd("argvus-sessionctl ready")
end)
