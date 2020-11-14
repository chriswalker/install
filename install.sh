#!/bin/bash

cd $HOME

#
# Software installable via apt
#

# Package signing + repo for Tailscale
curl https://pkgs.tailscale.com/stable/raspbian/buster.gpg | sudo apt-key add -
curl https://pkgs.tailscale.com/stable/raspbian/buster.list | sudo tee /etc/apt/sources.list.d/tailscale.list
# Podman, Buildah and Skopeo
curl https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/Raspbian_10/Release.key | sudo apt-key add -
echo 'deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/Raspbian_10/ /' | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list

# Install required software
sudo apt update
sudo apt install kakoune tmux ripgrep fd bat jq apt-transport-https tailscale podman buildah skopeo

# Start stuff up
sudo tailscale up

# Shut things down - running Pis headless, and don't care about a bunch
# of systemd services as a result. Stopping these decreases boot time.
sudo systemctl stop bluetooth avahi-daemon triggerhappy hciuart

echo "Done!"


