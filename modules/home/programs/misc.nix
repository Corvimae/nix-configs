{ inputs, nixosConfig, lib, pkgs, ... }:

let
  cfg = nixosConfig.may.programs;
in {
  config = {
    home.packages = lib.lists.foldr(
      # Merge in system package options if enabled
      (item: acc: acc ++ (lib.optionals cfg.${item}.enable [pkgs.${item}]))
    ) [] inputs.self.optionals.programs;
  };
}