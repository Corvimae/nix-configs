{ inputs, flake-parts-lib, ... }:

{
  flake.homeModules = {
    options = import ./options.nix;
    programs = import ./programs;
    services = import ./services;
    profiles = import ./profiles;
    plasma = import ./plasma;
    xdg = import ./xdg.nix;
    sharedHomeModules = flake-parts-lib.importApply ./shared-home-modules.nix { inherit inputs; };
  };
}