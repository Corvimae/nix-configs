{ inputs, lib, ... }@args:

let
  cfg = (inputs.self.lib.withConfig args).may.services.sshAgent;
in {
  config.services.ssh-agent = lib.mkIf cfg.enable {
    inherit (cfg) enable;
  };
}