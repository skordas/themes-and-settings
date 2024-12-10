#!/bin/bash

d1="   [  I  ]"
d2="  [  II  ]"
d3=" [  III  ]"
d4="  [  IV  ]"
d5="   [  V  ]"
d6="  [  VI  ]"
d7=" [  VII  ]"
d8="[  VIII  ]"
d9="  [  IX  ]"

desktop=$(hyprctl activeworkspace -j | jq .id)
display=""
if [ $desktop -eq "1" ] || [ $desktop -eq "11" ]
then
  display=$d1
elif [ $desktop -eq "2" ] || [ $desktop -eq "12" ]
then
  display=$d2
elif [ $desktop -eq "3" ] || [ $desktop -eq "13" ]
then
  display=$d3
elif [ $desktop -eq "4" ] || [ $desktop -eq "14" ]
then
  display=$d4
elif [ $desktop -eq "5" ] || [ $desktop -eq "15" ]
then
  display=$d5
elif [ $desktop -eq "6" ] || [ $desktop -eq "16" ]
then
  display=$d6
elif [ $desktop -eq "7" ] || [ $desktop -eq "17" ]
then
  display=$d7
elif [ $desktop -eq "8" ] || [ $desktop -eq "18" ]
then
  display=$d8
elif [ $desktop -eq "9" ] || [ $desktop -eq "19" ]
then
  display=$d9
fi 
hyprctl notify -1 1000 "rgb(b0b394)" "fontsize:25 $display"
