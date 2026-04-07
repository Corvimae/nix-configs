{ self', pkgs, ... }:

{
  imports = [
    ./bootloader.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "tinkaton";

  may = pkgs.mayUtils.loadConfig "tinkaton" ../../config.toml;

  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "build-aur" (builtins.readFile ./scripts/build-aur.sh))
  ];

  systemd.tmpfiles.rules = [
    "d /opt/arch-repo/aur-db/os/x86_64 1777 may users"
  ];

  services.nginx.virtualHosts."tinkaton.maybreak.net" = {
    root = "/opt/arch-repo";
    extraConfig = ''
      autoindex on;
    '';
  };
}
