_: {
  flake.nixosModules = {
    defaultConfig = import ./default-config;
    defaultUsers = import ./default-users.nix;
    services = import ./services;

    # Programs
    firefox = import ./programs/firefox;

    nixosPrograms = import ./programs/nixos-programs;

    # Homes
    home-may = import ./homes/may;
  };
}