{ inputs, lib, config, pkgs, ... }:

let
  cfg = config.may.programs.vscode;
in {
  config = lib.mkIf cfg.enable {
    programs.vscode = {
      inherit (cfg) enable;
      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
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
        ];

        userSettings = {
          "editor.tabSize" = 2;
          "explorer.confirmDragAndDrop" = false;
          "explorer.confirmDelete" = false;
          "terminal.integrated.stickyScroll.enabled" = false;
          "terminal.integrated.fontLigatures.enabled" = true;
          "workbench.editor.useModal" = "off";
          "chat.disableAIFeatures" = true;
          "chat.autopilot.enabled" = false;
        };
      };
    };
  };
}
