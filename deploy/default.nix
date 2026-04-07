{ inputs, self, deploy-rs, ... }: 

{
  flake.deploy.nodes = let
    mkDeployment = hostname: {
      inherit hostname;
      
      # sshOpts = ["-p" "2221"];
      fastConnection = true;
      interactiveSudo = true;
      remoteBuild = true;
      profiles = {
        system = {
          sshUser = "may";
          path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos inputs.self.nixosConfigurations.${hostname};
          user = "root";
        };
      };
    };
  in {
    tinkaton = mkDeployment "tinkaton";
  };

  flake.checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) inputs.deploy-rs.lib;
}