#! /bin/bash


# xset -b

sleep 0.5
# xrandr --output HDMI-0 --primary --auto --above DP-4
$DWM/dwm_statusbar cron &
# $_thisdir/scripts/rechange_wallpaper.sh &
picom --experimental-backends &
# xfce4-power-manager &
dunst &
flameshot &
fcitx5 &

# sleep 8
# clash-verge &
# python3 $_thisdir/scripts/network.py
