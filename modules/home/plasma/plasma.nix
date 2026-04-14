{ lib, pkgs, config, inputs, ... }:

let
  cfg = config.may.features.desktop;
in {
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      ((catppuccin-kde
        .overrideAttrs (finalAttrs: prevAttrs: {
          patches = prevAttrs.patches ++ [
            ./patches/catppuccin.patch
          ];
        }))
        .override {
          flavour = ["latte"];
          accents = ["lavender"];
          winDecStyles = ["classic"];
        }
      )
      (reversal-icon-theme.override {
        colorVariants = ["purple"];
      })
      # may.kde-edna-light
    ];

    programs.plasma = {
      inherit (cfg) enable;
      
      workspace = {
        colorScheme = "Catppuccin-Latte-Lavender";
        theme = "Catppuccin-Latte-Lavender";
        iconTheme = "Reversal-purple";
        windowDecorations = {
          theme = "__aurorae__svg__CatppuccinLatte-Classic";
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
         "services/org.kde.plasma-systemmonitor.desktop"._launch = "Ctrl+Shift+Esc";
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

      spectacle = {
        shortcuts.captureRectangularRegion = "Alt+Ctrl+$";
      };

      configFile = {
        spectaclerc.General.clipboardGroup = "PostScreenshotCopyImage";
        spectaclerc.General.useReleaseToCapture = true;  
      };
    };
  };
}