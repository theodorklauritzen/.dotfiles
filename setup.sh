#!/bin/bash

ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.zprofile ~/.zprofile
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.ssh/config ~/.ssh/config
ln -s ~/.dotfiles/.config/nvim/ ~/.config/nvim/
ln -s ~/.dotfiles/starship.toml ~/.config/starship.toml

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install starship
curl -sS https://starship.rs/install.sh | sh

brew bundle --file ~/.dotfiles/Brewfile

# For macOS
# Longer screenshot time
# defaults write com.apple.screencaptureui thumbnailExpiration -float 30.0
