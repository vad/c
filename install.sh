#!/usr/bin/env sh

ln -s -i $PWD/nvimrc /home/vad/.config/nvim/init.vim
ln -s -i $PWD/coc-settings.json ~/.config/nvim/coc-settings.json

ln -s -i $PWD/zsh/zshrc ~/.zshrc
#ln -s -i $PWD/zsh/zsh .zsh -t $HOME
ln -s -i $PWD/zsh/p10k.zsh ~/.p10k.zsh

mkdir -p ~/.config/py3status
ln -s -i $PWD/py3status ~/.config/py3status/config
