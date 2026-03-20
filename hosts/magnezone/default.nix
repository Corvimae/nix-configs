{ self', ... }:

{
  imports = [
    ./bootloader.nix
    ./hardware-configuration.nix
  ];

  may = {
    profiles.desktop.enable = true;
    programs = {
      firefox.enable = true;
      vscode.enable = true;
      plasma.enable = true;
      git.enable = true;
      ghostty.enable = true;
      vesktop.enable = true;
      slack.enable = true;
      thunderbird.enable = true;
    };

    services = {
      sshAgent.enable = true;
    };
  };
}