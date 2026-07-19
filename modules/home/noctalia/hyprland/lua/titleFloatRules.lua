hl.on("window.title", function(window)
  if window.title == "Extension: (Bitwarden Password Manager) - Bitwarden — Mozilla Firefox" then
      -- hl.dispatch(hl.dsp.window.float({ action = "set" }))
    hl.dispatch(hl.dsp.window.float(window))
  end
end)