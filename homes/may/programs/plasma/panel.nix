{ config, lib, pkgs, ... }:

let
  widgets = {
    battery = {
      battery = {
        showPercentage = true;
      };
    };

    apps = {
      iconTasks = {
        launchers = [
          "applications:firefox.desktop"
          "applications:org.kde.dolphin.desktop"
          "applications:vesktop.desktop"
          "applications:slack.desktop"
          "applications:code.desktop"
          "applications:com.mitchellh.ghostty.desktop"
        ];
        appearance = {
          showTooltips = true;
          highlightWindows = true;
          indicateAudioStreams = true;
          fill = true;
          iconSpacing = "medium";
        };
        behavior.grouping.clickAction = "showPresentWindowsEffect";
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
        icon = "nix-snowflake";
      };
    };

    systemTray = {
      systemTray.items = {
        hidden = [
          "org.kde.plasma.cameraindicator"
          "org.kde.plasma.bluetooth"
          "org.kde.plasma.networkmanagement"
          "org.kde.plasma.volume"
          "org.kde.plasma.battery"
          "org.kde.plasma.userswitcher"
          "org.kde.plasma.weather"
          "org.kde.plasma.notifications"
          "org.kde.plasma.brightness"
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
  #TODO remove this after the bug fixed
  # https://github.com/nix-community/plasma-manager/issues/577
  programs.plasma.startup.desktopScript."panels".preCommands = lib.mkForce ''
    sleep 3
    [ -f ${config.xdg.configHome}/plasma-org.kde.plasma.desktop-appletsrc ] && rm ${config.xdg.configHome}/plasma-org.kde.plasma.desktop-appletsrc        
  '';

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
      widgets = with widgets; [
        (fixedSpacer 10)
        globalMenu
        spacer
        systemTray
        clipboard
        wifi
        battery
        (fixedSpacer 10)
        clock
        (fixedSpacer 10)
      ];
    }
  ];
}