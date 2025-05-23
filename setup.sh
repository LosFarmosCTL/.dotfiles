#!/usr/bin/env bash

# disable accented characters popup when holding down a key
defaults write -g ApplePressAndHoldEnabled 0

# adjust key repeat speed
defaults write -g KeyRepeat 1
defaults write -g InitialKeyRepeat 30

# install CLI devtools
xcode-select --install

# set up homebrew and install dependencies
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle install

# set up symlinks
mkdir ~/.config
mkdir ~/.config/fish

ln -s $PWD/ccache/ ~/.config/ccache/
ln -s $PWD/fastfetch/ ~/.config/fastfetch/
ln -s $PWD/fish/config.fish ~/.config/fish/config.fish
ln -s $PWD/gh/ ~/.config/gh/
ln -s $PWD/ghostty/ ~/.config/ghostty/
ln -s $PWD/git/ ~/.config/git/
ln -s $PWD/nvim/ ~/.config/nvim/
ln -s $PWD/starship/ ~/.config/starship/
ln -s $PWD/tmux/ ~/.config/tmux/

# set up terminal colorscripts
git clone https://gitlab.com/dwt1/shell-color-scripts.git && cd shell-color-scripts
sudo make install

sudo cp completions/colorscript.fish /usr/share/fish/vendor_completions.d
