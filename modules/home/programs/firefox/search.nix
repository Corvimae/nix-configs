{ pkgs, ... }:

{
  force = true;
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
          { name = "channel"; value = "unstable"; }
          { name = "query"; value = "{searchTerms}"; }
        ];
      }];

      icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
      definedAliases = ["@np"];
    };
    arch = {
      name = "Arch Packages";
      urls = [{
        template = "https://archlinux.org/packages";
        params = [
          { name = "q"; value = "{searchTerms}"; }
        ];
      }];

      definedAliases = ["@arch"];
    };
    aur = {
      name = "Arch User Repository";
      urls = [{
        template = "https://aur.archlinux.org/packages";
        params = [
          { name = "K"; value = "{searchTerms}"; }
        ];
      }];

      definedAliases = ["@aur"];
    };
  };
  default = "ddg";
  order = [
    "ddg"
    "nix-packages"
  ];
}