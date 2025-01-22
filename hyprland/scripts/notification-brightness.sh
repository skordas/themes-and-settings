#!/bin/bash
sleep 0.050
value=$(brightnessctl g -P)
dunstify -a "Notification" -u low -t 2000 -h int:value:$value "Brightness" "$value%"
