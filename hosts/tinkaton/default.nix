{ self', pkgs, ... }:

{
  imports = [];

  networking.hostName = "tinkaton";

  may = pkgs.mayUtils.loadConfig "tinkaton" ../../config.toml;
}