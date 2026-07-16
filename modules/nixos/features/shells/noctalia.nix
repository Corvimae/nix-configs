{ config, inputs, lib, pkgs, ... }:

let
  enable = config.may.features.desktop.enable && config.may.desktopShell == "noctalia";
in {
  imports = [
    inputs.noctalia.nixosModules.default
    inputs.noctalia-greeter.nixosModules.default
    inputs.monique.nixosModules.default
  ];

  config = lib.mkIf enable {
    environment.systemPackages = [
      pkgs.kitty
      pkgs.kdePackages.dolphin
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    programs.noctalia = {
      enable = true;

      # Enables NetworkManager, Bluetooth, UPower, and a power profile service.
      recommendedServices.enable = true;
    };

    programs.noctalia-greeter = {
      enable = true;

      # Optional configuration
      greeter-args = "--session Hyprland";
      settings = {
        keyboard = {
          layout = "us";
        };
      };
    };

    programs.monique.enable = true;

    # NixOS otherwise injects a stripped PATH via Environment= on the niri.service
    # unit which shadows the imported user-manager PATH. Disabling the default
    # lets niri inherit the full PATH set up by niri-session.
    systemd.user.services.niri.enableDefaultPath = false;
  };
}