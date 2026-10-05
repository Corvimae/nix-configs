{ inputs, lib, config, pkgs, ...}:

let
  cfg = config.may.programs.obs;
in {
  config = lib.mkIf cfg.enable {
    programs.obs-studio.enable = true;
    programs.obs-studio.plugins = with pkgs.obs-studio-plugins; [
      wlrobs # Wayland capture
      obs-pipewire-audio-capture # Pipewire audio capture
      obs-vaapi # AMD hardware acceleration
      obs-vkcapture # Vulkan game capture
      obs-livesplit-one # Livesplit One
    ];
  };
}