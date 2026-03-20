{ inputs, flake-parts-lib, ... }:

{
  flake.homeModules = {
    programs = import ./programs;
    services = import ./services;
    profiles = import ./profiles;
    xdg = import ./xdg.nix;
    allHomeModules = flake-parts-lib.importApply ./all-home-modules.nix { inherit inputs; };
  };
}