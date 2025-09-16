#!/usr/bin/env bash

set -euo pipefail

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" >&2
}

# Check if running on macOS
if [[ "$(sw_vers -productName 2>/dev/null || echo "Unknown")" != "macOS" ]]; then
    log "Error: This script is designed for macOS only."
    exit 1
fi

log "Starting dotfiles setup..."

# Disable accented characters popup when holding down a key
log "Disabling accented characters popup..."
defaults write -g ApplePressAndHoldEnabled -bool false

# Adjust key repeat speed
log "Adjusting key repeat speed..."
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 30

# Install CLI devtools if not already installed
if ! xcode-select -p >/dev/null 2>&1; then
    log "Installing Xcode CLI tools..."
    xcode-select --install
    # Wait for installation to complete (user interaction required)
    log "Please complete Xcode CLI tools installation and press Enter to continue..."
    read -r
else
    log "Xcode CLI tools already installed."
fi

# Set up Homebrew if not installed
if ! command -v brew >/dev/null 2>&1; then
    log "Installing Homebrew..."
    /bin/bash -c "$(curl --fail -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add Homebrew to PATH for this session
    eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
else
    log "Homebrew already installed."
fi

# Install mas if not present
if ! brew list mas >/dev/null 2>&1; then
    log "Installing mas (Mac App Store CLI)..."
    brew install mas
else
    log "mas already installed."
fi

# Install dependencies from Brewfile
log "Installing dependencies from Brewfile..."
brew bundle install

# Backup existing ~/.config if it exists
if [ -d ~/.config ]; then
    backup_dir="${HOME}/.config.backup.$(date +%Y%m%d_%H%M%S)"
    log "Backing up existing ~/.config to ${backup_dir}..."
    cp -r ~/.config "${backup_dir}"
fi

# Create necessary directories
log "Creating config directories..."
mkdir -p ~/.config/fish

# Function to create symlink safely
create_symlink() {
    local source="${1%/}"  # Remove trailing slash
    local target="${2%/}"  # Remove trailing slash
    if [ -L "$target" ]; then
        log "Symlink already exists: $target"
    elif [ -e "$target" ]; then
        log "Warning: $target exists but is not a symlink. Skipping."
    else
        log "Creating symlink: $target -> $source"
        ln -s "$source" "$target"
    fi
}

# Set up symlinks
log "Setting up symlinks..."
create_symlink "$PWD/ccache/" ~/.config/ccache/
create_symlink "$PWD/fastfetch/" ~/.config/fastfetch/
create_symlink "$PWD/fish/config.fish" ~/.config/fish/config.fish
create_symlink "$PWD/gh/" ~/.config/gh/
create_symlink "$PWD/ghostty/" ~/.config/ghostty/
create_symlink "$PWD/git/" ~/.config/git/
create_symlink "$PWD/nvim/" ~/.config/nvim/
create_symlink "$PWD/opencode/" ~/.config/opencode/
create_symlink "$PWD/starship/" ~/.config/starship/
create_symlink "$PWD/tmux/" ~/.config/tmux/

# Set up shell color scripts
log "Setting up shell color scripts..."
temp_dir=$(mktemp -d)
git clone https://gitlab.com/dwt1/shell-color-scripts.git "$temp_dir"
cd "$temp_dir"
sudo make install
fish_completions_dir="/opt/homebrew/share/fish/vendor_completions.d"
sudo mkdir -p "$fish_completions_dir"
sudo cp completions/colorscript.fish "$fish_completions_dir"
cd -
rm -rf "$temp_dir"

log "Dotfiles setup completed successfully!"
