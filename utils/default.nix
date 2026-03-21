{ config, lib, ... }:

{
  # i love the global variable scope its my bestie
  flake.lib = rec {
    mkGroupedOption = group: name: {
      enable = lib.mkEnableOption "${group} — ${name}";
    };
    mkProgramOption = name: mkGroupedOption "Programs" name;
    mkServiceOption = name: mkGroupedOption "Services" name;

    mkOptionSet = list: lib.pipe list [
      (builtins.map(name: {
        inherit name;
        value = mkProgramOption name; # todo: camelcase?
      }))
      (builtins.listToAttrs)
    ];

    # this feels fucked up lol
    withConfig = inputs: if isNixOS inputs
      then inputs.nixosConfig
      else inputs.darwinConfig;

    isNixOS = inputs: inputs._class == "nixos";
  };
}