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

      vencord.settings.plugins = {
        AlwaysTrust.enabled = true;
        BetterSettings.enabled = true;
        FixYoutubeEmbeds.enabled = true;
        ForceOwnerCrown.enabled = true;
        NoDevtoolsWarning.enabled = true;
        NoF1.enabled = true;
        NoOnboardingDelay.enabled = true;
        NoProfileThemes.enabled = true;
        PermissionsViewer.enabled = true;
        WebScreenShareFixes.enabled = true;
      };
    };
  };
}