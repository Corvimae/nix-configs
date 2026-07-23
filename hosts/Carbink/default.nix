{ self', lib, pkgs, ... }:

{
  imports = [];

  # dunno why it wants this so badly
  users.users.may-darwin.home = "/Users/may";

  may = pkgs.mayUtils.loadConfig "Carbink" ../../config.toml;

  home-manager.users.may-darwin = {
    programs.firefox.profiles.may.extensions.packages = lib.mkAfter [
      pkgs.firefoxAddons.cookie-editor
    ];
  };
}