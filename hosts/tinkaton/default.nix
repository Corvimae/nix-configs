{ self', pkgs, ... }:

{
  imports = [
    ./bootloader.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "tinkaton";

  may = pkgs.mayUtils.loadConfig "tinkaton" ../../config.toml;
}
