# needs to be defined on the nixos level to avoid
# having to define the options twice.
{
  # these are used to generate options and that's basically it.
  # not everything is relevant for every os.
  programs = {
    # managed programs have custom configs
    managed = [
      "git"
      "steam"
      "ghostty"
      "firefox"
      "thunderbird"
      "vscode"
    ];

    # unmanged programs just get dumped into environment.systemPackages
    unmanaged = [
      "vesktop"
      "slack"
      "yt-dlp"
      "doctl"
    ];
  };

  services = [
    "sshAgent"
  ];
}