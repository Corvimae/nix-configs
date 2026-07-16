{ inputs, pkgs, lib, config, ... }:

let
  enable = pkgs.mayUtils.isDesktopShell "noctalia" config;
in {
  config = lib.mkIf enable {
    wayland.windowManager.hyprland = {
      settings = {
        on = {
          _args = [
            "hyprland.start"
            (lib.generators.mkLuaInline "function()\n  hl.exec_cmd(\"noctalia\")\nend")
          ];
        };
      };

      extraLuaFiles = {
        "layoutSwitching.lua" = {
          content = ./lua/layoutSwitching.lua;
          autoLoad = true;
        };
      };
    };
  };
}