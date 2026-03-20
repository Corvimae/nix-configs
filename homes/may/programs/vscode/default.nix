{ pkgs, config, ... }:

{
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      # ssh
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-ssh-edit
      ms-vscode.remote-explorer

      # highlighting
      bbenoist.nix
      styled-components.vscode-styled-components
      redhat.vscode-yaml

      # utils
      eamodio.gitlens

      # linters
      prisma.prisma
      dbaeumer.vscode-eslint
    ];
  };
}
