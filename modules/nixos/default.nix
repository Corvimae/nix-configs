_: {
  flake.nixosModules = {
    defaultConfig = import ./default-config;
    defaultUsers = import ./default-users.nix;
    profiles = import ./profiles;
    services = import ./services;

    # Programs
    firefox = import ./programs/firefox;

    otherPrograms = import ./programs/other;

    # Homes
    home-may = import ./homes/may;
  };

  # Pre-defined lists
  flake.optionals = import ./optionals.nix;
}