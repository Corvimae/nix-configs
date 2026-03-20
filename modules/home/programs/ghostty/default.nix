{ nixosConfig, inputs, lib, config, ... }:

let
  cfg = nixosConfig.may.programs.ghostty;
in {
  config.programs.ghostty = lib.mkIf cfg.enable {
    inherit (cfg) enable;
    systemd.enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = import ./settings.nix;
  };
}