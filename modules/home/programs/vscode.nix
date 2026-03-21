{ inputs, lib, pkgs, ... }@args:

let
  cfg = (inputs.self.lib.withConfig args).may.programs.vscode;
in {
  config = lib.mkIf cfg.enable {
    programs.vscode = {
      inherit (cfg) enable;
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
  };
}
