{ pkgs, lib, config, ... }:

let
  cfg = config.may.profiles.desktop;
  inherit (lib) mkIf mkDefault mkEnableOption;
in {
  options.may.profiles.desktop = {
    enable = mkEnableOption "Desktop Home Profile";
  };

  config = mkIf cfg.enable {
    may.profiles.base.enable = true;
    may.profiles.desktop.enable = true;

    home.packages = with pkgs; [];
  };
}