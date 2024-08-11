#! /bin/bash
# VOL 音量脚本
# 本脚本需要你自行修改音量获取命令
# 例如我使用的是 pipewire
#
# $ pactl list sinks | grep RUNNING -A 8
#         State: RUNNING
#         Name: bluez_output.88_C9_E8_14_2A_72.1
#         Description: WH-1000XM4
#         Driver: PipeWire
#         Sample Specification: float32le 2ch 48000Hz
#         Channel Map: front-left,front-right
#         Owner Module: 4294967295
# 静音 -> Mute: no                                                                                 
# 音量 -> Volume: front-left: 13183 /  20% / -41.79 dB,   front-right: 13183 /  20% / -41.79 dB

tempfile=$DWM/statusbar/temp
update() {
  sink=$(pactl info | grep 'Default Sink' | awk '{print $3}')
  if [ "$sink" = "" ]; then sink=$(pactl info | grep '默认音频入口' | awk -F'：' '{print $2}');fi
  volunmuted=$(pactl list sinks | grep $sink -A 6 | sed -n '7p' | grep '静音：否')
  vol_text=$(pactl list sinks | grep $sink -A 7 | sed -n '8p' | awk '{printf int($4)}')
  if [ "$LANG" != "zh_CN.UTF-8" ]; then
    volunmuted=$(pactl list sinks | grep $sink -A 6 | sed -n '7p' | grep 'Mute: no')
    vol_text=$(pactl list sinks | grep $sink -A 7 | sed -n '8p' | awk '{printf int($5)}')
  fi
  if [ ! "$volunmuted" ];      then vol_text="--"; vol_icon="";
  elif [ "$vol_text" -eq 0 ];  then vol_text="00"; vol_icon="";
  elif [ "$vol_text" -lt 10 ]; then vol_icon=""; vol_text=0$vol_text;
  elif [ "$vol_text" -le 50 ]; then vol_icon="";
  else vol_icon=""; fi
}

notify() {
  update
  notify-send -r 9527 -h int:value:$vol_text -h string:hlcolor:#dddddd "$vol_icon  Volume"
}

click() {
  case "$1" in
    L) notify                                           ;; # 仅通知
    R) pactl set-sink-mute @DEFAULT_SINK@ toggle        ;; # 切换静音
    U) pactl set-sink-volume @DEFAULT_SINK@ +5%; notify ;; # 音量加
    D) pactl set-sink-volume @DEFAULT_SINK@ -5%; notify ;; # 音量减
  esac
  touch $tempfile
}

case "$1" in
  click) click $2 ;;
  notify) notify ;;
esac
