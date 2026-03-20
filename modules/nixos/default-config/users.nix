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
    };
  };
}