{ lib, config, ... }:

let
  serviceCfg = config.may.services;
in {
  services.openssh.enable = true;
  services.tailscale.enable = true;

  services.nginx = lib.mkIf serviceCfg.nginx.enable {
    enable = true;
  };
}
