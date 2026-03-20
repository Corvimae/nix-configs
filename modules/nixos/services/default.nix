{ lib, ... }:

{
  imports = [
    ./desktop-services.nix
    ./other-services.nix
  ];
}