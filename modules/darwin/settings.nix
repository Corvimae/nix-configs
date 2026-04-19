{
  system.defaults = {
    ".GlobalPreferences" = {
      "com.apple.mouse.scaling" = -1.0; # Disable mouse acceleration
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
      "com.apple.swipescrolldirection" = false; # Disable natural scrolling
    };
    
    finder = {
      FXPreferredViewStyle = "clmv"; # Default to column view
    };

    # Additional options that are not yet explicitly defined in nix-darwin
    CustomUserPreferences = {
      NSGlobalDomain = {
        NSGlassDiffusionSetting = 0; # Enable Liquid Glass reduced transparency
      };
    };
  };
}