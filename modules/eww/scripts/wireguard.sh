#!/usr/bin/env bash

# Check for the available wireguard configs.
# If one is already active, disable it.
# Otherwise, show the user a wofi selection to select one of the available
# configurations.
#
# This assumes that passwordless sudo permission has been granted to the
# wg-quick command.

interfaces=( $(ls /etc/wireguard/) )
interfaces=$(IFS='|'; echo "${interfaces[*]}" | sed 's|.conf||')

activeiface="$(ip link | grep -E "${interfaces}" | awk '{ print $2 }' | cut -d ':' -f 1)"

toggle() {
  if [[ -z "${activeiface}" ]]; then
    iface="$(echo "${interfaces}" | sed 's/|/\n/g' | wofi -bde)"
    if [[ -n "${iface}" ]]; then
      /run/wrappers/bin/sudo -E wg-quick up "${iface}"
      eww update wifi_icon="󰤪"
    fi
  else
    /run/wrappers/bin/sudo -E wg-quick down "${activeiface}"
    eww update wifi_icon="󰤨"
  fi
}

status() {
  if [[ -z "${activeiface}" ]]; then
    cat <<EOF
{
  "status": "off",
  "value": ""
}
EOF
  else
    cat <<EOF
{
  "status": "on",
  "value": "${activeiface}"
}
EOF
  fi
}

case "$1" in
  toggle)
    toggle
    ;;
  status)
    status
    ;;
  *)
    echo "Usage: $0 {toggle|status}"
    exit 1
    ;;
esac
