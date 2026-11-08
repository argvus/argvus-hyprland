-- Global policy layered over the normal per-application window rules.
-- The registry is session state, not user configuration. Persist it before
-- changing a window so a configuration reload cannot lose its tiled origin.
return function(initial_mode, controls)
  local runtime = assert(os.getenv("XDG_RUNTIME_DIR"), "XDG_RUNTIME_DIR is required")
  local signature = assert(os.getenv("HYPRLAND_INSTANCE_SIGNATURE"), "Hyprland instance is required")
  assert(not signature:find("/", 1, true), "invalid Hyprland instance")
  local prefix = runtime .. "/argvus/window-mode-" .. signature
  local registry_path = prefix .. ".lua"
  local status_path = prefix .. ".status"
  local registry = {}
  local native_floats = {}
  local mode = "tile"
  local applied = "tile"
  local last_error = ""
  local changing = false
  local opened = {}
  for _, window in ipairs(hl.get_windows()) do
    opened[window.address] = true
  end

  local function atomic_write(path, contents)
    local temporary = path .. ".tmp"
    local file = assert(io.open(temporary, "w"))
    assert(file:write(contents))
    assert(file:close())
    assert(os.rename(temporary, path))
  end

  local function identity(window)
    return tostring(window.pid) .. ":" .. (window.initial_class or "")
  end

  local function save_registry()
    local lines = { "return {" }
    for address, origin in pairs(registry) do
      lines[#lines + 1] = string.format("[%q] = %q,", address, origin)
    end
    lines[#lines + 1] = "}\n"
    atomic_write(registry_path, table.concat(lines, "\n"))
  end

  local stored = io.open(registry_path, "r")
  if stored then
    local contents = assert(stored:read("*a"))
    stored:close()
    -- A malformed registry must not be overwritten: it may contain the only
    -- record of windows converted before a reload.
    registry = assert(load(contents, "window mode registry", "t", {}))()
    assert(type(registry) == "table", "invalid window mode registry")
  end

  for _, window in ipairs(hl.get_windows()) do
    if window.floating and not registry[window.address] then
      native_floats[window.address] = identity(window)
    end
  end

  local function write_status()
    atomic_write(status_path, applied .. "\n" .. last_error:gsub("[\r\n]", " ") .. "\n")
  end

  local function float_window(window)
    -- Application float rules may have a pending state refresh at openLate.
    -- Observe their effective result before recording a tiled origin.
    if window.floating and not registry[window.address] then
      native_floats[window.address] = identity(window)
    end
    hl.exec_scheduled_prop_refresh_immediately()
    if window.floating and not registry[window.address] then
      native_floats[window.address] = identity(window)
    end
    if not window.mapped or window.floating then
      return
    end
    local address = window.address
    -- Decoration/layout refreshes can transiently report a native floater as
    -- tiled. Reassert Floating without changing the origin observed at open.
    if native_floats[address] ~= identity(window) then
      registry[address] = identity(window)
      save_registry()
    end
    hl.dispatch(hl.dsp.window.float({ action = "set", window = window }))
    hl.exec_scheduled_prop_refresh_immediately()
    assert(window.floating, "could not float window " .. address)
  end

  local function reconcile()
    local live = {}
    for _, window in ipairs(hl.get_windows()) do
      local address = window.address
      live[address] = identity(window)
      if registry[address] and registry[address] ~= live[address] then
        registry[address] = nil
      end
    end
    for address, origin in pairs(registry) do
      if live[address] ~= origin then
        registry[address] = nil
      end
    end
    save_registry()
  end

  local function apply(next_mode)
    assert(next_mode == "tile" or next_mode == "floating", "invalid window mode")
    if next_mode == "floating" and mode ~= "floating" then
      for _, window in ipairs(hl.get_windows()) do
        native_floats[window.address] = window.floating and not registry[window.address] and identity(window) or nil
      end
    end
    mode = next_mode
    changing = true
    local ok, failure = pcall(function()
      reconcile()
      -- Snapshot every tiled member before a dispatcher can affect its group.
      if mode == "floating" then
        for _, window in ipairs(hl.get_windows()) do
          if window.mapped and not window.floating and native_floats[window.address] ~= identity(window) then
            registry[window.address] = identity(window)
          end
        end
        save_registry()
      end
      local failures = {}
      for _, window in ipairs(hl.get_windows()) do
        local succeeded, reason = pcall(function()
          if mode == "floating" then
            float_window(window)
          elseif registry[window.address] == identity(window) then
            -- Pinning is a later explicit request to keep this window floating.
            if window.floating and not window.pinned then
              hl.dispatch(hl.dsp.window.float({ action = "unset", window = window }))
              hl.exec_scheduled_prop_refresh_immediately()
              assert(not window.floating, "could not tile window " .. window.address)
            end
            registry[window.address] = nil
            save_registry()
          end
        end)
        if not succeeded then
          failures[#failures + 1] = tostring(reason)
        end
      end
      assert(#failures == 0, table.concat(failures, "; "))
    end)
    changing = false
    last_error = ok and "" or tostring(failure)
    if ok and controls then
      local controls_ok, controls_error = pcall(controls, mode)
      if not controls_ok then
        last_error = tostring(controls_error)
        print("ARGVUS: window controls: " .. last_error)
      end
    end
    applied = ok and mode or "pending"
    write_status()
    assert(ok, last_error)
  end

  local function enforce(window)
    if mode ~= "floating" or changing then
      return
    end
    changing = true
    local ok, failure = pcall(float_window, window)
    changing = false
    if not ok then
      last_error = tostring(failure)
      applied = "pending"
      write_status()
      print("ARGVUS: window mode: " .. last_error)
    end
  end

  -- window.open is emitted after Hyprland's application rules in 0.57.0.
  hl.on("window.open", function(window)
    opened[window.address] = true
    if window.floating then
      native_floats[window.address] = identity(window)
    end
    enforce(window)
  end)
  hl.on("window.update_state", function(window, changes)
    if opened[window.address] and changes.float == false then
      enforce(window)
    end
  end)
  hl.on("window.close", function(window)
    opened[window.address] = nil
    native_floats[window.address] = nil
    if registry[window.address] then
      registry[window.address] = nil
      save_registry()
    end
  end)

  if controls then
    -- Registered plugins become available after the first configuration pass.
    -- Reconcile decorations after loading, without requiring a manual reload.
    local function configure_after_load()
      local ok, failure = pcall(apply, mode)
      if not ok then
        print("ARGVUS: window controls initialization: " .. tostring(failure))
      end
    end
    hl.on("config.reloaded", configure_after_load)
    hl.on("hyprland.start", configure_after_load)
  end

  local api = {
    apply = apply,
    write_status = write_status,
    is_floating = function()
      return mode == "floating"
    end,
  }
  local ok, failure = pcall(apply, initial_mode)
  if not ok then
    print("ARGVUS: window mode initialization failed: " .. tostring(failure))
  end
  return api
end
