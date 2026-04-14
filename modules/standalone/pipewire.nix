{ inputs, pkgs, config, ... }:

{
  services.pipewire = {
    enable = true;
    configs = {
      "05-virtual-cables" = {
        "context.objects" = with pkgs.pipewireUtils; [
          (buildSink "chatot-out-pc-1" "Chatot Out - PC 1")
          (buildSink "chatot-out-pc-2" "Chatot Out - PC 2")
          (buildSink "chatot-out-obs-monitor" "Chatot Out - OBS Monitoring")
          (buildSink "chatot-out-discord" "Chatot Out - Discord")
          (buildSource "chatot-in-mac" "Chatot In - Mic")
          (buildSource "chatot-in-stream-mix" "Chatot In - Stream Mix")
          (buildSource "chatot-in-vod-ignored" "Chatot In - VOD Ignored")
        ];
      };
      # not sure if these quantum overrides are still necessary, but they don't
      # seem to cause issues.
      "13-discord-override" = {
        "node.rules" = with pkgs.pipewireUtils; [
          (forceQuantumRule "RecordStream" 1024)
          (forceQuantumRule "Chromium" 1024)
        ];
      };
      "14-quantum-overrides" = {
        "node.rules" = with pkgs.pipewireUtils; [
          (forceQuantumRule "OBS" 2048)
          (forceQuantumRule "Firefox" 2048)
        ];
      };
      "15-application-specific-routing" = {
        "node.rules" = with pkgs.pipewireUtils; [
          (addApplicationRoute "Firefox" "chatot-out-pc-2")
          (addApplicationRoute "Chromium" "chatot-out-discord")
        ];
      };
      "16-chatot-links" = {
        "context.exec" = [
          {
            path = "/home/may/.config/pipewire-scripts/create-links.sh";
            args = "";
          }
        ];
      };
    };
  };

  home.file = {
    "${config.xdg.configHome}/pipewire-scripts/create-links.sh" = {
      source = ./files/pipewire-scripts/create-links.sh;
      executable = true;
    };
  };
}