{
  description = "may's cool nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
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
  };

  outputs = {
    self,
    nixpkgs, 
    home-manager,
    ...
  }@inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        inputs.firefox-addons.overlays.default
      ];
      config.allowUnfree = true;
    };
  in {
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    overlays = import ./overlays { inherit inputs; };
     
    nixosConfigurations.magnezone = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
        inputs.home-manager.nixosModules.default
        {
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.sharedModules = [
            inputs.plasma-manager.homeModules.plasma-manager
          ];
          home-manager.users.may = import ./homes/may.nix;
          home-manager.extraSpecialArgs = { inherit inputs pkgs; }; 
        }
      ];
    };

    # homeConfigurations = {
    #   "may@magnezone" = home-manager.lib.homeManagerConfiguration {
    #     inherit pkgs;
    #     extraSpecialArgs = { inherit inputs; };
    #     modules = [
    #       ./homes/may.nix
    #     ];
    #   };
    # };
  };
}