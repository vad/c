#!/bin/bash

# Exit on any error
set -e

# Fetch the latest release info from GitHub API
echo "Fetching latest Neovim release info..."
LATEST_JSON=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest)

LATEST_VERSION=$(echo "$LATEST_JSON" | jq -r .tag_name)
CURRENT_VERSION=$(nvim --version | head -1 | cut -d " " -f 2)

if [[ $LATEST_VERSION == $CURRENT_VERSION ]]; then
    echo "Neovim is up to date, exiting"
    exit 0
fi

# Extract the download URL for the nvim-linux-x86_64.appimage
DOWNLOAD_URL=$(echo "$LATEST_JSON" | jq -r '.assets[] | select(.name == "nvim-linux-x86_64.appimage") | .browser_download_url')

if [ -z "$DOWNLOAD_URL" ]; then
  echo "Error: Could not find AppImage download URL."
  exit 1
fi

# Download the AppImage to a temporary file
echo "Downloading Neovim AppImage from $DOWNLOAD_URL..."
curl -L "$DOWNLOAD_URL" -o nvim.appimage

# Move it to /usr/local/bin/nvim
echo "Installing Neovim to /usr/local/bin/nvim..."
sudo mv nvim.appimage /usr/local/bin/nvim

# Make it executable
echo "Setting executable permissions..."
sudo chmod 755 /usr/local/bin/nvim

echo "Neovim installation complete! Run 'nvim --version' to verify."
