_: {
  flake.homeModules = {
    programs = import ./programs;
    services = import ./services;
    profiles = import ./profiles;
  };
}