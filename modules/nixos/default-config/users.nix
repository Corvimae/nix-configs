{ lib, pkgs, ... }:

{
  users.users = {
    may = lib.mkDefault {
      isNormalUser = true;
      description = lib.mkDefault "May";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      shell = pkgs.zsh;

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMIyUhpK+rlEu8K9vZ6gmd7dCgdyPxjtv7oTLZBsLplF may@maybreak.com" # duosion
      ];
    };
  };
}