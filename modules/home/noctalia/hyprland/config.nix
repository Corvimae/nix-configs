{ inputs, pkgs, lib, config, ... }:

let
  enable = pkgs.mayUtils.isDesktopShell "noctalia" config;
in {
  config = lib.mkIf enable {
    programs.kitty.enable = true;

    home.sessionVariables.NIXOS_OZONE_WL = "1";

    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
      configType = "lua";

      plugins = with inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}; [
        # hyprbars 
      ];

      settings = {
        config = {
          general = {
            layout = "scrolling";
            gaps_in = 3;
            gaps_out = 6;
            resize_on_border = true;
            hover_icon_on_border = true;
          };

          decoration = {
            rounding = 20;
            rounding_power = 2;
            shadow = {
              enabled = true;
              range = 4;
              render_power = 3;
              color = "0xee1a1a1a";
            };
            blur = {
              enabled = true;
              size = 3;
              passes = 2;
              vibrancy = 0.1696;
            };
          };

          input = {
            accel_profile = "flat";
            follow_mouse = 0;
          };
          
          misc = {
            disable_hyprland_logo = true;
            vrr = 1;
          };
          # plugin = {
          #   hyprbars = {
          #     bar_height = 20;
          #     bar_padding = 10;
          #     bar_part_of_window = true;
          #     on_double_click = "hyprctl dispatch fullscreen 1";
          #   };
          # };
        };

        env = with pkgs.hyprUtils; [
          (mkEnv {
            key = "HYPRCURSOR_THEME";
            value = "Future-Cyan-Hyprcursor_Theme";
          })
          (mkEnv {
            key = "HYPRCURSOR_SIZE";
            value = "32";
          })
          (mkEnv {
            key = "XCURSOR_SIZE";
            value = "32";
          })
        ];

        animation = [
          {
            _args = [{
              leaf = "workspaces";
              enabled = 1;
              speed = 5;
              bezier = "default";
              style = "slidevert";
            }];
          }
        ];
      };
    };
  };
}