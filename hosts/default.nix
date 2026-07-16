{ inputs, lib, config, self, pkgs, ... }:
{
  easy-hosts = let
    homeManagerOpts = {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = "hm-backup";
      home-manager.extraSpecialArgs = { inherit inputs; };
      home-manager.sharedModules = [
        inputs.self.homeModules.plasma
        inputs.self.homeModules.noctalia
      ]; 
    };
  in {
    perClass = class: {
      modules = let
        sharedModules = [
          inputs.self.sharedModules.options
          inputs.self.sharedModules.programs
          inputs.self.sharedModules.services
        ];

        nixosModules = lib.optionals (class == "nixos") [
          inputs.home-manager.nixosModules.home-manager
          inputs.self.nixosModules.defaultConfig
          inputs.self.nixosModules.defaultUsers
          inputs.self.nixosModules.features
          inputs.self.nixosModules.services
          inputs.self.nixosModules.nixosPrograms
          inputs.self.nixosModules.firefox
          inputs.self.nixosModules.home-may
        ];

        darwinModules = lib.optionals (class == "darwin") [
          inputs.home-manager.darwinModules.home-manager
          inputs.self.darwinModules.defaultConfig
          inputs.self.darwinModules.programs
          inputs.self.darwinModules.home-may-darwin
        ];
      in sharedModules ++ nixosModules ++ darwinModules;
    };
    path = ./.;
    hosts = {
      magnezone = {
        arch = "x86_64";
        class = "nixos";
        modules = [
          inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
          homeManagerOpts
          {
            home-manager.useGlobalPkgs = true;
            home-manager.sharedModules = [];
          }
        ];
      };

      Archen = {
        arch = "aarch64";
        class = "darwin";
        modules = [
          homeManagerOpts
        ];
      };

      tinkaton = {
        arch = "x86_64";
        class = "nixos";
        modules = [
          inputs.archix.nixosModules.default
          homeManagerOpts
          {
            home-manager.useGlobalPkgs = true;
          }
        ];
      };
    };
  };
}