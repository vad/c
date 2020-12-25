#!/usr/bin/env bash

# rofi-power
# Use rofi to call systemctl for shutdown, reboot, etc

# 2016 Oliver Kraitschy - http://okraits.de

OPTIONS="Mono\nHome\nWork\nMirror-1080p"

LAUNCHER="rofi -width 30 -dmenu -l 4 -i -no-custom -p display:"

option=`echo -e $OPTIONS | $LAUNCHER | awk '{print $1}' | tr -d '\r\n'`
if [ ${#option} -gt 0 ]
then
    case $option in
      Mono)
        ~/.screenlayout/mono.sh
        ;;
      Work)
        ~/.screenlayout/work.sh
        ;;
      Home)
        ~/.screenlayout/home.sh
        ;;
      Mirror-1080p)
        ~/.screenlayout/mirror-1080p.sh
        ;;
      *)
        ;;
    esac

    sh ~/.fehbg
fi
