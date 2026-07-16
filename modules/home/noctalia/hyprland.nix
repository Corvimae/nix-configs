{ inputs, config, pkgs, lib, ... }: 

let 
  enable = config.may.features.desktop.enable && config.may.desktopShell == "noctalia";
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
in {
  config = lib.mkIf enable {
    programs.kitty.enable = true;

    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
      configType = "lua";

      plugins = with inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}; [
        # hyprbars 
      ];

      settings = {
        config = {
          general = {
            layout = "scrolling";
            gaps_in = 5;
            gaps_out = 10;
          };

          decoration = {
            rounding = 20;
            rounding_power = 2;
            shadow = {
              enabled = true;
              range = 4;
              render_power = 3;
              color = "0xee1a1a1a";
            };
            blur = {
              enabled = true;
              size = 3;
              passes = 2;
              vibrancy = 0.1696;
            };
          };
          
          # plugin = {
          #   hyprbars = {
          #     bar_height = 20;
          #     bar_padding = 10;
          #     bar_part_of_window = true;
          #     on_double_click = "hyprctl dispatch fullscreen 1";
          #   };
          # };
        };

        env = [
          {
            _args = [
              "HYPRCURSOR_THEME"
              "Future-Cyan-Hyprcursor_Theme"
            ];
          }
          {
            _args = [
              "HYPRCURSOR_SIZE"
              "32"
            ];
          }
        ];

        animation = [
          {
            _args = [{
              leaf = "workspaces";
              enabled = 1;
              speed = 5;
              bezier = "default";
              style = "slidevert";
            }];
          }
        ];

        bind = [
          (hyprBindExec {
            key = "T";
            cmd = "ghostty";
          })
          (hyprBind {
            key = "F";
            cmd = "hl.dsp.window.float({ action = \"toggle\" })";
          })
          (hyprBind {
            key = "Q";
            cmd = "hl.dsp.window.close()";
          })
          (hyprBind {
            key = "left";
            cmd = "hl.dsp.focus({ direction = \"left\" })";
          })
          (hyprBind {
            key = "right";
            cmd = "hl.dsp.focus({ direction = \"right\" })";
          })
          (hyprBind {
            key = "ALT + up";
            cmd = "hl.dsp.focus({ direction = \"up\" })";
          })
          (hyprBind {
            key = "ALT + down";
            cmd = "hl.dsp.focus({ direction = \"down\" })";
          })
          (hyprBind {
            key = "SHIFT + left";
            cmd = "hl.dsp.window.move({ direction = \"left\" })";
          })
          (hyprBind {
            key = "SHIFT + right";
            cmd = "hl.dsp.window.move({ direction = \"right\" })";
          })
          (hyprBind {
            key = "ALT + SHIFT + up";
            cmd = "hl.dsp.window.move({ direction = \"up\" })";
          })
          (hyprBind {
            key = "ALT + SHIFT + down";
            cmd = "hl.dsp.window.move({ direction = \"down\" })";
          })
          (hyprBind {
            key = "up";
            cmd = "hl.dsp.focus({ workspace = \"-1\" })";
          })
          (hyprBind {
            key = "down";
            cmd = "hl.dsp.focus({ workspace = \"+1\" })";
          })
          (hyprBind {
            key = "SHIFT + up";
            cmd = "hl.dsp.window.move({ workspace = \"-1\" })";
          })
          (hyprBind {
            key = "SHIFT + down";
            cmd = "hl.dsp.window.move({ workspace = \"+1\" })";
          })
          (hyprBind {
            key = "bracketleft";
            cmd = "hl.dsp.layout(\"colresize 0.5\")";
          })
          (hyprBind {
            key = "bracketright";
            cmd = "hl.dsp.layout(\"colresize 1.0\")";
          })
          (hyprBind {
            key = "equal";
            cmd = "hl.dsp.layout(\"colresize +0.1\")";
          })
          (hyprBind {
            key = "minus";
            cmd = "hl.dsp.layout(\"colresize -0.1\")";
          })
          (hyprBind {
            key = "mouse:272";
            cmd = "hl.dsp.window.drag()";
            opts = [{ mouse = true; }];
          })
          (hyprBind {
            key = "mouse:273";
            cmd = "hl.dsp.window.resize()";
            opts = [{ mouse = true; }];
          })
          (hyprBindNoctalia {
            key = "Space";
            cmd = "panel-toggle launcher";
          })
          (hyprBindNoctalia {
            key = "S";
            cmd = "panel-toggle control-center";
          })
          (hyprBindNoctalia {
            key = "XF86AudioRaiseVolume";
            cmd = "volume-up";
          })
          (hyprBindNoctalia {
            key = "XF86AudioLowerVolume";
            cmd = "volume-down";
          })
          
          (hyprBindNoctalia {
            key = "XF86AudioMute";
            cmd = "volume-mute";
          })
          
          (hyprBindNoctalia {
            key = "XF86MonBrightnessUp";
            cmd = "brightness-up";
          })
          
          (hyprBindNoctalia {
            key = "XF86MonBrightnessDown";
            cmd = "brightness-down";
          })
          (hyprBindNoctalia {
            key = "ALT + Tab";
            cmd = "window-switcher";
            noModKey = true;
          })
          (hyprBindNoctalia {
            key = "ALT + SHIFT + Tab";
            cmd = "window-switcher";
            noModKey = true;
          })
          
          # (hyprBindNoctalia {
          #   key = "comma";
          #   cmd ="panel-toggle settings-toggle";
          # })
        ] ++ ((lib.range 1 10) |> builtins.map(workspace: let
            mod = a : b: a - (b * (a / b));
            key = mod workspace 10;
            keyStr = builtins.toString(key);
            workspaceStr = builtins.toString(workspace);
          in [
            (hyprBind {
              key = keyStr;
              cmd = "hl.dsp.focus({ workspace = ${workspaceStr}})";
            })
            (hyprBind {
              key = "SHIFT + ${keyStr}";
              cmd = "hl.dsp.window.move({ workspace = ${workspaceStr}})";
            })
          ]
        ) |> lib.lists.flatten);

        window_rule = [
          # {
          #   match.fullscreen = false;
          #   float = true;
          # }
          {
            match.class = "dev.noctalia.Noctalia";
            float = true;
            size = [1080 920];
          }
          # {
          #   match.float = false;
          #   "hyprbars:enabled" = false;
          # }
        ];

        # "plugin.hyprbars.add_button" = [
        #   {
        #     _args = [
        #       {
        #         bg_color = "rgb(ff4040)";
        #         fg_color = "rgb(ffffff)";
        #         size = 10;
        #         icon = " ";
        #         action = "hyprctl dispatch killactive";
        #       }
        #     ];
        #   }
        #   {
        #     _args = [
        #       {
        #         bg_color = "rgb(eeee11)";
        #         fg_color = "rgb(000000)";
        #         size = 10;
        #         icon = " ";
        #         action = "hyprctl dispatch fullscreen 1";
        #       }
        #     ];
        #   }
        # ];

        layer_rule = [
          {
            name = "noctalia";
            match.namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd)$";
            no_anim = true;
            ignore_alpha = 0.5;
            blur = true;
            blur_popups = true;
          }
        ];
        
        on = {
          _args = [
            "hyprland.start"
            (lib.generators.mkLuaInline "function()\n  hl.exec_cmd(\"noctalia\")\nend")
          ];
        };
      };
      
      extraConfig = ''
        -- layout mode cycling
        hl.bind("SUPER + tab", function ()
          local layouts     = { "scrolling", "dwindle", "master", "monocle" }
          local workspace   = hl.get_active_workspace()
        if hl.get_active_special_workspace() then
          workspace = hl.get_active_special_workspace()
        end

          local next_layout = "dwindle"

          if not workspace then
              return
          end

          for i = 1, #layouts do
              if layouts[i] == workspace.tiled_layout then
                  local next_layout_idx = (i % #layouts) + 1
                  next_layout = layouts[next_layout_idx]
                  break
              end
          end

        if workspace.special then
          hl.workspace_rule({ workspace = tostring(workspace.name), layout = next_layout })
        else
          hl.workspace_rule({ workspace = tostring(workspace.id), layout = next_layout })
        end
      end)
      '';
    };

    home.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}