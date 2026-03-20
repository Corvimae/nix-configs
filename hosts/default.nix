{ inputs, config, self, pkgs, ... }:
{
  easy-hosts = let
    homeManagerOpts = {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = "hm-backup";
      home-manager.extraSpecialArgs = { inherit inputs; }; 
    };
  in {
    shared = {
      modules = [
        inputs.home-manager.nixosModules.home-manager
        inputs.self.nixosModules.defaultConfig
        inputs.self.nixosModules.defaultUsers
        inputs.self.nixosModules.profiles
        inputs.self.nixosModules.services
        inputs.self.nixosModules.firefox
        inputs.self.nixosModules.otherPrograms
        inputs.self.nixosModules.home-may
      ];
    };
    path = ./.;
    hosts = {
      magnezone = {
        modules = [
          inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
          homeManagerOpts
          {
            home-manager.useGlobalPkgs = true;
            home-manager.sharedModules = [
              inputs.plasma-manager.homeModules.plasma-manager
            ];
          }
        ];
      };
    };
  };
}