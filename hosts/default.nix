{ inputs, pkgs, ... }:
{
  easy-hosts = let
    homeManagerOpts = {
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = "backup";
      home-manager.sharedModules = [
        inputs.plasma-manager.homeModules.plasma-manager
      ];
      # home-manager.extraSpecialArgs = { inherit inputs; }; 
    };
  in {
    shared = {
      modules = [
        inputs.home-manager.nixosModules.default
      ];
    };
    path = ./.;
    hosts = {
      magnezone = {
        modules = [
          inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
          inputs.self.nixosModules.home-may
          ({} // homeManagerOpts)
        ];
      };
    };
  };
}