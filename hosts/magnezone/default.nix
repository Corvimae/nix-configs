{ self', ... }:

{
  imports = [
    ./bootloader.nix
    ./hardware-configuration.nix
  ];

  may = {
    profiles.gui.enable = true;

    programs = {
      git.enable = true;
      vesktop.enable = true;
    };

    services = {
      sshAgent.enable = true;
    };
  };
}