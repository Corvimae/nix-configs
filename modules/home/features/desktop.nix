{ self, pkgs, config, lib, ... }:

let
  cfg = config.may.features.desktop;
  inherit (lib) mkDefault;
in {
  # config = lib.mkIf cfg.enable {
  #   may = {
  #     programs = {
  #       firefox.enable = true;
  #       ghostty.enable = true;
  #       vscode.enable = true;
  #       vesktop.enable = true;
  #       slack.enable = true;
  #       thunderbird.enable = true;
  #     };
  #   };
  # };
}