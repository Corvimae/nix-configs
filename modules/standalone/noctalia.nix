{ inputs, config, lib, pkgs, ... }:

let
  enable = pkgs.mayUtils.isDesktopShell "noctalia" config;
in {
  config = lib.mkIf enable {
    programs.noctalia.settings = {
      dock.monitors = [ "DP-2" ];
      widget.battery.enabled = false;
    };

    wayland.windowManager.hyprland = {
      extraLuaFiles = {
        "monitorStops.lua" = {
          content = ./files/hyprland/monitorStops.lua;
          autoLoad = false;
        };
      };
      # Load this at the end of the config so that we can overwrite existing binds
      extraConfig = ''
        require("monitorStops")
      '';
    };
  };
}