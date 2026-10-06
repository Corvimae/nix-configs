{ config, inputs, lib, pkgs, ... }:

let
  enable = config.may.features.desktop.enable && config.may.desktopShell == "noctalia";
in {
  imports = [
    inputs.monique.nixosModules.default
  ];

  config = lib.mkIf enable {
    environment.systemPackages = [
      pkgs.kitty
      pkgs.kdePackages.dolphin
    ];

    programs.hyprland = {
      enable = true;
    };

    programs.noctalia = {
      enable = true;

      # Enables NetworkManager, Bluetooth, UPower, and a power profile service.
      recommendedServices.enable = true;
    };

    services.displayManager.noctalia-greeter = {
      enable = true;

      settings = {
        session.default = "Hyprland";
        keyboard.layout = "us";
        user.default = "may";
      };
    };

    programs.monique.enable = true;

    # NixOS otherwise injects a stripped PATH via Environment= on the niri.service
    # unit which shadows the imported user-manager PATH. Disabling the default
    # lets niri inherit the full PATH set up by niri-session.
    systemd.user.services.niri.enableDefaultPath = false;
  };
}