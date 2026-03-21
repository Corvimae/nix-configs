{ inputs, nixosConfig, lib, pkgs, ... }@args:

let
  cfg = (inputs.self.lib.withConfig args).may.programs.firefox;
in {
  config = lib.mkIf cfg.enable {
    programs.firefox = {
      inherit (cfg) enable;

      profiles.may = {
        id = 0;
        name = "May";
        extensions = lib.mkDefault {
          packages = with pkgs.firefox-addons; [
            ublock-origin
            bitwarden-password-manager
          ];
        };
      };
    };
  };
}