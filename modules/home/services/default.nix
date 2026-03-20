{ lib, config, ... }:

let
  cfg = config.may.services.sshAgent;
in {
  options.may.services.sshAgent = lib.mkServiceOption "ssh-agent";

  config.services.ssh-agent = lib.mkIf cfg.enable {
    inherit (cfg) enable;
  };
}