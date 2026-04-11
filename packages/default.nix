{
  perSystem = { pkgs, lib, ... }: let
    packages = lib.packagesFromDirectoryRecursive {
      inherit (pkgs) callPackage;
      directory = ./custom;
    };

    isAvailablePackage = pkg: let
      isDerivation = lib.isDerivation pkg;
      availableOnHost = lib.meta.availableOn pkgs.stdenv.hostPlatform pkg;
      isBroken = pkg.meta.broken or false;
    in isDerivation && !isBroken && availableOnHost; 
  in {
    legacyPackages = packages;
    packages = lib.filterAttrs (_: isAvailablePackage) packages;
  };
}