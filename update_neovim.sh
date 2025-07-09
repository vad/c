#!/bin/bash

# Exit on any error
set -e

# Define colors
GREEN='\033[0;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔍 Fetching latest Neovim release info...${NC}"
LATEST_JSON=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest)

LATEST_VERSION=$(echo "$LATEST_JSON" | jq -r .tag_name)
CURRENT_VERSION=$(nvim --version | head -1 | cut -d " " -f 2)

echo -e "${YELLOW}🔎 Current version: ${CURRENT_VERSION}${NC}"
echo -e "${YELLOW}📦 Latest version:  ${LATEST_VERSION}${NC}"

if [[ $LATEST_VERSION == $CURRENT_VERSION ]]; then
    echo -e "${GREEN}✅ Neovim is already up to date! 🎉${NC}"
    exit 0
fi

# Extract the download URL for the nvim-linux-x86_64.appimage
DOWNLOAD_URL=$(echo "$LATEST_JSON" | jq -r '.assets[] | select(.name == "nvim-linux-x86_64.appimage") | .browser_download_url')

if [ -z "$DOWNLOAD_URL" ]; then
  echo -e "${RED}❌ Error: Could not find AppImage download URL.${NC}"
  exit 1
fi

echo -e "${BLUE}⬇️  Downloading Neovim AppImage...${NC}"
curl -L "$DOWNLOAD_URL" -o nvim.appimage

echo -e "${BLUE}📦 Installing Neovim to /usr/local/bin/nvim...${NC}"
sudo mv nvim.appimage /usr/local/bin/nvim

echo -e "${BLUE}🔧 Setting executable permissions...${NC}"
sudo chmod 755 /usr/local/bin/nvim

echo -e "${GREEN}🎉 Neovim ${LATEST_VERSION} installed successfully!${NC}"
echo -e "${GREEN}💡 Run 'nvim --version' to verify.${NC}"
