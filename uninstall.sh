#!/bin/bash

# Remove installed directories
sudo rm -rf $HOME/Dev/ $HOME/dotfiles $HOME/.config

# Remove brew and everything it installed
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
chmod +x ./uninstall
./uninstall

rm uninstall
