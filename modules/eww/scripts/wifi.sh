#!/usr/bin/env bash

NETWORK="$(iwctl station wlan0 show | \
  grep "Connected network" | \
  sed 's|Connected network||' | \
  tr -s ' ' | \
  sed -r 's|^[[:blank:]]+||')"

if [[ -n "${NETWORK}" ]]; then
  cat <<EOF
{
  "icon": "󰤨",
  "ssid": "${NETWORK}"
}
EOF
else
  cat <<EOF
{
  "icon": "󰤯",
  "ssid": "offline"
}
EOF
fi
