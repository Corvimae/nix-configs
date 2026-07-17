{
  imports = [
    # kinda cheating importing this here but it's okay
    # nobody needs to know :)
    # todo: fix this lol
    ../options.nix

    # actual program imports
    ./firefox
    ./ghostty
    ./iterm
    ./omniwm
    ./vscode
    ./git.nix
    ./misc.nix
    ./vesktop.nix
    ./zsh.nix
  ];
}