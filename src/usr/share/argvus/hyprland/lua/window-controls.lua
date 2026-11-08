-- Additional server-side title bars are intentionally uniform in Floating.
local plugin = os.getenv("ARGVUS_HYPRBARS_PLUGIN") or "/usr/lib/argvus/hyprland/hyprbars.so"
hl.plugin.load(plugin)

local function palette()
  local config = os.getenv("ARGVUS_CONFIG_HOME") or os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")
  local data = os.getenv("ARGVUS_DATA_HOME") or (config .. "/argvus/data")
  local file = io.open(data .. "/generated/theme/current/window-controls/colors.lua", "r")
  if file then
    local contents = assert(file:read("*a"))
    file:close()
    return assert(load(contents, "window control palette", "t", {}))()
  end
  return { background = "rgb(111316)", foreground = "rgb(eeeeee)", accent = "rgb(3590bd)", close = "rgb(d9534f)" }
end

local function font()
  local config = os.getenv("ARGVUS_CONFIG_HOME") or os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")
  local data = os.getenv("ARGVUS_DATA_HOME") or (config .. "/argvus/data")
  local file = io.open(data .. "/generated/fonts.conf", "r")
  local values = {}
  if file then
    for line in file:lines() do
      local key, value = line:match("^%s*([^=#]+)%s*=%s*(.-)%s*$")
      if key and value and value ~= "" then
        values[key] = value
      end
    end
    file:close()
  end
  return values.system_family or values.default_family or "Sans", tonumber(values.system_size or values.default_size) or 13
end

return function(mode)
  assert(hl.plugin.hyprbars and hl.plugin.hyprbars.clear_buttons, "ARGVUS hyprbars is not available")
  local colors = palette()
  local family, size = font()
  hl.config({
    plugin = {
      hyprbars = {
        bar_height = 28,
        bar_part_of_window = true,
        bar_precedence_over_border = true,
        bar_color = colors.background,
        ["col.text"] = colors.foreground,
        bar_buttons_alignment = "right",
        bar_text_font = family,
        bar_text_size = size,
        on_double_click = "argvus windows maximize @ARGVUS_WINDOW@",
        enabled = mode == "floating",
      },
    },
  })
  hl.plugin.hyprbars.clear_buttons()
  -- Buttons are declared right-to-left by hyprbars. Its patched placeholder
  -- captures the clicked window before any external process can change focus.
  for _, button in ipairs({
    { colors.close, "×", "close" },
    { colors.accent, "□", "maximize" },
    { colors.accent, "−", "minimize" },
  }) do
    hl.plugin.hyprbars.add_button({
      bg_color = button[1],
      fg_color = colors.foreground,
      size = 16,
      icon = button[2],
      action = "argvus windows " .. button[3] .. " @ARGVUS_WINDOW@",
    })
  end
end
