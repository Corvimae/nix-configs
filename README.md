# corvimae's nix zone

nixos config for a laptop i'm playing around with as well as my main macbook. do not perceive.

much of this is based on [pyrox's setup](https://git.pyrox.dev/pyrox/nix). thank you for knowing what you are doing!

in order to get this to work with both nixos and nix-darwin i have done some nonsense!! there's definitely a 
better way!

there's also a config for a cachyos desktop in here. that one's really jank but i wanted to be able to configure plasma on both nixos and cachyos the same way. suprisingly, it works.

wallpapers commissioned from [yogcavey](https://yogcavey.crd.co/).

## systems defined

- `Archen` - macbook pro using nix as its package manager. not fully managed.
- `magnezone` - framework 13 managed via nixos.
- `duosion` - cachyos desktop using the home-manager configs defined here for ✨consistency✨.
- `tinkaton` - nixos server that hosts a personal aur build repo.

## things that you still have to do manually
- simlink this into `/etc/nixos` (if you're not using `deploy-rs`):
  ```bash
  # edit the hostname in configuration.nix first to match the new host and run
  # sudo nixos-rebuild switch. you will regret it if you do not do this.
  sudo rm -rf /etc/nixos # make sure to copy and import hardware-configuration.nix first!!!!
  ln -sT /path/to/this/repo /etc/nixos
  ```
- set up certain programs + services:
  - vesktop: everything
  - bitwarden firefox extension: log in + show autofill suggestions on form fields
  - tailscale: add the new device as described [here](https://nixos.wiki/wiki/Tailscale).
