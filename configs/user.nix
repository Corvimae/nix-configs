{ pkgs, config, ... }:

{
  users.users.may = {
    isNormalUser = true;
    description = "May";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };
}