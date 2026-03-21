{ self, config, lib, pkgs, ... }:

let
  cfg = config.may.programs;

  inherit (lib) mkIf;
in {
  config = {
    programs = {
      zsh.enable = true;
    };
  };
}