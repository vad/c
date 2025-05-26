#!/usr/bin/env sh

sudo apt install zsh i3 build-essential rofi fasd feh py3status brightnessctl xfce4-screenshooter xfce4-clipman xautolock thunar pasystray pavucontrol cmake htop git-lfs xclip blueman lm-sensors i3lock-fancy fzf
sudo usermod --shell /usr/bin/zsh vad
sudo usermod -a -G video vad

# vim
ln -s -i $PWD/nvim $HOME/.config/nvim

# zsh
ln -s -i $PWD/zsh/zshrc ~/.zshrc
#ln -s -i $PWD/zsh/zsh ~/.zsh
ln -s -i $PWD/zsh/p10k.zsh ~/.p10k.zsh

# i3
mkdir -p ~/.config/py3status
ln -s -i $PWD/py3status ~/.config/py3status/config
mkdir -p ~/.config/i3
ln -s -i $PWD/i3/config ~/.config/i3/config
ln -s -i $PWD/i3/scripts ~/.config/i3/

# dunst
mkdir -p ~/.config/dunst
ln -s -i $PWD/dunstrc ~/.config/dunst/dunstrc

# screenlayout
ln -s -i $PWD/screenlayout ~/.screenlayout
