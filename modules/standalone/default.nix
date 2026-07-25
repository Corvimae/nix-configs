{ inputs, lib, config, ... }: let
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    overlays = [
      inputs.nix-firefox-addons.overlays.default
      inputs.nix-vscode-extensions.overlays.default
      inputs.self.overlays.mayUtils
      inputs.self.overlays.pipewireUtils
      inputs.self.overlays.hyprUtils
      (final: prev: { may = inputs.self.packages.${prev.system}; })
    ];
    config.allowUnfree = true;
  };
in {
  # this config is really jank, it does not install everything you might expect from enabled
  # features as it's just doing home-manager stuff on a cachyos instance.
  flake.homeConfigurations."duosion.may" = inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs;

    extraSpecialArgs = { inherit inputs; };
    modules = [
      {
        may = pkgs.mayUtils.loadConfig "duosion" ../../config.toml;
      }
      inputs.self.homeModules.programs
      inputs.self.homeModules.services
      inputs.noctalia.homeModules.default
      inputs.self.homeModules.noctalia
      # inputs.self.homeModules.xdg
      ./pipewire.nix
      ./noctalia.nix
      {
        nix = {
          package = pkgs.nix;
          settings = {
            experimental-features = [
              "nix-command"
              "flakes"
              "pipe-operators"
            ];

            trusted-users = [
              "root"
              "may"
              "@wheel"
            ];
          };
        };

        home.username = "may";
        home.homeDirectory = "/home/may";
        home.stateVersion = "25.11";
        home.preferXdgDirectories = true;
        
        targets.genericLinux.enable = true;
        programs.home-manager.enable = true;

        # Has trouble acquiring an OpenGL context when installed via nixpkgs
        programs.ghostty.package = lib.mkForce null;
        programs.ghostty.systemd.enable = lib.mkForce false;

        programs.zsh.shellAliases = {
          renix = "home-manager switch --flake ~/.config/nix-configs#duosion.may -b backup";
          nix-upgrade = "cd ~/.config/nix-configs && nix flake update && renix";
          nix-deploy = "nix run github:serokell/deploy-rs ~/.config/nix-configs";

          # Flip QK75N into treating FN keys normal-style
          fix-keyboard="echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode";
        };
      }
    ];
  };
}