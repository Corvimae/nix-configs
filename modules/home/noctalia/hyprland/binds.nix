{ inputs, pkgs, lib, config, ... }:

let
  enable = pkgs.mayUtils.isDesktopShell "noctalia" config;
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
  toHyprBind = args: {
    cmd = hyprBind;
    exec = hyprBindExec;
    noctalia = hyprBindNoctalia;
  }.${args.type or "cmd"} args;
in {
  config = lib.mkIf enable {
    wayland.windowManager.hyprland.settings.bind = let
      workspaceBinds = ((lib.range 1 10) |> builtins.map(workspace: let
        mod = a : b: a - (b * (a / b));
        key = mod workspace 10;
        keyStr = builtins.toString(key);
        workspaceStr = builtins.toString(workspace);
      in [
        {
          key = keyStr;
          cmd = "hl.dsp.focus({ workspace = ${workspaceStr}})";
        }
        {
          key = "SHIFT + ${keyStr}";
          cmd = "hl.dsp.window.move({ workspace = ${workspaceStr}})";
        }
      ]
    ) |> lib.lists.flatten);
    in workspaceBinds ++ [
      # Exec binds 
      {
        type = "exec";
        key = "T";
        cmd = "ghostty";
      }
      {
        type = "exec";
        key = "ALT + SHIFT + 4";
        cmd = "grim -g \\\"$(slurp -d)\\\" - | satty -f - --copy-command wl-copy -o \\\"~/Pictures/Screenshots/%Y%m%d_%H%M%S.png\\\"";
        noModKey = true;
      }
      {
        type = "exec";
        key = "ALT + CTRL + SHIFT + 4";
        cmd = "grim -g \\\"$(slurp -d)\\\" - | wl-copy";
        noModKey = true;
      }

      # Other Hyprland calls
      {
        key = "F";
        cmd = "hl.dsp.window.float({ action = \"toggle\" })";
      }
      {
        key = "Q";
        cmd = "hl.dsp.window.close()";
      }
      {
        key = "j";
        cmd = "hl.dsp.focus({ direction = \"left\" })";
      }
      {
        key = "l";
        cmd = "hl.dsp.focus({ direction = \"right\" })";
      }
      {
        key = "ALT + i";
        cmd = "hl.dsp.focus({ direction = \"up\" })";
      }
      {
        key = "ALT + k";
        cmd = "hl.dsp.focus({ direction = \"down\" })";
      }
      {
        key = "SHIFT + j";
        cmd = "hl.dsp.window.move({ direction = \"left\" })";
      }
      {
        key = "SHIFT + l";
        cmd = "hl.dsp.window.move({ direction = \"right\" })";
      }
      {
        key = "ALT + SHIFT + i";
        cmd = "hl.dsp.window.move({ direction = \"up\" })";
      }
      {
        key = "ALT + SHIFT + k";
        cmd = "hl.dsp.window.move({ direction = \"down\" })";
      }
      {
        key = "i";
        cmd = "hl.dsp.focus({ workspace = \"-1\" })";
      }
      {
        key = "k";
        cmd = "hl.dsp.focus({ workspace = \"+1\" })";
      }
      {
        key = "SHIFT + i";
        cmd = "hl.dsp.window.move({ workspace = \"-1\" })";
      }
      {
        key = "SHIFT + k";
        cmd = "hl.dsp.window.move({ workspace = \"+1\" })";
      }
      {
        key = "bracketleft";
        cmd = "hl.dsp.layout(\"colresize 0.5\")";
      }
      {
        key = "bracketright";
        cmd = "hl.dsp.layout(\"colresize 1.0\")";
      }
      {
        key = "equal";
        cmd = "hl.dsp.layout(\"colresize +0.1\")";
      }
      {
        key = "minus";
        cmd = "hl.dsp.layout(\"colresize -0.1\")";
      }
      {
        key = "mouse:272";
        cmd = "hl.dsp.window.drag()";
        opts = [{ mouse = true; }];
      }
      {
        key = "mouse:273";
        cmd = "hl.dsp.window.resize()";
        opts = [{ mouse = true; }];
      }

      # Noctalia msg commands
      {
        key = "Space";
        cmd = "panel-toggle launcher";
        type = "noctalia";
      }
      {
        key = "S";
        cmd = "panel-toggle control-center";
        type = "noctalia";
      }
      {
        key = "XF86AudioRaiseVolume";
        cmd = "volume-up";
        type = "noctalia";
      }
      {
        key = "XF86AudioLowerVolume";
        cmd = "volume-down";
        type = "noctalia";
      }
      {
        key = "XF86AudioMute";
        cmd = "volume-mute";
        type = "noctalia";
      }
      {
        key = "XF86MonBrightnessUp";
        cmd = "brightness-up";
        type = "noctalia";
      }
      {
        key = "XF86MonBrightnessDown";
        cmd = "brightness-down";
        type = "noctalia";
      }
      {
        key = "ALT + Tab";
        cmd = "window-switcher";
        noModKey = true;
        type = "noctalia";
      }
      {
        key = "ALT + SHIFT + Tab";
        cmd = "window-switcher";
        noModKey = true;
        type = "noctalia";
      }
    ] |> builtins.map(toHyprBind);
  };
}