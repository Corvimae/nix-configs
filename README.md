# corvimae's nix zone

nixos config for a laptop i'm playing around with as well as my main macbook. do not perceive.

much of this is based on [pyrox's setup](https://git.pyrox.dev/pyrox/nix). thank you for knowing what you are doing!

in order to get this to work with both nixos and nix-darwin i have done some nonsense!! there's definitely a 
better way!

there's also a config for a cachyos desktop in here. that one's really jank but i wanted to be able to configure plasma on both nixos and cachyos the same way. suprisingly, it works.

## things that you still have to do manually
- simlink this into `/etc/nixos`.
- set up certain programs + services:
  - vesktop: everything
  - bitwarden firefox extension: log in + show autofill suggestions on form fields
  - tailscale: add the new device as described [here](https://nixos.wiki/wiki/Tailscale).
