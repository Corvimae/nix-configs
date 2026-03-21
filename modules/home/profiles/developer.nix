{ self, config, lib, ... }:

let
  cfg = config.may.profiles.developer;
  inherit (lib) mkDefault;
in {
  config = lib.mkIf cfg.enable {
    may = {
      programs = {
        git.enable = mkDefault true;
      };
    };
  };
}