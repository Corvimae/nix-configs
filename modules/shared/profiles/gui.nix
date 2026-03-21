{ config, lib, ... }:

let
  cfg = config.may.profiles.gui;
  inherit (lib) mkDefault;
in {
  config = lib.mkIf cfg.enable {
    may = {
      services = {
        sshAgent.enable = true;
      };  
    };
  };
}