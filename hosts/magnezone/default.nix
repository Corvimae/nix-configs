{ self', pkgs, ... }:

{
  imports = [
    ./bootloader.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "magnezone";

  may = pkgs.mayUtils.loadConfig "magnezone" ../../config.toml;
}