{ inputs, ... }:
{
  imports = [
    inputs.self.homeModules.programs
    inputs.self.homeModules.services
    inputs.self.homeModules.profiles
    inputs.self.homeModules.xdg
  ];
}