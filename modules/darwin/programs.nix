{ inputs, lib, config, pkgs, ... }:

let
  packages = config.may.packages;
  developerCfg = config.may.features.developer;
in {
  config = rec {
    # environment.systemPackages = lib.lists.foldr(
    #   # Merge in system package options if enabled
    #   (item: acc: acc ++ (lib.optionals cfg.${item}.enable [pkgs.${item}]))
    # ) [] inputs.self.optionals.packages;

    environment.systemPackages = 
      packages
      |> lib.attrsets.filterAttrs (name: value: value)
      |> builtins.attrNames
      |> builtins.map(name: pkgs.${name});

    programs.zsh = lib.mkIf developerCfg.enabled {
      enable = true;
      enableCompletion = true;
      enableBashCompletion = true;
      enableAutosuggestions = true;
      histSize = 10000;
      enableSyntaxHighlighting = true;
    };
  };
}