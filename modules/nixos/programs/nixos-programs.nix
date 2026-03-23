{ self, config, lib, pkgs, ... }:

# todo: break this out into its own steam module.
let
  steamCfg = config.may.programs.steam;

  inherit (lib) mkIf;
in {
  config = {
    programs = {
      steam = mkIf steamCfg.enable {
        enable = true;
        protontricks.enable = true;
        gamescopeSession.enable = true;
      };
    };

    environment.systemPackages = lib.optionals steamCfg.enable [
      pkgs.protonplus
    ];      
  };
}