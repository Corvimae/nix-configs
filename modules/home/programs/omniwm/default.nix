{ inputs, lib, config, pkgs, ... }:

let
  cfg = config.may.programs.omniwm;
in {
  # DARWIN ONLY.
  config = lib.mkIf cfg.enable {
    # Omniwm has to be installed manually, it's not in nixpkgs and I don't wanna deal with that.
    # This is just for syncing config.

    home.file."${config.home.homeDirectory}/.config/omniwm/settings.toml" = {
      source = ./settings.toml;
    };
  };
}
