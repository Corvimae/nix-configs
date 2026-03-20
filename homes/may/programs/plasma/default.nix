{ inputs, ... }:

{
  imports = [
    ./panel.nix
  ];

  programs.plasma = {
    enable = true;
    workspace = {
      lookAndFeel = "Catppuccin-Latte-Lavender";
      splashScreen.theme = "org.kde.breeze.desktop";
      # wallpaper = "";
    };
    shortcuts = {
      kwin = {
        "Window Quick Tile Bottom" = "";
        "Window Quick Tile Left" = "";
        "Window Quick Tile Top" = "";
        "Window Quick Tile Right" = "";
      };
    };
    kwin = {
      titlebarButtons = {
        left = [
        ];
        right = [
          "minimize"
          "maximize"
          "close"
        ];
      };
    };
    spectacle.shortcuts.captureRectangularRegion = "Alt+Ctrl+$";
  };
}