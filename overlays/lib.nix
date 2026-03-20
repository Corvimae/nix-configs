final: prev:

let
  mkGroupedOption = group: name: {
    enable = lib.mkEnableOption "${group} — ${name}";
  };
in {
  lib = prev.lib // {
    inherit mkGroupedOption;
    mkProgramOption = name: mkGroupedOption "Programs" name;
    mkServiceOption = name: mkGroupedOption "Services" name;
  };
}