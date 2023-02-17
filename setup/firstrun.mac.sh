#!/usr/bin/env bash

xcode-select --install

sudo softwareupdate --install-rosetta


git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2 || return 1
source "$HOME/.asdf/asdf.sh"
echo 'source "$HOME/.asdf/asdf.sh"' >> ~/.zprofile

asdf plugin add nodejs
asdf install nodejs latest
asdf global nodejs latest

npm install -g @devcontainers/cli

chezmoi init git@github.com:adrienthebo/dotfiles
