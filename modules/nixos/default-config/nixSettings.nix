{ inputs, ... }:

{
  nixpkgs = {
    overlays = [
      inputs.nix-firefox-addons.overlays.default
      inputs.nix-vscode-extensions.overlays.default
      inputs.self.overlays.mayUtils
      (final: prev: { may = inputs.self.packages.${prev.system}; })
    ];
    config.allowUnfree = true;
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