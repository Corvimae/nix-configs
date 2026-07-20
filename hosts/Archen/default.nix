{ self', lib, pkgs, ... }:

{
  imports = [];

  # dunno why it wants this so badly
  users.users.may-darwin = {
    home = "/Users/may";
  };

  may = pkgs.mayUtils.loadConfig "Archen" ../../config.toml;

  home-manager.users.may-darwin = {
    programs.zsh.shellAliases = {
      # doctl shortcuts
      ff-context = "kubectl config use-context do-nyc1-ff-k8s";
      maybreak-context = "kubectl config use-context do-nyc1-maybreak-k8s";
      board-game-manager-context = "kubectl config use-context do-nyc1-board-game-manager";
      gdq-context = "kubectl config use-context do-nyc1-k8s-gdq-api";
      tracker-context = "kubectl config use-context do-nyc1-gdq-donation-tracker";

      # ssh shortcuts
      studio-nodecg = "ssh -p 2010 gdq-studio-server";
    };
  };
}