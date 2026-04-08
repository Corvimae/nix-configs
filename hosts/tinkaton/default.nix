{ self', inputs, pkgs, ... }:

{
  imports = [
    ./bootloader.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "tinkaton";

  may = pkgs.mayUtils.loadConfig "tinkaton" ../../config.toml;

  environment.systemPackages = with pkgs; [
    paru
    inputs.archix.packages.x86_64-linux.devtools
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

  # self-reference the may-aur db
  programs.pacman.conf.extraConfig = ''
    [may-aur]
    SigLevel = Optional TrustAll
    Server = file:///opt/arch-repo/aur-db/os/$arch
  '';
}
