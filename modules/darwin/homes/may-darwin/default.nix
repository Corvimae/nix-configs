{ lib, inputs, ... }:

{
  home-manager.users.may-darwin = {
    imports = [
      inputs.self.homeModules.sharedHomeModules
      {
        home.username = lib.mkForce "may";
        home.stateVersion = "26.05";
      }
    ];

    programs.zsh.shellAliases = {
      renix = "sudo darwin-rebuild switch --flake ~/Projects/nix-configs";
      nix-repl = "nix repl --extra-experimental-features 'flakes' nixpkgs";

      # doctl shortcuts
      ff-context = "kubectl config use-context do-nyc1-ff-k8s";
      maybreak-context = "kubectl config use-context do-nyc1-maybreak-k8s";
      board-game-manager-context = "kubectl config use-context do-nyc1-board-game-manager";
      gdq-context = "kubectl config use-context do-nyc1-k8s-gdq-api";
      tracker-context = "kubectl config use-context do-nyc1-gdq-donation-tracker";
    };
  };
}