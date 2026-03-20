{ pkgs, configs, lib, ... }: 

{
  config = {
    users.users.may = {
      description = "May";
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel"];
      hashedPassword = "$y$j9T$Qt4M.nfZ7fkSswgjflzHM.$B1FUSnBy6/vCZjLF7llbEUtcHxI4BNctanUmx.jjal7";
      shell = pkgs.zsh;
    };
  };
}