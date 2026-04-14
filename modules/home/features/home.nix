{ inputs, pkgs, lib, config, osConfig, ... }:

let
  enable = osConfig.may.homeConfig;
in {  
  config = lib.mkIf enable {
    home = {
      # kind of annoying but it works
      stateVersion = if osConfig.may.class == "darwin"
        then "26.05"
        else "25.11";

      language = {
        base = "en_US.utf8";
      };

      preferXdgDirectories = true;
    };

    systemd.user.startServices = "sd-switch";

    # pull all the options into home-manager config as well.
    may = pkgs.mayUtils.loadConfig osConfig.may.hostname ../../../config.toml;
  };
}