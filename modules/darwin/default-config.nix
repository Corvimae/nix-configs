{ lib, inputs, ... }:

{
  imports = [];

  security.pam.services.sudo_local.touchIdAuth = true;

  system.stateVersion = 6;

  # Very annoying that you need to redefine this here :(
  nixpkgs.overlays = [
    inputs.self.overlays.mayUtils
     # my packages
    (final: prev: { may = inputs.self.packages.${prev.system}; })  
  ];
}