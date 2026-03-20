{ config, lib, pkgs, ...}:

{
  programs.firefox = {
    enable = true;
    profiles.may = {
      id = 0;
      name = "May";
      extensions.packages = with pkgs.firefox-addons; [
        ublock-origin
        bitwarden-password-manager
      ];
      settings = import ./settings.nix;
    };
    policies = import ./policies.nix;
  };
}