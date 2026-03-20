{ self, config, lib, pkgs, ... }:

let
  cfg = config.may.programs;

  inherit (lib) mkIf;
in {
  options.may.programs = lib.pipe self.optionals.programs [
    (builtins.map(name: {
      inherit name;
      value = self.lib.mkProgramOption name; # todo: camelcase?
    }))
    (builtins.listToAttrs)
  ];

  config = {
    programs = {
      zsh.enable = true;

      steam = mkIf cfg.steam.enable {
        enable = true;
        protontricks.enable = true;
        gamescopeSession.enable = true;
      };
    };

    environment.systemPackages = lib.optionals cfg.steam.enable [
      pkgs.protonplus
    ];      
  };
}