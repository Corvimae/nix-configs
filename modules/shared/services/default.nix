{ self, config, lib, pkgs, ... }:

let
  cfg = config.may.services;

  inherit (lib) mkIf;
in {}