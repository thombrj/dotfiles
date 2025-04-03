#!/usr/bin/env bash

downloadLocation="$HOME/Downloads"
location='/opt/neovim'

if [ ! -d $downloadLocation ]; then
    mkdir $downloadLocation
fi

if [ -d $location ]; then
    sudo rm -rf $location
fi

latest=$(curl -s -L -H 'Accept: application/json' https://github.com/neovim/neovim/releases/latest)
tag=$(jq -r -n '$LATEST | .tag_name')

wget "https://github.com/neovim/neovim/releases/download/$tag/nvim-linux-x86_64.tar.gz"
tar -xvzf nvim-linux-x86.tar.gz

mv nvim-linux-x86 /opt/neovim

