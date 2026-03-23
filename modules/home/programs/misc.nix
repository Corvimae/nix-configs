{ inputs, lib, config, pkgs, ... }:

let
  packages = config.may.packages;
  isNixOS = config.may.class == "nixos";
in {
  # darwin requires everything to be installed in systemPackages, so we
  # reimplement this in modules/darwin/programs.nix and only run this when
  # building for nixOS
  config = lib.mkIf isNixOS {
    home.packages = 
      packages
      |> lib.attrsets.filterAttrs (name: value: value.enable)
      |> builtins.attrNames
      |> builtins.map(name: pkgs.${name});
  };

}