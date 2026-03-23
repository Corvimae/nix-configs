{ self, config, pkgs, lib, ... }:

let
  cfg = config.may.features.developer;
  # cfg = pkgs.mayUtils.getFeatureOption config "developer";
  # enable = pkgs.mayUtils.isFeatureEnabled config "developer";
  inherit (lib) mkDefault;
in {
  config = lib.mkIf cfg.enable {
    # may = {
    #   programs = {
    #     git.enable = true;
    #   };

    #   packages = {
    #     asdf-vm.enable = true;
    #   };
    # };
  };
}