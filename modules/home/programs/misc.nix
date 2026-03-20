{ config, lib, pkgs, ... }:

let
  cfg = config.may.programs;
  optionalPrograms = [
    "vesktop"
    "slack"
    "thunderbird"
  ];
in {
  options.may.programs = lib.pipe optionalPrograms [
    (builtins.map(name: {
      inherit name;
      value = lib.mkProgramOption name; # todo: camelcase?
    }))
    (builtins.listToAttrs)
  ];

  config = {
    environment.systemPackages = builtins.foldr(
      # Merge in system package options if enabled
      (item: acc: acc ++ (lib.optionals cfg[item] [pkgs[item]]))
    ) optionalPrograms;
  };
}