{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [
    home-manager
    zsh
    git
    oh-my-zsh
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    autosuggestions.async = true;
    histSize = 10000;
    syntaxHighlighting.enable = true;
  };
}