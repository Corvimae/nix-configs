{ config, self, lib, pkgs, ... }@args:

let 
  homeDirectory = config.home.homeDirectory;
  desktopCfg = config.may.features.desktop;
in {
  xdg = {
    enable = true;
    configHome = lib.mkForce "${homeDirectory}/.config";
    dataHome = lib.mkForce "${homeDirectory}/.local/share";
    
    portal = lib.mkIf desktopCfg.enable {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [
        pkgs.kdePackages.xdg-desktop-portal-kde
      ];
      config = {
        common = {
          default = [ "kde" ];
        };
      };
    };

    # todo: this is causing home-manager service to not restart.
    # mimeApps = lib.mkIf features.gui.enable {
    #   inherit (features.gui) enable;

    #   associations.added = {
    #     "application/pdf" = ["firefox.desktop"];
    #     "application/xml" = ["firefox.desktop"];
    #     "image/webp" = ["gwenview.desktop"];
    #   };

    #   defaultApplications = {
    #     "application/pdf" = ["firefox.desktop"];
    #     "application/xml" = ["firefox.desktop"];
    #     "image/webp" = ["gwenview.desktop"];
    #   };
    # };
  };
}