{ config, inputs, lib, pkgs, ... }:

let
  enable = config.may.features.desktop.enable && config.may.desktopShell == "noctalia";
in {
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

    # services.greetd = {
    #   enable = true;
    #   settings = {
    #     default_session = {
    #       command = "${config.programs.niri.package}/bin/niri-session";
    #       user = "may";
    #     };
    #   };
    # };

    # NixOS otherwise injects a stripped PATH via Environment= on the niri.service
    # unit which shadows the imported user-manager PATH. Disabling the default
    # lets niri inherit the full PATH set up by niri-session.
    systemd.user.services.niri.enableDefaultPath = false;
  };
}