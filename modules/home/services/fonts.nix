{ inputs, pkgs, lib, config, osConfig, ... }:

let
  cfg = config.may.services.fonts;
in
{  
  config = lib.mkIf cfg.enable {
    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      fira-code
    ];
  };
}