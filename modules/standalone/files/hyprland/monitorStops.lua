-- doesn't currently work

local function trace (text)
	hl.notification.create({ text = text, duration = 10000 })
end

local function array_includes(tab, val)
  for index, value in ipairs(tab) do
    if value == val then
      return true
    end
  end

  return false
end


local function stop_at_workspaces(workspace_ids, adjust)
  return function()
    local ws = hl.get_active_workspace()

    if array_includes(workspace_ids, ws.id) then return end

    hl.dispatch(hl.dsp.focus({ workspace = adjust }))
  end
end

hl.unbind("SUPER + k")
hl.unbind("SUPER + i")

hl.bind("SUPER + k", stop_at_workspaces({ 5, 8 }, "+1"))
hl.bind("SUPER + i", stop_at_workspaces({ 1, 6, 9 }, "-1"))