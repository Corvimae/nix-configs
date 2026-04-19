{ inputs, lib, config, pkgs, ...}:

let
  cfg = config.may.programs.vesktop;
in {
  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.vesktop];

    programs.vesktop = {
      inherit (cfg) enable;

      settings = {
        discordBranch = "stable";
        tray = true;
        minimizeToTray = true;
        clickTrayToShowHide = true;
        hardwareAcceleration = true;
        hardwareVideoAcceleration = true;
        customTitleBar = true;
      };
    };
  };
}