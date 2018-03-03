#!/bin/bash

cd ~

# Install Brew + cmd line apps
echo "Installing Homebrew...."
usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo "Installing brew apps..."
brew install neovim ack tree ctags fish python python3 tmux tree golang glide-golang dep node

# Install dotfiles; neovim config requires python/python3 installation, so this is all done
# after brew app installations
echo "Creating .config directories...."
mkdir -p ~/.config/fish
mkdir -p ~/.config/nvim
echo "Cloning dotfiles..."
git clone git:github.com/chriswalker/dotfiles.git
echo "Running dotfiles install script..."
~/dotfiles/install.zsh
echo "Downloading vim-plug..."
curl -fLo ~/dotfiles/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "Installing neovim plugins..."
nvim -c "PlugInstall | qa"
nvim -c "GoInstallBinaries | qa"

# Set up Dev workspace
echo "Setting up Dev workspace..."
mkdir -p ~/Dev/Applications
mkdir -p ~/Dev/tmp
mkdir -p ~/Dev/data
mkdir -p ~/Dev/Projects
mkdir -p ~/Dev/Projects/Go/src
mkdir -p ~/Dev/Projects/Go/bin
mkdir -p ~/Dev/Projects/Go/pkg
mkdir -p ~Dev/Projects/Work

# Install golang stuff
echo "Installing go packages..."
# For work
go get -u github.com/golang/protobuf/{proto,protoc-gen-go}
go get -u github/com/micro/protoc-gen-micro
go get -u github.com/chrusty/protoc-gen-jsonschema
go get -u github.com/karhoo/openapi2proto
go get -u github.com/maxbrunsfeld/counterfeiter

# General
go get -u github.com/TrueFurby/go-callvis
