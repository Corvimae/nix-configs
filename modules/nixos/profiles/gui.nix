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
      services = {
        sshAgent.enable = true;
      };  
    };
  };
}