{ inputs, config, lib, ... }:

let
  cfg = config.may.profiles.darwin;
in
{  
  config = lib.mkIf cfg.enable {
    programs.zsh = {
      dotDir = config.home.homeDirectory;
    };
  };
}