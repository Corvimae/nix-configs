{ inputs, lib, config, self, pkgs, ... }:
{
  easy-hosts = let
    homeManagerOpts = {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = "hm-backup";
      home-manager.extraSpecialArgs = { inherit inputs; }; 
    };
  in {
    perClass = class: {
      modules = let
        sharedModules = [
          inputs.self.sharedModules.options
          inputs.self.sharedModules.programs
          inputs.self.sharedModules.services
          inputs.self.sharedModules.profiles
        ];

        nixosModules = lib.optionals (class == "nixos") [
          inputs.home-manager.nixosModules.home-manager
          inputs.self.nixosModules.defaultConfig
          inputs.self.nixosModules.defaultUsers
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
            home-manager.sharedModules = [
              inputs.plasma-manager.homeModules.plasma-manager
              inputs.self.homeModules.plasma
            ];
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
    };
  };
}