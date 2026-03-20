_: {
  flake.nixosModules = {
    defaultConfig = import ./default-config;
    profiles = import ./profiles;

    # Programs
    firefox = import ./programs/firefox;

    otherPrograms = import ./programs/other;

    # Homes
    home-may = import ./homes/may;
  };
}