{ inputs, lib, config, pkgs, ... }:

let
  cfg = config.may.programs;
in {
  # darwin requires everything to be installed in systemPackages, so we
  # reimplement this in modules/darwin/programs.nix and only run this when
  # building for nixOS
  config = lib.mkIf (!config.may.profiles.darwin.enable) {
    home.packages = lib.lists.foldr(
      # Merge in home package options if enabled
      (item: acc: acc ++ (lib.optionals cfg.${item}.enable [pkgs.${item}]))
    ) [] inputs.self.optionals.programs;
  };
}