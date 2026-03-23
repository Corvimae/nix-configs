final: prev: {
  mayUtils = let
    lib = prev.lib;
  in rec {
    mkGroupedOption = group: name: {
      enable = lib.mkEnableOption "${group} — ${name}";
    };
    mkOptionSet = description: list: lib.pipe list [
      (builtins.map(name: {
        inherit name;
        value = mkGroupedOption description name; # todo: camelcase?
      }))
      (builtins.listToAttrs)
    ];

    defineOptions = {
      features ? [],
      programs ? [],
      services ? [],
      packages ? [],
      ...
    }: {
      features = mkOptionSet "Features" features;
      programs = mkOptionSet "Programs" programs;
      services = mkOptionSet "Services" services;
      packages = mkOptionSet "Packages" packages;
    };

    loadFlattenedConfigToml = file:
      let
        toml = file
          |> builtins.readFile
          |> builtins.fromTOML;
      in
      # todo: this doesn't allow features and hosts to share names.
      # probably fine?
      (
        (lib.attrsets.attrByPath ["features"] {} toml) //
        (lib.attrsets.attrByPath ["hosts"] {} toml)
      )
      |> lib.attrsets.attrValues
      |> lib.attrsets.zipAttrs
      |> lib.attrsets.concatMapAttrs(key: value: {
        ${key} = 
          value
          |> lib.lists.flatten
          |> lib.lists.unique; 
      });

    buildOptionsFromToml = file:
      file
      |> loadFlattenedConfigToml
      |> defineOptions;

    hydrateOptionSet = set:
      set
      |> lib.lists.foldr(item: acc: {
        ${item}.enable = true;
      } // acc) {};

    loadConfig = hostname: file:
      let
        toml =
          file
          |> builtins.readFile
          |> builtins.fromTOML;

        config = { inherit hostname; } // toml.hosts.${hostname};
        
        featureOptions =
          ["programs" "packages" "services"]
          |> lib.lists.foldr(groupName: acc: acc // {
            ${groupName} = 
              lib.attrsets.attrByPath ["features"] [] config
              |> builtins.map(featureName:
                lib.attrsets.attrByPath ["features" featureName groupName] [] toml
              )
              |> lib.lists.flatten;
          }) {};

          mergedOptions =
            ["programs" "packages" "services" "features"]
            |> lib.lists.foldr(groupName: acc: acc // {
              ${groupName} =
                (
                  (lib.attrsets.attrByPath [groupName] [] config) ++
                  (lib.attrsets.attrByPath [groupName] [] featureOptions)
                )
                |> lib.lists.unique;
            }) {};
      in {
        inherit (config) hostname class;
        homeConfig = lib.attrsets.attrByPath ["homeConfig"] false config; 
        features = hydrateOptionSet mergedOptions.features;
        programs = hydrateOptionSet mergedOptions.programs;
        packages = hydrateOptionSet mergedOptions.packages;
        services = hydrateOptionSet mergedOptions.services;
      };

    # Define all the options used by the system based on what
    # is present in the config TOML file.
    defineAllOptions = configFile: {
      class = lib.mkOption {
        type = lib.types.str;
        description = "Whether this is a NixOS or a nix-darwin install";
      };

      hostname = lib.mkOption {
        type = lib.types.str;
        description = "The hostname of the machine.";
      };

      homeConfig = lib.mkOption {
        type = lib.types.bool;
        description = "Whether to enable home-manager-based configs.";
        # default = false;
      };
     } // (buildOptionsFromToml configFile);
  };
}