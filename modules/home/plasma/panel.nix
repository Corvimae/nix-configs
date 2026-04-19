{ pkgs, config, inputs, lib, ... }:

let
  cfg = config.may.features.desktop;
  widgets = {
    battery = {
      battery = {
        showPercentage = true;
      };
    };

    apps = {
      iconTasks = {
        launchers = [
          (
            # NixOS installs a differently named package from Arch
            if config.may.class == "standalone" then 
              "applications:org.mozilla.Thunderbird.desktop" 
            else
              "applications:thunderbird.desktop"
          )
          "applications:firefox.desktop"
          "applications:org.kde.dolphin.desktop"
          "applications:vesktop.desktop"
          "applications:slack.desktop"
          "applications:codium.desktop"
          "applications:steam.desktop"
          "applications:com.mitchellh.ghostty.desktop"
        ];
        appearance = {
          showTooltips = true;
          highlightWindows = true;
          indicateAudioStreams = true;
          fill = true;
          iconSpacing = "medium";
        };
        behavior.grouping.clickAction = "cycle"; # equivalent to groupedTaskAction
      };
    };

    wifi = "org.kde.plasma.networkmanagement";
    clipboard = "org.kde.plasma.clipboard";
    separator = "org.kde.plasma.marginsseparator";

    clock = {
      digitalClock = {
        date = {
          enable = true;
          format = {
            custom = "ddd MMM d";
          };
          position = "besideTime";
        };
        time.format = "12h";
        calendar.firstDayOfWeek = "sunday";
      };
    };

    kickoff = {
      kickoff = {
        sortAlphabetically = true;
        icon = config.may.plasma.launcherIcon;
      };
    };

    systemTray = {
      systemTray.items = {
        hidden = pkgs.mayUtils.mkConditionalList [
          { value = "org.kde.plasma.cameraindicator"; }
          { value = "org.kde.plasma.bluetooth"; }
          { value = "org.kde.plasma.networkmanagement"; }
          { value = "org.kde.plasma.volume"; }
          # { 
          #   value = "org.kde.plasma.battery";
          #   enabled = config.may.features.laptop.enable;
          # }
          {value = "org.kde.plasma.userswitcher"; }
          {value = "org.kde.plasma.weather"; }
          {value = "org.kde.plasma.notifications"; }
          {value = "org.kde.plasma.brightness"; }
        ];
      };
    };

    globalMenu = "org.kde.plasma.appmenu";

    spacer = "org.kde.plasma.panelspacer";

    fixedSpacer = length: {
      name = "org.kde.plasma.panelspacer";
      config = {
        General = {
          expanding = false;
          length = length;
        };
      };
    };
  };
in {
  config = lib.mkIf cfg.enable {
    # TODO remove this after the bug gets fixed
    # https://github.com/nix-community/plasma-manager/issues/577
    # programs.plasma.startup.desktopScript."panels".preCommands = lib.mkForce ''
    #   sleep 3
    #   [ -f ${config.xdg.configHome}/plasma-org.kde.plasma.desktop-appletsrc ] && rm ${config.xdg.configHome}/plasma-org.kde.plasma.desktop-appletsrc        
    # '';

    programs.plasma.panels = with widgets; [
      {
        location = "bottom";
        height = 44;
        floating = true;
        lengthMode = "fit";
        widgets = with widgets; [
          # {
          #   plasmaPanelColorizer = {
          #     general.enable = true;
          #     panelBackground.customBackground = {
          #       enable = true;
          #       colorSource = "custom";
          #       customColor = "#000000";
          #       opacity = 0;
          #     };
          #   };
          # }
          kickoff
          apps
        ];
      }
      {
        location = "top";
        height = 24;
        widgets = pkgs.mayUtils.mkConditionalList [
          { value = (widgets.fixedSpacer 10); }
          { value = widgets.kickoff; }
          { value = widgets.globalMenu; }
          { value = widgets.spacer; }
          { value = widgets.systemTray; }
          # { value = widgets.clipboard; }
          { value = widgets.wifi; }
          {
            value = widgets.battery;
            enabled = config.may.features.laptop.enable;
          }
          { value = (widgets.fixedSpacer 10); }
          { value = widgets.clock; }
          { value = (widgets.fixedSpacer 10); }
        ];
      }
    ];
  };
}