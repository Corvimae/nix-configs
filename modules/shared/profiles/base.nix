{ config, lib, ... }:

let
  cfg = config.may.profiles.base;
in
{  
  options.may.profiles.base = {
    enable = lib.mkEnableOption "Base Profile";
  };

  options.may.profiles.darwin = {
    enable = lib.mkEnableOption "Darwin Profile";
  };
}