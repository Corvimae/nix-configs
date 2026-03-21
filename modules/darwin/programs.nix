{ inputs, lib, config, pkgs, ... }:

let
  cfg = config.may.programs;
in {
  config = rec {
    environment.systemPackages = lib.lists.foldr(
      # Merge in system package options if enabled
      (item: acc: acc ++ (lib.optionals cfg.${item}.enable [pkgs.${item}]))
    ) [] inputs.self.optionals.programs.unmanaged;
  };
}