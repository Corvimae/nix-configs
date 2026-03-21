_: {
  flake.sharedModules = {
    profiles = import ./profiles;
    services = import ./services;
    programs = import ./programs;
  };

  # Pre-defined lists
  flake.optionals = import ./optionals.nix;
}