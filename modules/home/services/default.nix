{ inputs, lib, nixosConfig, ... }:

let
  cfg = nixosConfig.may.services.sshAgent;
in {
  config.services.ssh-agent = lib.mkIf cfg.enable {
    inherit (cfg) enable;
  };
}