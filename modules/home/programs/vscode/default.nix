{ inputs, lib, config, pkgs, ... }:

let
  cfg = config.may.programs.vscode;
in {
  config = lib.mkIf cfg.enable {
    programs.vscode = {
      inherit (cfg) enable;
      package = pkgs.vscodium;

      profiles.default = {
        extensions = import ./extensions.nix { inherit pkgs; };

        userSettings = import ./settings.nix;
      };
    };
  };
}
