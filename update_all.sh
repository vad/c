#!/bin/bash

# Exit on any error
set -e

# Define colors
GREEN='\033[0;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Fetch latest release info from GitHub
# Usage: fetch_github_release <owner/repo>
# Sets: LATEST_VERSION, LATEST_JSON
fetch_github_release() {
    local repo=$1
    echo -e "${BLUE}🔍 Fetching latest release info from ${repo}...${NC}"
    LATEST_JSON=$(curl -s "https://api.github.com/repos/${repo}/releases/latest")
    LATEST_VERSION=$(echo "$LATEST_JSON" | jq -r .tag_name)
}

# Get download URL for a specific asset
# Usage: get_asset_url <asset_name_pattern>
get_asset_url() {
    local pattern=$1
    echo "$LATEST_JSON" | jq -r ".assets[] | select(.name == \"${pattern}\") | .browser_download_url"
}

# Compare versions and print status
# Usage: check_version <current> <latest>
# Returns: 0 if update needed, 1 if already up to date
check_version() {
    local current=$1
    local latest=$2
    echo -e "${YELLOW}🔎 Current version: ${current}${NC}"
    echo -e "${YELLOW}📦 Latest version:  ${latest}${NC}"

    if [[ "$latest" == "$current" || "$latest" == "v$current" ]]; then
        echo -e "${GREEN}✅ Already up to date!${NC}"
        return 1
    fi
    return 0
}

update_neovim() {
    echo -e "${BLUE}=== Updating Neovim ===${NC}"
    fetch_github_release "neovim/neovim"

    local current_version=$(nvim --version | head -1 | cut -d " " -f 2)

    if ! check_version "$current_version" "$LATEST_VERSION"; then
        return 0
    fi

    local download_url=$(get_asset_url "nvim-linux-x86_64.appimage")

    if [ -z "$download_url" ]; then
        echo -e "${RED}❌ Error: Could not find AppImage download URL.${NC}"
        return 1
    fi

    echo -e "${BLUE}⬇️  Downloading Neovim AppImage...${NC}"
    curl -L "$download_url" -o /tmp/nvim.appimage

    echo -e "${BLUE}📦 Installing Neovim to /usr/local/bin/nvim...${NC}"
    sudo mv /tmp/nvim.appimage /usr/local/bin/nvim
    sudo chmod 755 /usr/local/bin/nvim

    echo -e "${GREEN}🎉 Neovim ${LATEST_VERSION} installed successfully!${NC}"
}

update_feishin() {
    echo -e "${BLUE}=== Updating Feishin ===${NC}"
    fetch_github_release "jeffvli/feishin"

    local current_version=$(dpkg-query -W -f='${Version}' feishin 2>/dev/null || echo "not installed")

    if ! check_version "$current_version" "$LATEST_VERSION"; then
        return 0
    fi

    local download_url=$(get_asset_url "Feishin-linux-amd64.deb")

    if [ -z "$download_url" ]; then
        echo -e "${RED}❌ Error: Could not find .deb download URL.${NC}"
        return 1
    fi

    echo -e "${BLUE}⬇️  Downloading Feishin .deb...${NC}"
    curl -L "$download_url" -o /tmp/feishin.deb

    echo -e "${BLUE}📦 Installing Feishin...${NC}"
    sudo dpkg -i /tmp/feishin.deb
    rm /tmp/feishin.deb

    echo -e "${GREEN}🎉 Feishin ${LATEST_VERSION} installed successfully!${NC}"
}

update_uv() {
    echo -e "${BLUE}=== Updating uv ===${NC}"
    uv self update
}

update_claude() {
    echo -e "${BLUE}=== Updating Claude ===${NC}"
    /home/vad/.local/bin/claude update
}

# Run all updates
update_neovim
update_feishin
update_uv
#omz update
update_claude

echo -e "${GREEN}=== All updates completed! ===${NC}"
