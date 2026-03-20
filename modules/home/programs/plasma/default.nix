{ lib, config, inputs, ... }:

let
  cfg = config.may.programs.plasma;
in {
  options.may.programs.plasma = lib.mkProgramOption "KDE Plasma";

  config = lib.mkIf cfg.enable {
    imports = [
      ./panel.nix
    ];

    programs.plasma = {
      enable = true;
      workspace = {
        windowDecorations = {
          theme = "Catppuccin-Latte-Lavender";
          library = "org.kde.kwin.aurorae.v2";
        };
        splashScreen.theme = "org.kde.breeze.desktop";
        # wallpaper = "";
      };
      shortcuts = {
        kwin = {
          "Window Quick Tile Bottom" = "";
          "Window Quick Tile Left" = "";
          "Window Quick Tile Top" = "";
          "Window Quick Tile Right" = "";
        };
      };
      kwin = {
        titlebarButtons = {
          left = [
          ];
          right = [
            "minimize"
            "maximize"
            "close"
          ];
        };
      };
      spectacle.shortcuts.captureRectangularRegion = "Alt+Ctrl+$";
    };
  }
}