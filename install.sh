#!/bin/bash

cd $HOME

# Set up Dev workspace
echo "Setting up Dev workspace..."
mkdir -p $HOME/Dev/Applications
mkdir -p $HOME/Dev/tmp
mkdir -p $HOME/Dev/data
mkdir -p $HOME/Dev/Projects
mkdir -p $HOME/Dev/Projects/Go/src
mkdir -p $HOME/Dev/Projects/Go/bin
mkdir -p $HOME/Dev/Projects/Go/pkg
mkdir -p $HOME/Dev/Projects/Work

# Temporarily set $GOPATH to avoid brew setting up default Golang workspaces
export GOPATH=$HOME/Dev/Projects/Go
echo "Setting up temporary GOPATH to $GOPATH..."

# Install Brew + cmd line apps
echo "Installing Homebrew...."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo "Installing brew apps..."
brew install neovim ack tree ctags fish python python3 tmux tree golang glide dep node jq tig

# Install Python support for Neovim
echo "Installing Python support for Neovim..."
sudo pip3 install neovim

# Install dotfiles; neovim config requires python/python3 installation, so this is all done
# after brew app installations
echo "Creating .config directories...."
mkdir -p $HOME/.config/fish
mkdir -p $HOME/.config/nvim
echo "Cloning dotfiles..."
git clone git@github.com:chriswalker/dotfiles.git
echo "Running dotfiles install script..."
$HOME/dotfiles/install.zsh
echo "Downloading vim-plug..."
curl -fLo $HOME/dotfiles/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "Installing neovim plugins..."
nvim +PlugInstall +UpdateRemotePlugins +qa!
nvim +GoInstallBinaries +qa!


# Install golang stuff
echo "Installing go packages..."
# For work
go get -u github.com/golang/protobuf/{proto,protoc-gen-go}
go get -u github.com/micro/protoc-gen-micro
go get -u github.com/chrusty/protoc-gen-jsonschema
go get -u github.com/karhoo/openapi2proto
go get -u github.com/maxbrunsfeld/counterfeiter

# General
go get -u github.com/TrueFurby/go-callvis
