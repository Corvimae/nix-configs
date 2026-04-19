{ inputs, lib, config, pkgs, ...}:

let
  cfg = config.may.programs.vesktop;
  isStandalone = config.may.class == "standalone";
in {
  config = lib.mkIf cfg.enable {
    programs.vesktop = {
      inherit (cfg) enable;

      package = if isStandalone
        then null
        else pkgs.vesktop;

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