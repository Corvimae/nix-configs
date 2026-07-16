{ inputs, pkgs, lib, config, ... }:

let
  enable = pkgs.mayUtils.isDesktopShell "noctalia" config;
in {
  config = lib.mkIf enable {
    wayland.windowManager.hyprland.settings = {
      window_rule = [
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