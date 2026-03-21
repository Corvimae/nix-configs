{ inputs, lib, config, pkgs, ...}:

let
  cfg = config.may.programs.git;
in {
  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.git];

    programs.git = {
      inherit (cfg) enable;
      settings = {
        pull.rebase = false;
        init.defaultBranch = "main";
        user = {
          email = "may@maybreak.com";
          name = "Corvimae";
        };
      };
    };
  };
}