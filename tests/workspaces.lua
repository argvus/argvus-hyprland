local policy = dofile(os.getenv("ARGVUS_WORKSPACE_MODULE"))
local monitor = { name = "A" }
local other = { name = "B" }
local entries = {
  { id = 3, name = "3", addressable_name = "3", monitor = monitor },
  { id = 2, name = "2", addressable_name = "2", monitor = other },
  { name = "project", addressable_name = "name:project", monitor = monitor },
  { id = 1, name = "1", addressable_name = "1", monitor = monitor },
  { name = "special:test", special = true, monitor = monitor },
}
local selected
local current = entries[1]
local special
hl = {
  get_active_monitor = function()
    return monitor
  end,
  get_monitor_at_cursor = function()
    return other
  end,
  get_active_special_workspace = function()
    return special
  end,
  get_active_workspace = function()
    return current
  end,
  get_workspaces = function()
    return entries
  end,
  dsp = {
    focus = function(value)
      return value
    end,
  },
  dispatch = function(value)
    selected = value.workspace
  end,
}
policy.cycle(1, "focused")
assert(selected == "name:project")
current = entries[3]
policy.cycle(1, "focused")
assert(selected == "1")
policy.cycle(-1, "focused")
assert(selected == "3")
selected = nil
policy.cycle(1, "cursor")
assert(selected == nil)
special = {}
policy.cycle(1, "focused")
assert(selected == nil)
special = nil
current = { name = "missing" }
policy.cycle(1, "focused")
assert(selected == nil)
current = entries[1]
-- Hotplug and reassignment are reflected by the next snapshot.
entries[1].monitor = other
policy.cycle(1, "focused")
assert(selected == nil)
entries[1].monitor = monitor
current = entries[4]
policy.cycle(-1, "focused")
assert(selected == "name:project")
selected = nil
hl.get_monitor_at_cursor = function()
  return nil
end
policy.cycle(1, "cursor")
assert(selected == nil)
entries = {}
policy.cycle(1, "focused")
assert(selected == nil)
print("workspace assertions passed")
