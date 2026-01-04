#!/bin/bash

set -e

export YDOTOOL_SOCKET=/tmp/.ydotool_socket

sleep 0.3   # wait for user release the key first
if [ -n "$WAYLAND_DISPLAY" ]; then
#https://askubuntu.com/questions/1413829/how-can-i-install-and-use-the-latest-ydotool-keyboard-automation-tool-working-o
    cc="ydotool key 29:1 46:1 46:0 29:0"  # cat /usr/include/linux/input-event-codes.h | grep KEY_LEFTCTRL
    cv="ydotool key 29:1 47:1 47:0 29:0"
    c="wl-copy -n"
    v="wl-paste -n"
else
    cc="xdotool key ctrl+c"
    cv="xdotool key ctrl+v"
    c="xclip -selection clipboard -r"
    v="$c -o"
fi

_PPID=$(ps -o ppid= -p $$)
PARENT=$(ps -o comm= -p $_PPID)
TERMINAL=(sh termina onsole tty tilix)
for i in "${TERMINAL[@]}"; do
    if [[ "$PARENT" == *"$i"* ]]; then
        cc=
        break
    fi
done
$cc 1>&2 > /tmp/ime-helper.log
t="$($v)"

lines=$(echo -n "$t"|wc -l)
if [ $lines -ge 1 ]; then
    input=(--height=$((lines*18+30)) --text-info --editable )  #multi_line
    #input="--wrap --brackets --line-num --line-hl $input"  #yad only
    #input="--smart-he=always --smart-bs $input"  #yad only when coding, https://yad-guide.ingk.se/text/yad-text.html#_smart_hetype
    TITLE="Ctrl+Enter/Alt+O to paste"
else
    input=(--entry --entry-text "${t[*]}")  #single_line
    TEXT=$t
fi

zen=(zenity --title="${TITLE[*]}" --text="${TEXT[*]}")
yad=(yad --title="${TITLE:-$TEXT}" --wrap --no-buttons --mouse) # --no-buttons 
set -o pipefail -x
#echo -n "${t[*]}"| "${zen[@]}" --width=800 "${input[@]}" | $c
echo -n "${t[*]}"| "${yad[@]}" --width=800 "${input[@]}" | $c
if [ $? -ne 0 ]; then exit 1; fi
sleep 0.1 ; $cv
