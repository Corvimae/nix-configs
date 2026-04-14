final: prev: {
  pipewireUtils = let
    lib = prev.lib;
  in rec {
    buildSink = name: description: {
      factory = "adapter";
      args = {
        "factory.name" = "support.null-audio-sink";
        "node.name" = name;
        "node.description" = description;
        "media.class" = "Audio/Sink";
        "object.linger" = true;
        "audio.position" = ["L" "R"];
        "monitor.channel-volumes" = true;
        "monitor.passthrough" = true;
      };
    };

    buildSource = name: description: {
      factory = "adapter";
      args = {
        "factory.name" = "support.null-audio-sink";
        "node.name" = name;
        "node.description" = description;
        "media.class" = "Audio/Source/Virtual";
        "object.linger" = true;
        "audio.position" = ["L" "R"];
        "monitor.channel-volumes" = true;
        "monitor.passthrough" = true;
      };
    };

    matchContaining = name: "~.*${name}.*";

    forceQuantumRule = applicationName: quantum: {
      matches = [{ "application.name" = (matchContaining applicationName); }];
      actions.update-props = {
        "node.force-quantum" = quantum;
      };
    };

    addApplicationRoute = applicationName: sinkName: {
      matches = [{ "application.name" = (matchContaining applicationName); }];
      actions.update-props = {
        "target.object" = sinkName;
      };
    };
  };
}