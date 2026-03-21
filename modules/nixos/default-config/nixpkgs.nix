{ inputs, ... }:

{
  nixpkgs = {
    overlays = [
      inputs.firefox-addons.overlays.default
      inputs.self.overlays.mayUtils
    ];
    config.allowUnfree = true;
  };
}