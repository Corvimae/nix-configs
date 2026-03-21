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

    defineOptions = optionals: {
      profiles = {
        base = {
          enable = lib.mkEnableOption "Base Profile";
        };

        gui = {
          enable = lib.mkEnableOption "GUI Profile";
        };

        desktop = {
          enable = lib.mkEnableOption "Desktop Profile";
        };
        
        darwin = {
          enable = lib.mkEnableOption "Darwin Profile";
        };
      };

      programs = mkOptionSet (
        optionals.programs.managed ++ 
        optionals.programs.unmanaged
      );

      services = mkOptionSet optionals.services;
    };
  };
}