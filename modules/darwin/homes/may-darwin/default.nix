{ lib, inputs, pkgs, ... }:

{
  home-manager.backupFileExtension = "hm-backup";
  home-manager.overwriteBackup = true;
  # home-manager.backupCommand = "${pkgs.trash-cli}/bin/trash";

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
    };
  };
}