{ inputs, ... }:

{
  nixpkgs = {
    overlays = inputs.self.allOverlays;
    config.allowUnfree = true;

    # attempt to remove this when whatever is still using 40.10.5 updates
    config.permittedInsecurePackages = [];
  };

  nix.optimise.automatic = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];

    trusted-users = [
      "root"
      "may"
      "@wheel"
    ];
  };
}