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
      nix-upgrade = "cd ~/.config/nixos && nix flake update --extra-experimental-features \"nix-command flakes\" && sudo nixos-rebuild switch --upgrade";
      nix-repl = "nix repl --extra-experimental-features 'flakes' nixpkgs";
    };
  };
}