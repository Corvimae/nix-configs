{ inputs, ... }:

{
  nixpkgs = {
    overlays = [
      inputs.firefox-addons.overlays.default
    ];
    config.allowUnfree = true;
  };
}