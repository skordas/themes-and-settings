#!/bin/bash
battery=$(cat /sys/class/power_supply/BAT0/capacity)
dunstify -u low -t 5000 -h int:value:"$battery" "$(echo -e "$(date "+%I:%M %p")\n$(date "+%A, %B %e, %Y")")" "$(echo -e "Battery: $battery%")"

