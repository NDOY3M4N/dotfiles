#!/usr/bin/env bash

THRESHOLD=30
iDIR="$HOME/.config/swaync/icons"

while true; do
  # PERF: refactor this, loop through all of the devices and compute the percentage
  percentage_bat0=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -oP 'percentage:\s+\K\d+%' | sed 's/%//')
  percentage_bat1=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep -oP 'percentage:\s+\K\d+%' | sed 's/%//')

  percentage=$((($percentage_bat1 + $percentage_bat0 ) / 2))

  if [ "$percentage" -le "$THRESHOLD" ]; then
    notify-send -e -u critical -i "$iDir/battery-status.png" "Battery Low!" "Your battery is at $percentage%. Please plug in your laptop."
  fi

  sleep 60 # Check every minute
done
