#!/bin/bash
bell="$HOME/.sounds/short.wav"
sleep 0.050
aplay -q $bell &
hyprctl notify -1 500 "rgb(4CA2B8)" "fontsize:18 $(amixer get Master | grep Left: | egrep -o '[0-9]{1,3}%')"
