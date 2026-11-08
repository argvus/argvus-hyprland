-- Executed by Hyprland's embedded Lua runtime, never a standalone interpreter.
local actual_hl = hl
local callbacks = {}
local windows = {
  { address = "0x1", pid = 10, initial_class = "terminal", mapped = true, floating = false },
  { address = "0x2", pid = 20, initial_class = "dialog", mapped = true, floating = true },
}
local dispatches = 0
local reject = false
hl = {
  get_windows = function()
    return windows
  end,
  on = function(event, callback)
    callbacks[event] = callback
  end,
  exec_scheduled_prop_refresh_immediately = function()
    for _, window in ipairs(windows) do
      if window.pending_tile then
        window.floating = false
        window.pending_tile = nil
      end
      if window.pending_float then
        window.floating = true
        window.pending_float = nil
      end
    end
  end,
  dsp = { window = {
    float = function(options)
      return options
    end,
  } },
  dispatch = function(options)
    if reject then
      error("injected dispatch failure")
    end
    dispatches = dispatches + 1
    options.window.floating = options.action == "set"
    if callbacks["window.update_state"] then
      callbacks["window.update_state"](options.window, { float = options.window.floating })
    end
  end,
}
local factory = dofile(assert(os.getenv("ARGVUS_WINDOW_MODE_MODULE")))
local api = factory("tile")
api.apply("floating")
assert(windows[1].floating and windows[2].floating)
local before = dispatches
api.apply("floating")
assert(dispatches == before, "repeated apply must be idempotent")
-- A new normal window is tiled after app rules, then converted by policy.
local third = { address = "0x3", pid = 30, initial_class = "browser", mapped = true, floating = false }
windows[3] = third
callbacks["window.open"](third)
assert(third.floating)
-- A dialog already floated by its app rule must never enter the restore set.
local fourth = { address = "0x4", pid = 40, initial_class = "dialog", mapped = true, floating = true }
windows[4] = fourth
callbacks["window.open"](fourth)
-- Simulate shortcut/manual attempt while policy is enforced.
third.floating = false
callbacks["window.update_state"](third, { float = false })
assert(third.floating)
-- Reload: a fresh Lua policy must recover the previous restore set from disk.
callbacks = {}
api = factory("floating")
api.apply("tile")
assert(not windows[1].floating and windows[2].floating and not third.floating and fourth.floating)
-- Closing a window invalidates its address even if the compositor reuses it.
api.apply("floating")
callbacks["window.close"](windows[1])
windows[1] = { address = "0x1", pid = 99, initial_class = "new-dialog", mapped = true, floating = true }
callbacks["window.open"](windows[1])
api.apply("tile")
assert(windows[1].floating, "closed window must not affect reused address")
-- Dispatch failure preserves origin, enabling a subsequent retry.
reject = true
assert(not pcall(api.apply, "floating"))
reject = false
api.apply("floating")
api.apply("tile")
assert(not third.floating and fourth.floating)
-- An explicit pin made during Floating must remain valid after restoration.
api.apply("floating")
third.pinned = true
api.apply("tile")
assert(third.floating and third.pinned)
third.pinned = false
-- Rules evaluating before window.open must not be captured as tiled origin.
local fifth = { address = "0x5", pid = 50, initial_class = "rule-dialog", mapped = true, floating = false }
windows[5] = fifth
api.apply("floating")
callbacks["window.close"](fifth)
callbacks["window.update_state"](fifth, { float = false })
fifth.floating = true
callbacks["window.open"](fifth)
api.apply("tile")
assert(fifth.floating)
-- A static float rule can still be waiting for its property refresh at open.
api.apply("floating")
local sixth = { address = "0x6", pid = 60, initial_class = "pending-dialog", mapped = true, floating = false, pending_float = true }
windows[6] = sixth
callbacks["window.open"](sixth)
assert(sixth.floating)
api.apply("tile")
assert(sixth.floating, "pending application rules must retain their natural floating origin")
-- Decorations may reset layout state after the natural floating origin is seen.
api.apply("floating")
local seventh = { address = "0x7", pid = 70, initial_class = "decorated-dialog", mapped = true, floating = true, pending_tile = true }
windows[7] = seventh
callbacks["window.open"](seventh)
assert(seventh.floating)
api.apply("tile")
assert(seventh.floating, "decoration refresh must not replace a native floating origin")
hl = actual_hl
print("ARGVUS window mode lifecycle: all assertions passed")
