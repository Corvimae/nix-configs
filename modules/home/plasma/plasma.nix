{ lib, pkgs, config, inputs, ... }:

let
  enable = config.may.features.desktop.enable && config.may.desktopShell == "plasma";
  wallpaper = ../../../assets/wallpapers/${config.may.desktop.wallpaper or "generic"}-wallpaper.png;
in {
  config = lib.mkIf enable {
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
      # temporary until this gets fixed
      may.reversal-white-sur-patch
    ];

    programs.plasma = {
      inherit enable;
      
      workspace = {
        inherit wallpaper;
        colorScheme = "Catppuccin-Latte-Lavender";
        theme = "Catppuccin-Latte-Lavender";
        iconTheme = "Reversal-purple";
        windowDecorations = {
          theme = "__aurorae__svg__CatppuccinLatte-Classic";
          library = "org.kde.kwin.aurorae.v2";
        };
        splashScreen.theme = "org.kde.breeze.desktop";
        soundTheme = null;
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
        appearance.wallpaper = wallpaper;
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