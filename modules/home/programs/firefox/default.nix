{ inputs, config, lib, pkgs, ... }:

let
  cfg = config.may.programs.firefox;
  personal = config.may.personal;
in {
  config = lib.mkIf cfg.enable {
    programs.firefox = {
      inherit (cfg) enable;
      
      configPath = if config.may.class == "darwin"
        then "${config.home.homeDirectory}/Library/Application Support/Firefox/"
        else "${config.xdg.configHome}/mozilla/firefox";

      profiles.may = {
        id = 0;
        name = "May";
        extensions = lib.mkDefault {
          packages = (pkgs.mayUtils.mkConditionalList (
            with pkgs.firefoxAddons; [
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
          ));
        };
        search = import ./search.nix { inherit pkgs; };
        settings = import ./preferences.nix;
      };
    };
  };
}