{ self', lib, pkgs, ... }:

{
  imports = [];

  # dunno why it wants this so badly
  users.users.may-darwin.home = "/Users/may";

  may = pkgs.mayUtils.loadConfig "Carbink" ../../config.toml;
}