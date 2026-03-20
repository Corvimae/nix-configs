{ self', ... }:

{
  imports = [
    ./bootloader.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "magnezone";

  may = {
    profiles = {
      gui.enable = true;
      desktop.enable = true;
    };

    programs = {
      git.enable = true;
      vesktop.enable = true;
    };

    services = {
      sshAgent.enable = true;
    };
  };
}