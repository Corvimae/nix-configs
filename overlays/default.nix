{ flake-parts-lib, ... }:

{
  flake.customOverlays = [
    ./mayUtils.nix
    ./pipewireUtils.nix
    ./hyprUtils.nix
  ] |> builtins.map(import);
}