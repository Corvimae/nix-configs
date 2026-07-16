{ config, lib, ...}:

let 
  enable = config.may.features.desktop.enable && config.may.desktopShell == "plasma";
in {
  config = lib.mkIf enable {
    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

    # user-related setup
    system.activationScripts.createIcon = "ln -sfn ${../../../../assets/user-icon.png} /var/lib/AccountsService/icons/may";
  };
}