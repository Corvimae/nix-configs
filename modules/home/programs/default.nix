{
  imports = [
    # kinda cheating importing this here but it's okay
    # nobody needs to know :)
    ../options.nix

    # actual program imports
    ./ghostty
    ./firefox.nix
    ./vscode.nix
    ./git.nix
    ./misc.nix
    ./zsh.nix
  ];
}