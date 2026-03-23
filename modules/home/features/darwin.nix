{ inputs, config, pkgs, lib, ... }:

let
  enable = config.may.class == "darwin";
in
{  
  config = lib.mkIf enable {
    programs.zsh = {
      dotDir = config.home.homeDirectory;
    };
  };
}