{ lib, inputs, pkgs, ... }:

{
  imports = [
    ./settings.nix
  ];

  security.pam.services.sudo_local.touchIdAuth = true;
  
  system.stateVersion = 6;
  system.primaryUser = "may";

  nix.settings = {
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

  nixpkgs = {
    config.allowUnfree = true;
    
    # attempt to remove this when whatever is still using 40.10.5 updates
    config.permittedInsecurePackages = [
      "electron-40.10.5"
    ];

    # Very annoying that you need to redefine this here :(
    overlays = inputs.self.allOverlays;
  };

  networking = {
    knownNetworkServices = [
      "Wi-Fi"
      "USB 10/100/1000 LAN"
      "Thunderbolt Bridge"
    ];
    dns = [
      "10.0.1.11"
      "1.1.1.1"
    ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];
}