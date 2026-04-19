{ inputs, lib, config, pkgs, ... }:

let
  cfg = config.may.programs.vscode;
in {
  config = lib.mkIf cfg.enable {
    programs.vscode = {
      inherit (cfg) enable;
      profiles.default = {
        extensions = import ./extensions.nix;
        userSettings = import ./settings.nix;
      };
    };
  };
}
