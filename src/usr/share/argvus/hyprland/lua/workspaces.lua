-- Shared monitor-local navigation for bindings and external IPC callers.
local M = {}

function M.cycle(offset, source)
  local monitor
  if source == "cursor" then
    monitor = hl.get_monitor_at_cursor()
  else
    monitor = hl.get_active_monitor()
  end
  if not monitor or hl.get_active_special_workspace(monitor) then
    return
  end
  local active = hl.get_active_workspace(monitor)
  if not active then
    return
  end
  local workspaces = {}
  for _, workspace in ipairs(hl.get_workspaces()) do
    if not workspace.special and workspace.monitor and workspace.monitor.name == monitor.name then
      table.insert(workspaces, workspace)
    end
  end
  table.sort(workspaces, function(a, b)
    if a.id and b.id then
      return a.id < b.id
    end
    if (a.id ~= nil) ~= (b.id ~= nil) then
      return a.id ~= nil
    end
    return a.name < b.name
  end)
  if #workspaces < 2 then
    return
  end
  for index, workspace in ipairs(workspaces) do
    if workspace.name == active.name then
      local target = workspaces[((index - 1 + offset) % #workspaces) + 1]
      hl.dispatch(hl.dsp.focus({ workspace = target.addressable_name }))
      return
    end
  end
end

return M
