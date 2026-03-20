{ inputs, ... }:

{
  nixpkgs = {
    overlays = [];
    config.allowUnfree = true;
  };
}