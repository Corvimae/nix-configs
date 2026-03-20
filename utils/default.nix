{ config, lib, ... }:

{
  # i love the global variable scope its my bestie
  flake.lib = rec {
    mkGroupedOption = group: name: {
      enable = lib.mkEnableOption "${group} — ${name}";
    };
    mkProgramOption = name: mkGroupedOption "Programs" name;
    mkServiceOption = name: mkGroupedOption "Services" name;
  };
}