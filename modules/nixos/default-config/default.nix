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

  # i swear i picked this independently and did not just copy.
  catppuccin = {
    flavor = "latte";
    accent = "lavender";
    winDecStyle = "classic";
  };
}