#!/usr/bin/env bash

battery() {
  BAT="$(ls /sys/class/power_supply | grep BAT | head -n 1)"
  cat /sys/class/power_supply/${BAT}/capacity || echo "100"
}

battery_stat() {
  BAT="$(ls /sys/class/power_supply | grep BAT | head -n 1)"
  cat /sys/class/power_supply/${BAT}/status || echo "unknown"
}

level=$(battery)
status=$(battery_stat)

if (( level > 75 )); then
  cat <<EOF
{
  "icon": "",
  "status": "${status}",
  "value": ${level}
}
EOF
elif (( level > 50 )); then
  cat <<EOF
{
  "icon": "",
  "status": "${status}",
  "value": ${level}
}
EOF
elif (( level > 25 )); then
  cat <<EOF
{
  "icon": "",
  "status": "${status}",
  "value": ${level}
}
EOF
else
  cat <<EOF
{
  "icon": "",
  "status": "${status}",
  "value": ${level}
}
EOF
fi
