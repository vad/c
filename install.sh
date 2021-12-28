#!/usr/bin/env sh

# vim
ln -s -i $PWD/nvimrc /home/vad/.config/nvim/init.vim

# zsh
ln -s -i $PWD/zsh/zshrc ~/.zshrc
#ln -s -i $PWD/zsh/zsh .zsh -t $HOME
ln -s -i $PWD/zsh/p10k.zsh ~/.p10k.zsh

# i3
mkdir -p ~/.config/py3status
ln -s -i $PWD/py3status ~/.config/py3status/config
ln -s -i $PWD/i3/config ~/.config/i3/config
ln -s -i $PWD/i3/scripts ~/.config/i3/

# dunst
mkdir -p ~/.config/dunst
ln -s -i $PWD/dunstrc ~/.config/dunst/dunstrc
