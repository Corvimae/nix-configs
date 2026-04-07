#!/usr/bin/env bash

pushd /home/may/aur
yay -G $1
pushd $1
nix run "github:SamLukeYes/archix#devtools" -- build
mkdir -r /opt/arch-repo/aur-db/os/x86_64
repo-add /opt/arch-repo/aur-db/os/x86_64/repo.db.tar.zst *.pkg.tar.zst
popd
popd