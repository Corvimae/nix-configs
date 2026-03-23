{ self', lib, pkgs, ... }:

{
  imports = [];

  # dunno why it wants this so badly
  users.users.may-darwin.home = "/Users/may";

  may = pkgs.mayUtils.loadConfig "Archen" ../../config.toml;
}