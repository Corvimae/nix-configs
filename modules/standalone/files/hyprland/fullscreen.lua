local function trace (text)
	hl.notification.create({ text = text, duration = 10000 })
end

hl.on("workspace.active", function(workspace)
  local windows = workspace:get_windows()

  if #windows ~= 1 then
    return
  end
  
  for _, window in ipairs(windows) do
    if window.class == "gamescope" then
      hl.dsp.focus({ window = "gamescope" })
    end
  end
end)