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


#
# Move into new $HOME
# 
echo "Setting up Dev workspace..."
mkdir -p $HOME/Dev/{data,tmp}
mkdir -p $HOME/Dev/Projects/Go
mkdir -p $HOME/Dev/Go/{bin,pkg,src}

# Install dotfiles
echo "Cloning dotfiles..."
git clone git@github.com:chriswalker/dotfiles.git
echo "Creating .config directory..."
mkdir -p $HOME/.config/
echo "Running dotfiles install script..."
$HOME/dotfiles/install.zsh
# echo "Downloading vim-plug..."
mkdir -p $HOME/dotfiles/kak/plugins
git clone git@github.com:robertmeta/plug.kak $HOME/dotfiles/kak/plugins
# echo "Installing Kakoune plugins..."
# nvim +PlugInstall +UpdateRemotePlugins +qa!
# nvim +GoInstallBinaries +qa!

