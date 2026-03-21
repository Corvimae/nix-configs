{ self', lib, pkgs, ... }:

{
  imports = [];

  # dunno why it wants this so badly
  users.users.may-darwin.home = "/Users/may";

  environment.systemPackages = with pkgs; [
    sshpass
    ffmpeg_7
  ];

  may = {
    profiles = {
      base.enable = true;
      developer.enable = true;
      darwin.enable = true;
    };

    # i hate home-manager
    programs = {
      git.enable = true;
      doctl.enable = true;
      asdf-vm.enable = true;
      yt-dlp.enable = true;
    };
  };
}