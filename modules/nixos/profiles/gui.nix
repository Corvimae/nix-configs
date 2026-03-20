{ config, lib, ... }:

let
  cfg = config.may.profiles.gui;
  inherit (lib) mkDefault;
in {
  options.may.profiles.gui = {
    enable = lib.mkEnableOption "GUI Profile";
  };

  config = lib.mkIf cfg.enable {
    may = {
      programs = {
        firefox.enable = mkDefault true;
        ghostty.enable = mkDefault true;
        vscode.enable = mkDefault true;
        slack.enable = mkDefault true;
        thunderbird.enable = mkDefault true;
      };

      services = {
        sshAgent.enable = true;
      };  
    };
  };
}