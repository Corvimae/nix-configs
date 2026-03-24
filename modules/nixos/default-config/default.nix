{ lib, ... }:

{
  imports = [
    ./bootloader.nix
    ./networking.nix
    ./locale.nix
    ./nixSettings.nix
    ./systemPackages.nix
    ./services.nix
    ./users.nix
  ];

  system.stateVersion = "25.11";
}