{ inputs, lib, config, ... }:

let
  cfg = config.may.services.sshAgent;
in {
  config.services.ssh-agent = lib.mkIf cfg.enable {
    inherit (cfg) enable;
  };
}