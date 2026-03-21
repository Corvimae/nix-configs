# needs to be defined on the nixos level to avoid
# having to define the options twice.
{
  # these are used to generate options. if they're enabled,
  # they're installed (system-wide on darwin).
  # not everything is relevant for every os.
  programs = [
    "git"
    "steam"
    "ghostty"
    "firefox"
    "thunderbird"
    "vscode"
    "vesktop"
    "slack"
    "yt-dlp"
    "doctl"
    "asdf-vm"
  ];

  services = [
    "sshAgent"
  ];

  profiles = [
    "base"
    "developer"
    "desktop"
    "gui"
    "darwin"
  ];
}