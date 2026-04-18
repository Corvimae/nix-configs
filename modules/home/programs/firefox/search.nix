{ pkgs, ... }:

# on mac, if you make changes to this, you need to run:
# rm /Users/may/Library/Application\ Support/Firefox/Profiles/may/search.json.mozlz4.hm-backup
#
# really annoying!
{
  engines = {
    ddg = {
      name = "DuckDuckGo";
      urls = [{
        template = "https://duckduckgo.com/";
        params = [
          { name = "q"; value = "{searchTerms}"; }
        ];
      }];

    };
    nix-packages = {
      name = "Nix Packages";
      urls = [{
        template = "https://search.nixos.org/packages";
        params = [
          { name = "type"; value = "packages"; }
          { name = "query"; value = "{searchTerms}"; }
        ];
      }];

      icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      definedAliases = [ "@np" ];
    };
  };
  default = "ddg";
  order = [
    "ddg"
    "nix-packages"
  ];
}