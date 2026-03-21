{ inputs, lib, ... }:

{
  # Generate the options here so that they can all
  # be referenced within home manager. This has
  # to happen at the system level as well becuase
  # home manager configs are a nightmare.
  options.may = inputs.self.lib.defineOptions inputs.self.optionals;
}