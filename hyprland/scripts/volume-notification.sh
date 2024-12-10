#!/bin/bash
sleep 0.050
hyprctl notify -1 500 "rgb(4CA2B8)" "fontsize:25 $(amixer get Master | grep Left: | egrep -o '[0-9]{1,3}%')"
 
