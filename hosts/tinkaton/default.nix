{ self', inputs, pkgs, ... }:

{
  imports = [
    ./bootloader.nix
    ./hardware-configuration.nix
  ];

  # One-time manual setup: run mkarchroot /opt/build/chroot/root base-devel
  # TODO: Make this a script that checks for that folder and makes the chroot
  # if its not present

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
  programs.pacman = {
    conf.extraConfig = ''
      [may-aur]
      SigLevel = Optional TrustAll
      Server = file:///opt/arch-repo/aur-db/os/$arch
    '';

    makepkg.conf.source = ./files/makepkg.conf;
  };

  system.activationScripts = {
    setupChrootConfs.text = ''
      cp /etc/makepkg.conf /opt/build/chroot/root/etc/makepkg.conf
      cp /etc/pacman.conf /opt/build/chroot/root/etc/pacman.conf
      cp /etc/pacman.d/extra.conf /opt/build/chroot/root/etc/pacman.d/extra.conf
    '';
  };

}
