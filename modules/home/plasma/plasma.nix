{ lib, pkgs, config, inputs, ... }:

let
  cfg = config.may.features.desktop;
in {
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (catppuccin-kde.override {
        flavour = ["latte"];
        accents = ["lavender"];
        winDecStyles = ["classic"];
      })
      (reversal-icon-theme.override {
        colorVariants = ["purple"];
      })
      whitesur-kde
    ];

    programs.plasma = {
      inherit (cfg) enable;
      
      workspace = {
        colorScheme = "Catppuccin-Latte-Lavender";
        theme = "Catppuccin-Latte-Lavender";
        iconTheme = "Reversal-purple";
        windowDecorations = {
          theme = "Catppuccin-Latte-Classic";
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
          "Walk Through Windows of Current Application" = "";
          "Walk Through Windows of Current Application (Reverse)" = "";
        };
      };

      kscreenlocker = {
        timeout = 15;
        lockOnResume = true;
        passwordRequired = true;
        passwordRequiredDelay = 30;
      };

      kwin = {
        edgeBarrier = 0;
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