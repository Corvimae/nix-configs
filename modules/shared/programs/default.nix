{ self, config, lib, pkgs, ... }:

let
  cfg = config.may.programs;

  inherit (lib) mkIf;
in {
  options.may.programs = self.lib.mkOptionSet (self.optionals.programs.managed ++ self.optionals.programs.unmanaged);

  config = {
    programs = {
      zsh.enable = true;
    };
  };
}