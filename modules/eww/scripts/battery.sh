#!/usr/bin/env bash

battery() {
  BAT="$(ls /sys/class/power_supply | grep BAT | head -n 1)"
  cat /sys/class/power_supply/${BAT}/capacity || echo "100"
}

battery_stat() {
  BAT="$(ls /sys/class/power_supply | grep BAT | head -n 1)"
  cat /sys/class/power_supply/${BAT}/status || echo "unknown"
}

if [[ "$1" == "--bat" ]]; then
  battery
elif [[ "$1" == "--bat-st" ]]; then
  battery_stat
fi
