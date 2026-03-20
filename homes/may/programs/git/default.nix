{ config, lib, pkgs, ...}:

{
  programs.git = {
    enable = true;
    settings = {
      pull.rebase = false;
      init.defaultBranch = "main";
      user = {
        email = "may@maybreak.com";
        name = "Corvimae";
      };
    };
  };
}