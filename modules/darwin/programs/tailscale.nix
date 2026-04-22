{ inputs, lib, config, pkgs, ... }:

let
  cfg = config.may.programs.tailscale;
in {
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (tailscale-gui.overrideAttrs (oldAttrs: rec {
        version = "1.96.5";
        src = pkgs.fetchurl {
          url = "https://pkgs.tailscale.com/stable/Tailscale-${version}-macos.pkg";
          hash = "sha256-eqwNX5uBGOiy1z91eMMkE6892ot+eXlM5/6jHm9uF8g=";
        };
      }))
    ];
  };
}
