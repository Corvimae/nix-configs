{ inputs, lib, pkgs, config, ... }:

let
  cfg = config.may.programs.ghostty;
  isDarwin = config.may.class == "darwin";
in {
  config.programs.ghostty = lib.mkIf cfg.enable {
    inherit (cfg) enable;
    # breaks osx workflow until this is merged: https://github.com/ghostty-org/ghostty/pull/9857
    package = if isDarwin
      then pkgs.ghostty-bin
      else pkgs.ghostty;
    systemd.enable = !isDarwin;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = import ./settings.nix;
  };
}