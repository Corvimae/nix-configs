{ inputs, config, lib, ... }@args:

let
  cfg = (inputs.self.lib.withConfig args).may.profiles.darwin;
in
{  
  config = lib.mkIf cfg.enable {
    programs.zsh = {
      dotDir = config.home.homeDirectory;
    };
  };
}