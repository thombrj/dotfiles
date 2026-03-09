#!/usr/bin/env bash

set -e

rpms=(
    awk
    bat
    dotnet-sdk-8.0
    dotnet-sdk-9.0
    dotnet-sdk-10.0
    fzf
    git
    gnome-keyring
    hostname
    jq
    keychain
    neovim
    podman
    stow
    tmux
    zsh
)

sudo dnf install -y $rpms

sudo dnf copr enable -y dejan/lazygit
sudo dnf install -y lazygit

if ! copilot -v > /dev/null &> /dev/null; then
  echo "installing copilot cli.."
  curl -fsSL https://gh.io/copilot-install | bash
else
  echo "Copilot cli is installed."
fi

dotnet tool install --global dotnet-outdated-tool
dotnet tool install --global dotnet-ef
