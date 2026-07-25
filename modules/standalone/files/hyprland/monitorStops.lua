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

local function array_match(tab, predicate)
  for index, value in ipairs(tab) do
    if predicate(value) then
      return value
    end
  end

  return nil
end

local function stop_at_workspaces(workspace_ids, neighbors, adjust)
  return function()
    local ws = hl.get_active_workspace()

    local neighbor_set = array_match(neighbors, function(val) return array_includes(val, ws.name) end)

    if neighbor_set ~= nil then
      if adjust == "+1" and neighbor_set[1] == ws.name then
        hl.dispatch(hl.dsp.focus({ workspace = neighbor_set[2] }))

        return
      elseif adjust == "-1" and neighbor_set[2] == ws.name then
        hl.dispatch(hl.dsp.focus({ workspace = neighbor_set[1] }))

        return
      end
    end

    if array_includes(workspace_ids, ws.id) or string.find(ws.config_name, "name:") then return end

    hl.dispatch(hl.dsp.focus({ workspace = adjust }))
  end
end

hl.unbind("SUPER + k")
hl.unbind("SUPER + i")

-- Order: Upper, lower
-- Not sure why I made this generic when it really only works for a first and last stop, but whatever.
local neighbors = {
  { "Fullscreen", "1" }
}

hl.bind("SUPER + k", stop_at_workspaces({ 4, 8 }, neighbors, "+1"))
hl.bind("SUPER + i", stop_at_workspaces({ 1, 5, 9 }, neighbors, "-1"))