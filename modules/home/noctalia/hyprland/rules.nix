{ inputs, pkgs, lib, config, ... }:

let
  enable = pkgs.mayUtils.isDesktopShell "noctalia" config;
  mkFullscreenRule = rules: {
    fullscreen = true;
    workspace = "name:Fullscreen";
    confine_pointer = true;
    immediate = true;
  } // rules;
in {
  config = lib.mkIf enable {
    wayland.windowManager.hyprland.settings = {
      window_rule = with pkgs.hyprUtils; [
        # {
        #   match.fullscreen = false;
        #   float = true;
        # }
        {
          match.class = "dev.noctalia.Noctalia";
          float = true;
          size = [1080 920];
        }
        {
          match.class = "com.gabm.satty";
          float = true;
          size = [1080 800];
        }
        (mkCenterFloatRule {
          match.class = "io.missioncenter.MissionCenter";
          pctSize = {
            x = 0.5;
            y = 0.7;
          };
        })
        (mkCenterFloatRule {
          match.class = "XIVLauncher.Core";
          pctSize = {
            x = 0.5;
            y = 0.6;
          };
        })
        (mkCenterFloatRule {
          match.class = "FF Logs Uploader";
          pctSize = {
            x = 0.5;
            y = 0.6;
          };
        })
        (mkCenterFloatRule {
          match.title = "Steam Settings";
          pctSize = {
            x = 0.5;
            y = 0.6;
          };
        })
        (mkCenterFloatRule {
          match = {
            class = "org.mozilla.Thunderbird";
            initial_title = "Calendar Reminders";
          };
          pctSize = {
            x = 0.3;
            y = 0.4;
          };
        })
        {
          match.class = "cc3dsfs_bot.*";
          # workspace = 6;
          tile = true;
        }
        {
          match.class = "cc3dsfs_top.*";
          # workspace = 6;
          tile = true;
        }
        (mkFullscreenRule {
          match.class = "gamescope";
        })
        (mkFullscreenRule {
          match.fullscreen = true;
        })
        (mkFullscreenRule {
          match.title = "FINAL FANTASY XIV";
        })
        (mkCenterFloatRule {
          match = {
            initial_class = "X-AIR-Edit";
            initial_title = "negative:X AIR Edit.*";
          };
          pctSize = {
            x = 0.3;
            y = 0.4;
          };
        })
        # (mkCenterFloatRule {
        #   match.class = ""
        # })
        # {
        #   match.float = false;
        #   "hyprbars:enabled" = false;
        # }
      ];

      layer_rule = [
        {
          name = "noctalia";
          match.namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd)$";
          no_anim = true;
          ignore_alpha = 0.5;
          blur = true;
          blur_popups = true;
        }
      ];
    };
  };
}