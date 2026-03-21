final: prev: {
  mayUtils = let
    lib = prev.lib;
  in rec {
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
      profiles = mkOptionSet optionals.profiles;
      programs = mkOptionSet optionals.programs;
      services = mkOptionSet optionals.services;
    };
  };
}