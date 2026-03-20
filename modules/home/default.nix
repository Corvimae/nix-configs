{ inputs, flake-parts-lib, ... }:

{
  flake.homeModules = {
    programs = import ./programs;
    services = import ./services;
    profiles = import ./profiles;
    allHomeModules = flake-parts-lib.importApply ./all-home-modules.nix { inherit inputs; };
  };
}