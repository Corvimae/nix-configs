{ inputs, lib, config, pkgs, ... }:

let
  username = "may";
  homeDirectory = "/home/${username}";
  configDirectory = config.xdg.configHome;
in {
  imports = let
    enabledPrograms = [
      "firefox"
      "git"
      "zsh"
    ];
  in (map(name: ./${username}/programs/${name}) enabledPrograms) ++ [
    # add more stuff here later
  ];

  home = {
    inherit username homeDirectory;
    stateVersion = "25.11";

    preferXdgDirectories = true;

    packages = with pkgs; [
      oh-my-zsh
      vesktop
      ghostty
      slack
    ];

    file = let
      presetConfigs = ./may/homeFiles/.config;
      # this is the cleanest way i could find to do this
      # because i do not know what i'm doing
      configFiles = lib.pipe presetConfigs [
        # Get all directories in presetConfigs
        (builtins.readDir)
        (lib.attrsets.filterAttrs(k: v: v == "directory"))
        # # Convert to attribute sets
        (lib.attrsets.attrNames)
        (builtins.map(name: {
          name = builtins.toPath "${configDirectory}/${name}";
          value = {
            source = builtins.toPath "${presetConfigs}/${name}";
            recursive = true;
          };
        }))
        (builtins.listToAttrs)
      ];
    in {
      # add more files here
    } // configFiles;
  };

  xdg = {
    enable = true;
    configHome = lib.mkForce "${homeDirectory}/.config";
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [
        pkgs.kdePackages.xdg-desktop-portal-kde
      ];
      config = {
        common = {
          default = [ "kde" ];
        };
      };
    };
  };

  programs.home-manager.enable = true;

  programs.plasma = {
    enable = true;
    # shortcuts = {
    #   kwin = {};
    # };
    spectacle.shortcuts.captureRectangularRegion = "Alt+Ctrl+$";
  };

  programs.ghostty = {
    enable = true;
    systemd.enable = true;
  };

  services.ssh-agent.enable = true;
  systemd.user.startServices = "sd-switch";
}