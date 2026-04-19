{ pkgs, ... }:

with pkgs.vscode-extensions; [
  # ssh
  ms-vscode-remote.remote-ssh
  ms-vscode-remote.remote-ssh-edit
  ms-vscode.remote-explorer

  # highlighting
  jnoortheen.nix-ide
  styled-components.vscode-styled-components
  redhat.vscode-yaml
  tamasfe.even-better-toml

  # utils
  eamodio.gitlens

  # linters
  prisma.prisma
  dbaeumer.vscode-eslint
]