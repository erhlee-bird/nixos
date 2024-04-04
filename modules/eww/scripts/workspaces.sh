#!/usr/bin/env bash

# Taken and modified from:
#
# https://codeberg.org/JustineSmithies/hyprland-dotfiles/src/branch/master/.config/eww/scripts/workspace.sh

ws_format() {
  local ws="${1}"
  local is_active="$2"
  local is_occupied="$3"
  local is_focused="$4"

  if [[ $is_focused -eq 1 ]]; then
     echo "  (button :class \"ws-focused\" \"$ws\")"
  elif [[ $is_active -eq 1 ]]; then
     echo "  (button :class \"ws-active\" \"$ws\")"
  elif [[ $is_occupied -eq 1 ]]; then
     echo "  (button :class \"ws-occupied\" \"$ws\")"
  fi
}

workspaces() {
  declare -a ws_active=( $(for i in {1..9}; do echo 0; done ) )
  declare -a ws_occupied=( $(for i in {1..9}; do echo 0; done ) )
  declare -a ws_focused=( $(for i in {1..9}; do echo 0; done ) )

  # Set the occupied flag for each workspace (ignore scratchpad).
  while read -r ws; do
    ws_occupied[$ws]=1
  done < <(
    hyprctl workspaces -j | \
    jq '.[] | del(select(.id == -99)) | .id'
  )

  # Set the active flag for each workspace.
  while read -r ws; do
    ws_active[$ws]=1
  done < <(
    hyprctl monitors -j | \
    jq '.[] | .activeWorkspace.id'
  )

  # Set the focused flag for each workspace.
  while read -r ws; do
    ws_focused[$ws]=1
  done < <(
    hyprctl monitors -j | \
    jq '.[] | select(.focused == true).activeWorkspace.id'
  )

  export WS_ACTIVE="#eb8258"; # Mandarin
  export WS_FOCUSED="#fe654f"; # Tomato
  cat <<-EOF | grep -v '"w0"' | tr -d '\n'
(box
  :class "workspaces"
  :orientation "h"
  :space-evenly false
  :spacing 12
  $(for ws in {1..9}; do \
      ws_format $ws \
                ${ws_active[$ws]} \
                ${ws_occupied[$ws]} \
                ${ws_focused[$ws]}; \
    done)
)
EOF
  echo ""
}

workspaces
socat -u UNIX-CONNECT:/tmp/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock - | while read -r; do
  workspaces
done
