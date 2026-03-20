{ lib, ... }:

{
  imports = [
    ./bootloader.nix
    ./networking.nix
    ./locale.nix
    ./nixpkgs.nix
    ./systemPackages.nix
    ./services.nix
    ./users.nix
  ];

  system.stateVersion = "25.11";
}