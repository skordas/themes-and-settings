#!/bin/bash

sleep_time=30

# Initial status
# Later change to:
# FULL - no need to explain
# NOT_CHARGING - No charging, no discharging, no full :)
# CHARGING - no need to explain
# DISCHARGING - discharging and higher that $low_threshold
# LOW - discharging, below $low_threshold and over $critical_threshold
# CRITICAL - below $critical_threshold
status=""
previous_status=""
low_threshold=15
critical_threshold=5

function time_left() {
    h=$(echo "$1/1" | bc)
    m=$(echo "($1-$h)*60/1" | bc)

    if [[ $m -lt 10 ]]
    then
      m=$(echo "0$m")
    fi

    echo "$h h $m min"
}

# late start
sleep 15

while :
do
  battery_status=$(cat /sys/class/power_supply/BAT0/status)
  battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)
  battery_full=$(cat /sys/class/power_supply/BAT0/energy_full) # How much can be stored
  energy_now=$(cat /sys/class/power_supply/BAT0/energy_now) # How much is stored right now
  energy_rate=$(cat /sys/class/power_supply/BAT0/hwmon2/power1_input) # How much is used per hour

  date "+%Y-%m-%d %H:%M:%S"
  echo "Status & Battery: $battery_status $battery_percentage%"

  ###### FULL ######
  if [[ $battery_status == "Full" ]]
  then
    status="FULL"
    if [[ $status != $previous_status ]]
    then
      notify-send -t 10000 -i /usr/share/icons/AdwaitaLegacy/48x48/legacy/battery-full.png "$(echo "$battery_status $battery_percentage%")"
    fi
  fi

  ###### NOT_CHARGING ######
  if [[ $battery_status == "Not Charging" ]]
  then
    status="NOT_CHARGING"
    if [[ $status != $previous_status ]]
    then
      notify-send -t 10000 -i /usr/share/icons/AdwaitaLegacy/48x48/legacy/battery-full-charged.png "$(echo "$battery_status $battery_percentage%")"
    fi
  fi

  ###### CHARGING ######
  if [[ $battery_status == "Charging" ]]
  then
    status="CHARGING"
    if [[ $status != $previous_status ]]
    then
      brightnessctl set 100%
      time_to_full=$(time_left $(echo "($battery_full-$energy_now)/$energy_rate" | bc -l))
      notify-send -t 10000 -i /usr/share/icons/AdwaitaLegacy/48x48/legacy/battery-good-charging.png "$(echo "$battery_status $battery_percentage%")" "$(echo "Time to full: $time_to_full")"
    fi
  fi

  ###### DISCHARGING ######
  if [[ $battery_status == "Discharging" ]] && [[ $battery_percentage -gt $low_threshold ]]
  then
    status="DISCHARGING"
    if [[ $status != $previous_status ]]
    then
      time_to_empty=$(time_left $(echo "$energy_now/$energy_rate" | bc -l))
      notify-send -t 10000 -i /usr/share/icons/AdwaitaLegacy/48x48/legacy/battery-good.png "$(echo "$battery_status $battery_percentage%")" "$(echo "Time to empty: $time_to_empty")"
    fi
  fi

  ###### LOW ######
  if [[ $battery_status == "Discharging" ]] && [[ $battery_percentage -le $low_threshold ]] && [[ $battery_percentage -gt $critical_threshold ]]
  then
    status="LOW"
    if [[ $status != $previous_status ]]
    then
      brightnessctl set 50%
      time_to_empty=$(time_left $(echo "$energy_now/$energy_rate" | bc -l))
      notify-send -t 20000 -i /usr/share/icons/AdwaitaLegacy/48x48/legacy/battery-low.png "$(echo "$battery_status $battery_percentage%")" "$(echo "Time to empty: $time_to_empty")"
    fi
  fi

  ###### CRITICAL ######
  if [[ $battery_status == "Discharging" ]] && [[ $battery_percentage -le $critical_threshold ]]
  then
    status="CRITICAL"
    if [[ $status != $previous_status ]]
    then
      brightnessctl set 25%
      time_to_empty=$(time_left $(echo "$energy_now/$energy_rate" | bc -l))
      notify-send -u critical -i /usr/share/icons/AdwaitaLegacy/48x48/legacy/battery-caution.png "$(echo "$battery_status $battery_percentage%")" "$(echo "Time to empty: $time_to_empty")"
    fi
  fi

  previous_status=$status
  sleep $sleep_time
done
