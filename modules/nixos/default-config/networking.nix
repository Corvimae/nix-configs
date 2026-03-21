{ lib, configs, ...}:

{
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  # use iwd because the defaults causes horrible lockups.
  networking.wireless.iwd = {
    enable = true;
    settings = {
      IPv6.Enabled = true;
      Settings.AutoConnect = true;
    };
  };

  # Disable *-wait-online services as they block rebuilds often.
  # https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services = {
    NetworkManager-wait-online.enable = lib.mkForce false;
    systemd-networkd-wait-online.enable = lib.mkForce false;
  };
}