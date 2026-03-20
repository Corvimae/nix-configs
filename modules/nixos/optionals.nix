# needs to be defined on the nixos level to avoid
# having to define the options twice.
{
  programs = [
    "git"
    "steam"
    "ghostty"
    "vesktop"
    "slack"
    "thunderbird"
    "vscode"
  ];

  services = [
    "sshAgent"
  ];
}