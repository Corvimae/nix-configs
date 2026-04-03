{ inputs, config, ... }: let
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    overlays = [
      inputs.firefox-addons.overlays.default
      inputs.self.overlays.mayUtils
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
      {
        home.username = "may";
        home.homeDirectory = "/home/may";
        home.stateVersion = "25.11";
        home.preferXdgDirectories = true;
        
        targets.genericLinux.enable = true;
        programs.home-manager.enable = true;

        programs.zsh.shellAliases = {
          renix = "home-manager switch --flake ~/.config/nix-configs#duosion.may --extra-experimental-features 'nix-command flakes pipe-operators'";
        };

        home.file = {
          # don't like that config.xdg.configHome isn't available here.
          # todo: make a util for this.
          "/home/may/.config/pipewire/pipewire.conf.d/05-virtual-cables.conf" = {
            source = ./files/pipewire/pipewire.conf.d/05-virtual-cables.conf;
          };
          "/home/may/.config/pipewire/pipewire.conf.d/12-choppy-under-load.conf" = {
            source = ./files/pipewire/pipewire.conf.d/12-choppy-under-load.conf;
          };
          "/home/may/.config/pipewire/pipewire.conf.d/13-discord-override.conf" = {
            source = ./files/pipewire/pipewire.conf.d/13-discord-override.conf;
          };
          "/home/may/.config/pipewire/pipewire.conf.d/14-quantum-overrides.conf" = {
            source = ./files/pipewire/pipewire.conf.d/14-quantum-overrides.conf;
          };
          "/home/may/.config/pipewire/pipewire.conf.d/15-application-specific-routing.conf" = {
            source = ./files/pipewire/pipewire.conf.d/15-application-specific-routing.conf;
          };
          "/home/may/.config/pipewire/pipewire.conf.d/16-chatot-links.conf" = {
            source = ./files/pipewire/pipewire.conf.d/16-chatot-links.conf;
          };
          "/home/may/.config/pipewire/scripts/create-links.sh" = {
            source = ./files/pipewire/scripts/create-links.sh;
            executable = true;
          };
        };
      }
    ];
  };
}