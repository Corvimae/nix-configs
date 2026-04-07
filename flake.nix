{
  description = "may's cool nixos config";

  nixConfig = {
    experimental-features = "nix-command flakes pipe-operators";
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    
    flake-parts.url = "github:hercules-ci/flake-parts";
    easy-hosts.url = "github:tgirlcloud/easy-hosts";
    deploy-rs.url = "github:serokell/deploy-rs";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    firefox-addons = {
      url = "github:petrkozorezov/firefox-addons-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    archix.url = "github:SamLukeYes/archix";
  };

  outputs = {
    self,
    nixpkgs, 
    home-manager,
    flake-parts,
    ...
  }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      imports = [
        inputs.easy-hosts.flakeModule
        inputs.home-manager.flakeModules.home-manager
        ./deploy
        ./hosts
        ./modules/shared
        ./modules/nixos
        ./modules/darwin
        ./modules/home
        ./modules/standalone
        ./overlays
      ];

      perSystem = { system, ... }: {
        _module.args.pkgs = import nixpkgs {
          inherit system;
          # If you're adding overlays and they're being used in shared or nix-darwin modules,
          # you need to add the overlay in modules/darwin/default-config.nix as well.
          overlays = [
            inputs.firefox-addons.overlays.default
            inputs.self.overlays.mayUtils
          ];
          config.allowUnfree = true;
        };
      };
    };
}