{ config, lib, ... }:

let 
  cfg = config.may.profiles;
in {
  options.may.profiles = {
    base.enable = lib.mkEnableOption "Base Profile"
    desktop.enable = lib.mkEnableOption "Desktop Profile";
  }

  config = {
    may.profiles = {
      base.enable = lib.mkDefault true;
      desktop.enable = lib.mkDefault false;
    };
  };
}p