#!/bin/bash

# Install dotfiles
cd ~
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

# Install Brew + cmd line apps
echo "Installing Homebrew...."
usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo "Installing brew apps..."
brew install neovim ack tree ctags fish python python3 tmux tree golang glide-golang

# Set up Dev workspace
mkdir -p ~/Dev/Applications
mkdir -p ~/Dev/tmp
mkdir -p ~/Dev/data
mkdir -p ~/Dev/Projects
mkdir -p ~/Dev/Projects/Go/src
mkdir -p ~/Dev/Projects/Go/bin
mkdir -p ~/Dev/Projects/Go/pkg
mkdir -p ~Dev/Projects/Work

# Install golang stuff
echo "Installing go packages"
# dep
#micro/proto
#micro/protoc-gen-go
#openapi2proto (Karhoo fork)
#openapi2jsonschema (chrusty)
