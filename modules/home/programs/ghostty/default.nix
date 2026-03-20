{ lib, config, ... }:

let
  cfg = config.may.programs.ghostty;
in {
  options.may.programs.ghostty = lib.mkProgramOption "ghostty";

  config.programs.ghostty = lib.mkIf cfg.enable {
    inherit (cfg) enable;
    systemd.enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = import ./settings.nix;
  };
}