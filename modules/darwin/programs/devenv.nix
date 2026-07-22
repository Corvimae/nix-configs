{ inputs, lib, config, pkgs, ... }:

let
  cfg = config.may.programs.devenv;
in {
  config = lib.mkIf cfg.enable {
    # Package is installed here as nix-darwin attempts to grant App Management
    # permissions, and home-manager does not seem to do so.
    environment.systemPackages = with pkgs; [devenv];
  };
}
