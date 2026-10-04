{ inputs, pkgs, lib, config, ... }:

let
  enable = pkgs.mayUtils.isDesktopShell "noctalia" config;
in {
  config = lib.mkIf enable {
    home.packages = with pkgs; [
      hyprland-preview-share-picker
    ];

    # not currently working, doesn't display windows for some reason
    # wayland.windowManager.hyprland.xdph = {
    #   settings.screencopy.custom_picker_binary = ${pkgs.hyprland-preview-share-picker}/bin/hyprland-preview-share-picker;
    # };

    home.file = {
      "${config.xdg.configHome}/hyprland-preview-share-picker/config.yaml" = {
        text = lib.generators.toYAML { } {
          stylesheets = [ "./style.css" ];
        };
      };
      "${config.xdg.configHome}/hyprland-preview-share-picker/style.css" = {
        source = ./share-picker/style.css;
      };
    };
  };
} 