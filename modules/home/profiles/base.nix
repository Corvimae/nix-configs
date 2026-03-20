{ config, lib, ... }:

let
  cfg = config.may.profiles.base;
in
{
  options.may.profiles.base.enable = lib.mkEnableOption "Base Home Profile";
  
  config = lib.mkIf cfg.enable {
    home.stateVersion = "26.05";
    home.language = {
      base = "en_US.utf8";
    };
  };
}