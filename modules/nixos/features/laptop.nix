{ inputs, config, pkgs, lib, ... }:

let
  cfg = config.may.features.laptop;
in
{  
  config = lib.mkIf cfg.enable {
    powerManagement.enable = true;
    
    # the fingerprint reader on the framework 13 is horrible
    services.fprintd.enable = false;
  };
}