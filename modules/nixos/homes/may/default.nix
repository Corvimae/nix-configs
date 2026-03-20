{ lib, inputs, ... }:

{
  home-manager.users.may = {
    imports = [
      inputs.self.homeModules.allModules
      {
        home.username = "may";
        home.stateVersion = "25.11";
        may.profiles.desktop.enable = lib.mkDefault false;
      }
    ];
  };
}