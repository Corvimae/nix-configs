{ self, config, lib, ... }:

{
  options.may.services = lib.pipe self.optionals.services [
    (builtins.map(name: {
      inherit name;
      value = self.lib.mkServiceOption name; # todo: camelcase?
    }))
    (builtins.listToAttrs)
  ];
}