{ pkgs, lib, config, ... }:

let
  cfg = config.may.programs.iterm;
  preferenceFile = "${config.home.homeDirectory}/Library/Preferences/com.googlecode.iterm2.plist";
in {
  config = lib.mkIf cfg.enable {
    # To update the plist, convert it from binary to xml with:
    #   plutil -convert xml1 ~/Library/Preferences/com.googlecode.iterm2.plist
    # iTerm does seem to accept xml-formatted plists, though, so you don't need to convert it back.
    home.file = {
      "${preferenceFile}.link" = {
        source = ./iterm2.plist;
        # This is really jank, but the file needs to be writable or else iterm will fail.
        # Could possibly solve this with mkOutOfStoreSymlink, but I'd rather it not write back
        # to here unless I manually update it.
        # Definitely worried this is going to fall really out of sync and break stuff in the future :/
        onChange = ''
          cat ${preferenceFile}.link > ${preferenceFile}
          rm ${preferenceFile}.link
          chmod 600 ${preferenceFile}
        '';
      };
    };
  };
}