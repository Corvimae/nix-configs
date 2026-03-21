{ inputs, lib, config, ... }:

let
  cfg = config.may.profiles.base;
in
{  
  config = lib.mkIf cfg.enable {
    home = {
      stateVersion = "26.05";
      language = {
        base = "en_US.utf8";
      };
      preferXdgDirectories = true;
    };

    systemd.user.startServices = "sd-switch";
  };
}