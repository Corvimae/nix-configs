{ config, lib, pkgs, ... }:

let
  cfg = config.may.programs;
  inherit (lib) mkIf mkProgramOption;
in {
  options.may.programs = {
    steam = mkProgramOption "Steam";
  };

  config = {
    programs = {
      steam = mkIf cfg.steam.enable {
        enable = true;
        protontricks.enable = true;
        gamescopeSession.enable = true;
      };
    };

    environment.systemPackages = lib.optionals cfg.steam.enable {
      pkgs.protonplus
    };
  };
}