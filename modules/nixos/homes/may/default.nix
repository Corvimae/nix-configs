{ lib, inputs, ... }:

{
  home-manager.users.may = {
    imports = [
      inputs.self.homeModules.allHomeModules
      {
        home.username = "may";
        home.stateVersion = "25.11";
      }
    ];
  };
}