#!/bin/bash
bell="$HOME/.sounds/short.wav"
sleep 0.050
aplay -q $bell &
value=$(amixer get Master | grep Left: | cut -d ' ' -f 7 | egrep -o '[0-9]{1,3}')
dunstify -a "Notification" -u low -t 2000 -h int:value:$value "Volume" "$value%"
