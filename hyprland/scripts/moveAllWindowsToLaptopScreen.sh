#!/bin/bash

clients=$(hyprctl clients -j)
l=$(echo $clients | jq length)
i=0 # Everything here starts with 0 :)
moveTo=1

while (( $i < $l ))
do
  address=$(echo $clients | jq -r ".[$i].address")
  workspaceId=$(echo $clients | jq -r ".[$i].workspace.id")

  if [[ $workspaceId -gt 10 ]]
  then
    moveTo=$(($workspaceId-10))
    hyprctl dispatch workspace $workspaceId
    sleep 0.5
    hyprctl dispatch movetoworkspace $moveTo,address:$address
    sleep 0.5
  fi
  ((i++))
done

