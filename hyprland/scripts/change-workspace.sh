#!/bin/bash

lapWork=0
verWork=10
firstWorkspace=""
secondWorkspace=""

function focus_history() {
  focus_history=$(hyprctl clients -j | jq -c ".[] | select( .workspace.id | contains(${1}))" | jq '.focusHistoryID' | sort -n | head -n1)
  # If empty screen, then return high number to be sure it's last activity
  if [[ $focus_history -eq "" ]]
  then
    focus_history=100
  fi
  echo "$focus_history"
}

currWork=$(hyprctl activeworkspace -j | jq ".id")

if [[ $currWork -gt 10 ]]
then
  currWork=$(($currWork-10))
fi

if [[ $1 == "l" ]]
then
  if [[ $currWork -eq 1 ]]
  then
    lapWork=9 # Jump from first one to last one
  else
    lapWork=$(($currWork-1))
  fi
elif [[ $1 == "r" ]]
then
  if [[ $currWork -eq 9 ]]
  then
    lapWork=1 # Jump from last one to first one
  else
    lapWork=$(($currWork+1))
  fi
else
  lapWork=$1
fi
verWork=$(($lapWork+10))

focus_hist_lap=$(focus_history $lapWork)
focus_hist_ver=$(focus_history $verWork)

if [[ $focus_hist_lap -lt $focus_hist_ver ]] || [[ $focus_hist_lap -eq $focus_hist_ver ]]
then
  firstWorkspace=$lapWork
  secondWorkspace=$verWork
else
  firstWorkspace=$verWork
  secondWorkspace=$lapWork
fi

hyprctl dispatch workspace $secondWorkspace
hyprctl dispatch workspace $firstWorkspace

sleep 0.05
# hyprctl notify -1 2000 "rgb(b0b394)" "fontsize:16 $(echo -e "╭─────────────╮\n│             │\n│      ${lapWork}      │\n│             │\n╰─────────────╯")"
dunstify -a "Desktop" -u low -t 2000 "$(echo -e "╭─────────────╮\n│             │\n│      ${lapWork}      │\n│             │\n╰─────────────╯")"

