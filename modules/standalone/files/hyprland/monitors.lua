hl.monitor({
  output = "desc:HP Inc. HP X27q 6CM1370213",
  mode = "2560x1440@164.834",
  position = "0x0",
  scale = 1,
  cm = "srgb",
  sdr_min_luminance = 0.2,
  sdr_max_luminance = 80,
})

hl.monitor({
  output = "desc:GIGA-BYTE TECHNOLOGY CO. LTD. MO27U2 0x01010101",
  mode = "highrr",
  position = "-2560x0",
  scale = 1.5,
  cm = "hdredid",
  vrr = 2,
  sdr_eotf = "gamma22",
  bitdepth = 10,
  sdrbrightness = 1.2,
  sdrsaturation = 0.98,
  sdr_min_luminance = 0.05,
  sdr_max_luminance = 200,
})

hl.monitor({
  output = "desc:HP Inc. HP V21 1CR0341T5C",
  mode = "1920x1080@60",
  position = "591x-1080",
  scale = 1,
  cm = "srgb",
  sdr_min_luminance = 0.2,
  sdr_max_luminance = 80,
})

hl.workspace_rule({ workspace = "Fullscreen", monitor = "DP-2", })
hl.workspace_rule({ workspace = "1", monitor = "DP-2", default = true, persistent = true, })
hl.workspace_rule({ workspace = "2", monitor = "DP-2", })
hl.workspace_rule({ workspace = "3", monitor = "DP-2", })
hl.workspace_rule({ workspace = "4", monitor = "DP-2", })
hl.workspace_rule({ workspace = "5", monitor = "DP-1", default = true, persistent = true, })
hl.workspace_rule({ workspace = "6", monitor = "DP-1", })
hl.workspace_rule({ workspace = "7", monitor = "DP-1", })
hl.workspace_rule({ workspace = "8", monitor = "HDMI", default = true, persistent = true, })
hl.workspace_rule({ workspace = "9", monitor = "HDMI", })
hl.workspace_rule({ workspace = "10", monitor = "HDMI", });
