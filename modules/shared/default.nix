_: {
  flake.sharedModules = {
    options = import ./options.nix;
    services = import ./services;
    programs = import ./programs;
  };
}