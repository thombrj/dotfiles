#!/usr/bin/env bash

mkdir -p $HOME/.local/bin

ln -s '/mnt/c/Users/bt10634/AppData/Local/Programs/Zed/bin/zed' $HOME/.local/bin/zed
ln -s '/mnt/c/Program Files/Microsoft VS Code/bin/code' $HOME/.local/bin/code
ln -s '/mnt/c/Windows/explorer.exe' $HOME/.local/bin/explorer

sudo systemctl restart systemd-binfmt
