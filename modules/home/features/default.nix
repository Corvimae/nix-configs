{
  # DO NOT ENABLE PROGRAMS, PACKAGES, FEATURES, OR SERVICES
  # IN FEATURE MODULES

  # Add those definitions to a new feature in config.toml
  # so that home-manager and the OS-level config are both
  # aware of the requirements!

  # Use feature modules for configuration, not for installation.
  imports = [
    ./home.nix
    ./darwin.nix
  ];
}