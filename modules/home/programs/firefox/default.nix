{ inputs, config, lib, pkgs, ... }:

let
  cfg = config.may.programs.firefox;
  personal = config.may.personal;
in {
  config = lib.mkIf cfg.enable {
    programs.firefox = {
      inherit (cfg) enable;
      
      profiles.may = {
        id = 0;
        name = "May";
        extensions = lib.mkDefault {
          packages = pkgs.mayUtils.mkConditionalList (
            with pkgs.firefox-addons; [
              { value = ublock-origin; }
              { value = bitwarden-password-manager; }
              { value = xkit-rewritten; }
              { value = indie-wiki-buddy; }
              { value = youtube-suite-search-fixer; }
              { value = istilldontcareaboutcookies; }

              # twitch stuff
              {
                value = gumbo-twitch-companion;
                enabled = personal;
              }
              {
                value = frankerfacez;
                enabled = personal;
              }
            ]
          );
        };
        search = import ./search.nix { inherit pkgs; };
        settings = import ./preferences.nix;
      };
    };
  };
}