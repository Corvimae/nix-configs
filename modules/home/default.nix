{ inputs, flake-parts-lib, ... }:

{
  flake.homeModules = {
    programs = import ./programs;
    services = import ./services;
    profiles = import ./profiles;
    plasma = import ./plasma;
    xdg = import ./xdg.nix;
    sharedHomeModules = flake-parts-lib.importApply ./shared-home-modules.nix { inherit inputs; };
  };
}