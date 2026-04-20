{ pkgs, ... }:

let 
  marketplaceExtensions = with pkgs.nix-vscode-extensions.vscode-marketplace; [
    # ms-vscode-remote.remote-ssh
    # ms-vscode-remote.remote-ssh-edit
    # ms-vscode.remote-explorer
  ];

  openVsxExtensions = with pkgs.nix-vscode-extensions.open-vsx; [
    # ssh
    jeanp413.open-remote-ssh

    # highlighting
    jnoortheen.nix-ide
    styled-components.vscode-styled-components
    redhat.vscode-yaml
    tamasfe.even-better-toml

    # utils
    mk12.better-git-line-blame

    # linters
    prisma.prisma
    dbaeumer.vscode-eslint
  ];
in marketplaceExtensions ++ openVsxExtensions
