{ inputs, config, lib, pkgs, ... }:

let
  enable = pkgs.mayUtils.isDesktopShell "noctalia" config;
in {
  config = lib.mkIf enable {
    programs.noctalia.settings = {
      dock.monitors = [ "DP-2" ];
    };
  }
}