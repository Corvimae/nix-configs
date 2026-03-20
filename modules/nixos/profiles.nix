{ config, lib, ... }:

let 
  cfg = config.may.profiles;
in {
  options.may.profiles = {
    base.enable = lib.mkEnableOption "Base Profile"
    gui.enable = lib.mkEnableOption "GUI Profile";
  }

  config = {
    may.profiles = {
      base.enable = lib.mkDefault true;
      gui.enable = lib.mkDefault false;
    };
  };
}