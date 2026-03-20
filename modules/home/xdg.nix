{ config, lib, pkgs, ... }:

let 
  homeDirectory = config.home.homeDirectory;
  profiles = config.may.profiles;
in {
  xdg = {
    enable = true;
    configHome = lib.mkForce "${homeDirectory}/.config";
    dataHome = lib.mkForce "${homeDirectory}/.local/share";
    
    portal = {
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

    mimeApps = lib.mkIf profiles.desktop.enable {
      inherit (profiles.desktop) enable;

      associations.added = {
        "application/pdf" = ["firefox.desktop"];
        "application/xml" = ["firefox.desktop"];
        "image/webp" = ["gwenview.desktop"];
      };

      defaultApplications = {
        "application/pdf" = ["firefox.desktop"];
        "application/xml" = ["firefox.desktop"];
        "image/webp" = ["gwenview.desktop"];
      };
    };
  };
}