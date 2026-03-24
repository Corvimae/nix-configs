{ inputs, config, pkgs, lib, ... }:

let
  cfg = config.may.features.laptop;
in
{  
  config = lib.mkIf cfg.enable {
    powerManagement.enable = true;
    
    services.fprintd.enable = true;
  };
}