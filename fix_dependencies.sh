#!/usr/bin/env bash

set -e

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Detect OS
OS="$(uname -s)"

echo "Detected OS: $OS"

install_with_apt() {
    sudo apt update
    sudo apt install -y ffmpeg yt-dlp
}

install_with_dnf() {
    sudo dnf install -y ffmpeg yt-dlp
}

install_with_pacman() {
    sudo pacman -Sy --noconfirm ffmpeg yt-dlp
}

install_with_brew() {
    brew install ffmpeg yt-dlp
}

install_linux() {
    if command_exists apt; then
        echo "Using apt package manager"
        install_with_apt
    elif command_exists dnf; then
        echo "Using dnf package manager"
        install_with_dnf
    elif command_exists pacman; then
        echo "Using pacman package manager"
        install_with_pacman
    else
        echo "Unsupported Linux distribution. Please install ffmpeg and yt-dlp manually."
        exit 1
    fi
}

install_macos() {
    if ! command_exists brew; then
        echo "Homebrew not found. Please install Homebrew first:"
        echo "https://brew.sh/"
        exit 1
    fi
    install_with_brew
}

# Check and install ffmpeg
if command_exists ffmpeg; then
    echo "ffmpeg is already installed."
else
    echo "ffmpeg is not installed. Installing..."
    if [[ "$OS" == "Linux" ]]; then
        install_linux
    elif [[ "$OS" == "Darwin" ]]; then
        install_macos
    fi
fi

# Check and install yt-dlp
if command_exists yt-dlp; then
    echo "yt-dlp is already installed."
else
    echo "yt-dlp is not installed. Installing..."
    if [[ "$OS" == "Linux" ]]; then
        install_linux
    elif [[ "$OS" == "Darwin" ]]; then
        install_macos
    fi
fi

echo "Done."
