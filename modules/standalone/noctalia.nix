{ inputs, config, lib, pkgs, ... }:

let
  enable = pkgs.mayUtils.isDesktopShell "noctalia" config;
in {
  config = lib.mkIf enable {
    home.packages = [
      inputs.scopebuddy.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    programs.noctalia.settings = {
      dock.monitors = [ "DP-2" ];
      widget.battery.enabled = false;
    };

    wayland.windowManager.hyprland = {
      settings = {
        config.xwayland.force_zero_scaling = true;

        env = with pkgs.hyprUtils; [
          (mkEnv { key = "GDK_SCALE"; value = "2"; })
        ];
      };

      extraLuaFiles = {
        "monitorStops.lua" = {
          content = ./files/hyprland/monitorStops.lua;
          autoLoad = false;
        };
        "monitors.lua" = {
          content = ./files/hyprland/monitors.lua;
          autoLoad = false;
        };
      };
      # Load this at the end of the config so that we can overwrite existing binds
      extraConfig = ''
        require("monitorStops")
      '';
    };


    home.file."${config.home.homeDirectory}/.config/scopebuddy/scb.conf" = {
      source = ./files/hyprland/scb.conf;
    };
  };
}