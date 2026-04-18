{ lib, inputs, ... }:

{
  imports = [];

  security.pam.services.sudo_local.touchIdAuth = true;

  system.stateVersion = 6;

  nixpkgs = {
    config.allowUnfree = true;

    # Very annoying that you need to redefine this here :(
    overlays = [
      inputs.self.overlays.mayUtils
      inputs.firefox-addons.overlays.default
      # my packages
      (final: prev: { may = inputs.self.packages.${prev.system}; })  
    ];
  };
}