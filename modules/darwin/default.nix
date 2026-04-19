_: {
  flake.darwinModules = {
    defaultConfig = import ./default-config.nix;
    programs = import ./programs;

    # Homes
    home-may-darwin = import ./homes/may-darwin;
  };
}