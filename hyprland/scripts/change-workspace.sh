#!/bin/bash

lapWork=0
verWork=10

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
fi
verWork=$(($lapWork+10))

hyprctl dispatch workspace $verWork
hyprctl dispatch workspace $lapWork
