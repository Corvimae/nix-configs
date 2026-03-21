{ config, lib, pkgs, ...}:

let
  cfg = config.may.programs.firefox;
in {
  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;

      wrapperConfig.cfg = {
        pipewireSupport = true;
        ffmpegSupport = true;
      };

      policies = import ./policies.nix;
      preferences = import ./preferences.nix;
    };
  };
}