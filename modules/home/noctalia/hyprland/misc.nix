{ inputs, pkgs, lib, config, ... }:

let
  enable = pkgs.mayUtils.isDesktopShell "noctalia" config;
in {
  config = lib.mkIf enable {
    wayland.windowManager.hyprland = {
      settings = {
        on = {
          _args = [
            "hyprland.start"
            (lib.generators.mkLuaInline "function()\n  hl.exec_cmd(\"noctalia\")\nend")
          ];
        };
      };

      extraLuaFiles = {
        "layoutSwitching.lua" = {
          content = ./lua/layoutSwitching.lua;
          autoLoad = true;
        };
      };

      # Load monitors.lua as generated from monique if it is present
      extraConfig = ''
        function loadrequire(module)
            local function requiref(module)
                require(module)
            end
            res = pcall(requiref,module)
            if not(res) then
                -- Do Stuff when no module
            end
        end
        loadrequire('monitors')
      '';
    };
  };
}