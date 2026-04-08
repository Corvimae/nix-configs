#!/usr/bin/env bash set -e

pushd /home/may/aur
yay -G $1
pushd $1
# nix run "github:SamLukeYes/archix#devtools" -- build
paru -B . --chroot
repo-add /opt/arch-repo/aur-db/os/x86_64/may-aur.db.tar.zst *.pkg.tar.zst
cp *.pkg.tar.zst /opt/arch-repo/aur-db/os/x86_64
popd
popd