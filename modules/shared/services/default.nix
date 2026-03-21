{ self, config, lib, pkgs, ... }:

let
  cfg = config.may.services;

  inherit (lib) mkIf;
in {
  options.may.services = self.lib.mkOptionSet self.optionals.services;
}