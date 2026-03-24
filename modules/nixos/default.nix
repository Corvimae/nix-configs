_: {
  flake.nixosModules = {
    defaultConfig = import ./default-config;
    defaultUsers = import ./default-users.nix;
    services = import ./services;
    features = import ./features;

    # Programs
    firefox = import ./programs/firefox;

    nixosPrograms = import ./programs/nixos-programs.nix;

    # Homes
    home-may = import ./homes/may;
  };
}