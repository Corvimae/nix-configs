{ inputs, config, lib, pkgs, ... }: 

let 
  enable = config.may.features.desktop.enable && config.may.desktopShell == "noctalia";
  wallpaper = ../../../assets/wallpapers/${config.may.desktop.wallpaper or "generic"}-wallpaper.png;
  wallpaperLocation = "${config.home.homeDirectory}/Pictures/wallpaper.png";
in {
  imports = [
    inputs.noctalia.homeModules.default
  ];
  
  config = lib.mkIf enable {
    home.file.${wallpaperLocation} = {
      source = wallpaper;
    };

    home.packages = with pkgs; [
      grim
      satty
      slurp
      wl-clipboard
      may.future-cyan-hyprcursor
    ];

    programs.noctalia = {
      enable = true;

      systemd.enable = true;

      settings = { # This may also be a string or path to a .toml file.
        theme = {
          mode = "light";
          source = "community";
          community_palette = "Lilac AMOLED";
          wallpaper_scheme = "muted";
          # builtin = "Catppuccin";
        };

        wallpaper = {
          enabled = true;
          default.path = wallpaperLocation;
        };

        dock = {
          enabled = true;
          icon_size = 32;
          launcher_position = "start";
          show_dots = true;
          show_instance_count = false;
          main_axis_padding = 10;
          cross_axis_padding = 4;
          item_spacing = 4;
          magnification = false;
          pinned = [
            "thunderbird"
            "firefox"
            "dolphin"
            "vesktop"
            "slack"
            "codium"
            "steam"
            "ghostty"
          ];
        };

        control_center = {
          width = 900;
        };

        shell = {
          font_family = "Overpass";
          
          launcher = {
            categories = false;
            providers.session = {
              global = true;
            };
          };
        };

        bar.default = {
          end = [
            "tray"
            "notifications"
            "clipboard"
            "bluetooth"
            "volume"
            "network"
            "brightness"
            "battery"
            "control-center"
            "session"
          ];

          start = [
            "launcher"
            "workspace"
          ];

          thickness = 30;
          widget_spacing = 8;
        };

        widget = {
          brightness.enabled = false;
          clipboard.enabled = false;
          control-center.enabled = false;
          volume.show_label = false;
          network.show_label = false;
          clock.format = "%l:%M %P";
        };
      };
    };

    home.activation = {
      syncGreeter = lib.hm.dag.entryAfter ["writeBoundary"] ''
        export PATH="${
          lib.makeBinPath ([  inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default ])
        }:$PATH"
        noctalia msg greeter-sync
      '';
    };
  };
}