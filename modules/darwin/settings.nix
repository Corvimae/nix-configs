{
  system.defaults = {
    ".GlobalPreferences" = {
      "com.apple.mouse.scaling" = -1.0; # Disable mouse acceleration
    };

    dock = {
      show-recents = false;
    };

    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      NSTableViewDefaultSizeMode = 2; # Medium sidebar icons
      NSDocumentSaveNewDocumentsToCloud = false; # Don't default saving to iCloud
      "com.apple.keyboard.fnState" = true; # Treat fn keys as fn keys
      NSAutomaticPeriodSubstitutionEnabled = false; # Disable double space to add period
      NSAutomaticCapitalizationEnabled = false; # Disable automatic capitalization
      NSAutomaticSpellingCorrectionEnabled = false; # Disable automatic spelling correction
      ApplePressAndHoldEnabled = false; # Repeat letters on press-and-hold
      NSNavPanelExpandedStateForSaveMode = true; # Expand save panel by default
      NSNavPanelExpandedStateForSaveMode2 = true; # Twice, for some reason.
      "com.apple.swipescrolldirection" = false; # Disable natural scrolling
    };
    
    finder = {
      FXPreferredViewStyle = "clmv"; # Default to column view
      FXDefaultSearchScope = "SCcf"; # Search current folder by default
      FXEnableExtensionChangeWarning = false; # Disable file extension change warning
      ShowPathbar = true;
    };

    # Additional options that are not yet explicitly defined in nix-darwin
    CustomUserPreferences = {
      NSGlobalDomain = {
        NSGlassDiffusionSetting = 0; # Enable Liquid Glass reduced transparency
      };
    };
  };
}