{ lib, pkgs, config, inputs, ... }:

let
  cfg = config.may.profiles.gui;
in {
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (catppuccin-kde.override {
        flavour = ["latte"];
        accents = ["lavender"];
        winDecStyles = ["classic"];
      })
    ];

    programs.plasma = {
      inherit (cfg) enable;

      workspace = {
        lookAndFeel = "Catppuccin-Latte-Lavender";
        # windowDecorations = {
        #   theme = "Catppuccin-Latte-Lavender";
        #   library = "org.kde.kwin.aurorae.v2";
        # };
        # splashScreen.theme = "org.kde.breeze.desktop";
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
  };
}