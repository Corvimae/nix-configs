final: prev: {
  mayUtils = let
    lib = prev.lib;
  in rec {
    # Create an enable option with a boilerplate Group - Name
    # description.
    mkGroupedEnableOption = group: name: {
      enable = lib.mkEnableOption "${group} — ${name}";
    };

    # Create a generic option for every value in a list of strings.
    # The option name will match the string.
    mkOptionSet = description: list: lib.pipe list [
      (builtins.map(name: {
        inherit name;
        value = mkGroupedEnableOption description name; # todo: camelcase?
      }))
      (builtins.listToAttrs)
    ];

    # Define all the types of option sets we want for our
    # config.
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

    # Load a TOML config file and determine every unique value
    # within it so that we can create a comprehensive set of 
    # options.
    #
    # For each option group (service, programs, etc.), a list
    # is created containing every value specified within a host
    # definition or a feature definition.
    #
    # Possible todo: Expand this to programs as well.
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

    # Take a TOML config file and define options off its
    # comprehensive value sets.
    buildOptionsFromToml = file:
      file
      |> loadFlattenedConfigToml
      |> defineOptions;

    # Turn a list of keys into a list of enabled options.
    # e.g.
    # ["a" "b"] becomes {
    #   a = { enable = true; };
    #   b = { enable = true; }; 
    # }
    hydrateOptionSet = set:
      set
      |> lib.lists.foldr(item: acc: {
        ${item}.enable = true;
      } // acc) {};

    # Load a config TOML for a host and turn it into
    # a hydrated list of option properties by merging
    # features into the specified sets.
    loadConfig = hostname: file:
      let
        toml =
          file
          |> builtins.readFile
          |> builtins.fromTOML;

        config = { inherit hostname; } // toml.hosts.${hostname};
        
        # Grab the options specified in the features enabled in
        # this host.
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

          # Merge in the features options to the host-specific options.
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
        personal = lib.attrsets.attrByPath ["personal"] false config;
        plasma = lib.attrsets.attrByPath ["plasma"] {} config;

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
      };

      personal = lib.mkOption {
        type = lib.types.bool;
        description = "Whether this is a personal device (as opposed to a work device).";
      };

      plasma = {
        launcherIcon = lib.mkOption {
          type = lib.types.str;
          description = "The icon to use for the application launcher in Plasma desktop.";
        };
      };
     } // (buildOptionsFromToml configFile);

    # Given a list of attribute sets with `value` (required) and
    # `enabled` (optional, defaults true), filter out all values
    # with `enabled = false` and map them to their `value`s.
    mkConditionalList = list:
      list
      |> lib.filter (entry: entry.enabled or true)
      |> lib.map (entry: entry.value);
  };
}