{ inputs, lib, config, ... }@args:

let
  cfg = (inputs.self.lib.withConfig args).may.programs.ghostty;
in {
  config.programs.ghostty = lib.mkIf cfg.enable {
    inherit (cfg) enable;
    systemd.enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = import ./settings.nix;
  };
}