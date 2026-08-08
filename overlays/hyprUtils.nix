final: prev: {
  hyprUtils = let
    lib = prev.lib;
  in rec {
    modKey = "SUPER";
    
    hyprBind = { key, cmd, ... }@args: {
      _args = [
        (if (args.noModKey or false) then key else "${modKey} + ${key}")
        (lib.generators.mkLuaInline cmd)
      ] ++ (args.opts or []);
    };

    hyprBindExec = { cmd, ... }@args: hyprBind (args // {
      cmd = "hl.dsp.exec_cmd(\"${cmd}\")";
    });

    hyprBindNoctalia = { cmd, ... }@args: hyprBindExec(args // {
      cmd = "noctalia msg ${cmd}";
    });

    mkHyprBind = args: {
      cmd = hyprBind;
      exec = hyprBindExec;
      noctalia = hyprBindNoctalia;
    }.${args.type or "cmd"} args;

    mkCenterFloatRule = { match, pctSize, ... }@rules: (builtins.removeAttrs rules ["pctSize"]) // {
      float = true;
      center = true;
      size = [
        "monitor_w * ${lib.strings.floatToString(pctSize.x)}"
        "monitor_h * ${lib.strings.floatToString(pctSize.y)}"
      ];
    };

    mkEnv = { key, value }: {
      _args = [key value];
    };
  };
}