#!/usr/bin/env bash

DIR="$(dirname "$0")"
NETWORK="$(iwctl station wlan0 show | \
  grep "Connected network" | \
  sed 's|Connected network||' | \
  tr -s ' ' | \
  sed -r 's|^[[:blank:]]+||' | \
  sed -r 's|[[:blank:]]+$||')"
VPN="$(${DIR}/wireguard.sh status | \
  jq -r .status)"

case "${NETWORK}:${VPN}" in
  :*)
    # Network disconnected.
    cat <<EOF
{
  "icon": "󰤯",
  "ssid": "offline"
}
EOF
    ;;
  *:on)
    # VPN connected.
    cat <<EOF
{
  "icon": "󰤪",
  "ssid": "${NETWORK}"
}
EOF
    ;;
  *:off)
    cat <<EOF
{
  "icon": "󰤨",
  "ssid": "${NETWORK}"
}
EOF
    ;;
esac
