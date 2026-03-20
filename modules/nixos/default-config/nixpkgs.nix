{ inputs, ... }:

{
  nixpkgs = {
    overlays = [
      inputs.self.overlays.lib
    ];
    config.allowUnfree = true;
  };
}