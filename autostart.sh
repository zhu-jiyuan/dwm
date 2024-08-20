#! /bin/zsh


xset -b

sleep 1
# xrandr --output HDMI-0 --primary --auto --above DP-4
dwm_statusbar cron &
$DWM/scripts/wallpaper.sh 1 start
# $_thisdir/scripts/rechange_wallpaper.sh &
picom &
# xfce4-power-manager &
dunst &
flameshot &
fcitx5 &

# sleep 8
# clash-verge &
# python3 $_thisdir/scripts/network.py
