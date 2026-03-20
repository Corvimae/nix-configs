{ config, lib, pkgs, ...}:

let
  cfg = config.may.programs.firefox;
in {
  options.may.programs.firefox = {
    enable = lib.mkEnableOption "Programs — Firefox";    
  };

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      wrapperConfig.cfg = {
        pipewireSupport = true;
        ffmpegSupport = true;
      };
      policies = import ./policies.nix;
      preferences = import ./settings.nix;
    };
  };
}