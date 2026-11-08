{ inputs, lib, config, pkgs, ...}:

let
  cfg = config.may.programs.obsidian;
in {
  config = lib.mkIf cfg.enable {
    programs.obsidian = {
      enable = true;

      defaultSettings = {
        communityPlugins = with pkgs.obsidianPlugins; [
          {
            pkg = obsidian-livesync;
            enable = true;
          }
        ];
      };
    };
  };
}