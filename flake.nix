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

    nix-firefox-addons = {
      url = "github:osipog/nix-firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    archix = {
      url = "github:SamLukeYes/archix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    monique.url = "github:ToRvaLDz/monique";

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs"; 
    };

    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    scopebuddy = {
      url = "github:HikariKnight/ScopeBuddy";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
        ./packages
        ./deploy
        ./hosts
        ./modules/shared
        ./modules/nixos
        ./modules/darwin
        ./modules/home
        ./modules/standalone
        ./overlays
      ];

      flake.allOverlays = [
        inputs.nix-firefox-addons.overlays.default
        inputs.nix-vscode-extensions.overlays.default
        # my packages
        (final: prev: { may = inputs.self.packages.${prev.system}; })
      ] ++ inputs.self.customOverlays;

      perSystem = { system, ... }: {
        _module.args.pkgs = import nixpkgs {
          inherit system;
          # If you're adding overlays and they're being used in shared or nix-darwin modules,
          # you need to add the overlay in modules/darwin/default-config.nix and
          # modules/nixos/default-config/nixSettings.nix as well.
          overlays = inputs.self.allOverlays;
          config.allowUnfree = true;
        };
      };
    };
}