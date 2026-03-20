{ inputs, lib, config, pkgs, ... }:

let
  username = "may";
  homeDirectory = "/home/${username}";
  configDirectory = config.xdg.configHome;
  zshCustomDirectory = "${homeDirectory}/.oh-my-zsh/custom";
in {
  imports = [
    ./${username}/programs/firefox
    ./${username}/programs/git
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
      "${zshCustomDirectory}/themes/bullet-train.zsh-theme" = {
        source = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/caiogondim/bullet-train.zsh/refs/heads/master/bullet-train.zsh-theme";
          hash = "sha256-R77AY/CPUI+19UbyV7o8Us5J+uQFfebzJWy5JnXzhNQ=";
        };
      };
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

  programs.ssh.startAgent = true;

  programs.home-manager.enable = true;
  programs.git.enable = true;

  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    shellAliases = {
      renix = "sudo nixos-rebuild switch";
      nix-repl = "nix repl --extra-experimental-features 'flakes' nixpkgs";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "bullet-train";
      custom = zshCustomDirectory;
      extraConfig = ''
        BULLETTRAIN_PROMPT_ORDER=(
          time
          context
          dir
          git
        )

        BULLETTRAIN_CONTEXT_DEFAULT_USER=${username}
      '';
    };
  };

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



  systemd.user.startServices = "sd-switch";
}