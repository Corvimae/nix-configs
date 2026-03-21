{ lib, inputs, ... }:

{
  home-manager.users.may = {
    imports = [
      inputs.self.homeModules.sharedHomeModules
      inputs.self.homeModules.xdg
      inputs.self.homeModules.plasma
      {
        home.username = "may";
        home.stateVersion = "25.11";
      }
    ];

    programs.zsh.shellAliases = {
      renix = "sudo nixos-rebuild switch";
      nix-repl = "nix repl --extra-experimental-features 'flakes' nixpkgs";
    };
  };
}