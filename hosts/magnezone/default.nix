{ self', pkgs, ... }:

let
  config = pkgs.mayUtils.loadConfig "magnezone" ../../config.toml;
in {
  imports = [
    ./bootloader.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "magnezone";

  
  may = config;

  # may = {
    # profiles = {
    #   gui.enable = true;
    #   desktop.enable = true;
    #   developer.enable = true;
    # };

    # programs = {
    #   git.enable = true;
    #   vesktop.enable = true;
    #   vscode.enable = true;
    # };

    # services = {
    #   sshAgent.enable = true;
    # };
  # };
}