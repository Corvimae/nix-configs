{ inputs, lib, config, ... }: let
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    overlays = [
      inputs.firefox-addons.overlays.default
      inputs.self.overlays.mayUtils
      inputs.self.overlays.pipewireUtils
    ];
    config.allowUnfree = true;
  };
in {
  # this config is really jank, it does not install everything you might expect from enabled
  # features as it's just doing home-manager stuff on a cachyos instance.
  flake.homeConfigurations."duosion.may" = inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs;

    modules = [
      inputs.plasma-manager.homeModules.plasma-manager
      {
        may = pkgs.mayUtils.loadConfig "duosion" ../../config.toml;
      }
      inputs.self.homeModules.programs
      inputs.self.homeModules.services
      # inputs.self.homeModules.xdg
      inputs.self.homeModules.plasma
      ./pipewire.nix
      {
        home.username = "may";
        home.homeDirectory = "/home/may";
        home.stateVersion = "25.11";
        home.preferXdgDirectories = true;
        
        targets.genericLinux.enable = true;
        programs.home-manager.enable = true;

        # Has trouble acquiring an OpenGL context when installed via nixpkgs
        programs.ghostty.package = null;
        programs.ghostty.systemd.enable = lib.mkForce false;

        programs.zsh.shellAliases = {
          renix = "home-manager switch --flake ~/.config/nix-configs#duosion.may --extra-experimental-features 'nix-command flakes pipe-operators' -b backup";
          nix-upgrade = "cd ~/.config/nix-configs && nix flake update --extra-experimental-features \"nix-command flakes\" && renix";
          nix-deploy = "nix run github:serokell/deploy-rs ~/.config/nix-configs";

          # Flip QK75N into treating FN keys normal-style
          fix-keyboard="echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode";
        };
      }
    ];
  };
}