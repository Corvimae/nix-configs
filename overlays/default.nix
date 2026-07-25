{
  flake.overlays = {
    mayUtils = import ./mayUtils.nix;
    pipewireUtils = import ./pipewireUtils.nix;
    hyprUtils = import ./hyprUtils.nix;
  };
}