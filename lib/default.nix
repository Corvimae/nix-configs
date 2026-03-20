{ lib, ... }: 

{
  flake = {
    lib = {
      mkGroupedOption = group: name: {
        enable = lib.mkEnableOption "${group} — ${name}";
      };

      mkProgramOption = name: lib.mkGroupedOption "Programs" name;
      mkServiceOption = name: lib.mkGroupedOption "Services" name;
    };
  };
}