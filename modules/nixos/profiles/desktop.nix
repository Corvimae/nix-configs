{ config, lib, ... }:

let
  cfg = config.may.profiles.desktop;
  inherit (lib) mkDefault;
in {
  options.may.profiles.desktop = {
    enable = lib.mkEnableOption "Desktop Profile";
  };

  config = lib.mkIf cfg.enable {
    may = {
      programs = {
        firefox.enable = mkDefault true;
        ghostty.enable = mkDefault true;
        vscode.enable = mkDefault true;
        slack.enable = mkDefault true;
        thunderbird.enable = mkDefault true;
        steam.enable = mkDefault true;
      };
    };
  };
}