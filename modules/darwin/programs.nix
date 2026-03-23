{ inputs, lib, config, pkgs, ... }:

let
  packages = config.may.packages;
  developerCfg = config.may.features.developer;
in {
  config = rec {
    environment.systemPackages = 
      # Grab all the enabled package options and install them
      # as system packages.
      packages
      |> lib.attrsets.filterAttrs (name: value: value)
      |> builtins.attrNames
      |> builtins.map(name: pkgs.${name});

    programs.zsh = lib.mkIf developerCfg.enable {
      enable = true;
      enableCompletion = true;
      enableBashCompletion = true;
      enableAutosuggestions = true;
      histSize = 10000;
      enableSyntaxHighlighting = true;
    };
  };
}