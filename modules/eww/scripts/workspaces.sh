#!/usr/bin/env bash

# Taken and modified from:
#
# https://codeberg.org/JustineSmithies/hyprland-dotfiles/src/branch/master/.config/eww/scripts/workspace.sh

workspaces() {
  unset -v o1 o2 o3 o4 o5 o6 o7 o8 o9 \
           f1 f2 f3 f4 f5 f6 f7 f8 f9

  # Get occupied workspaces (ignore scratchpad).
  ows="$(hyprctl workspaces -j | jq '.[] | del(select(.id == -99)) | .id')"

  for num in $ows; do
    export o"$num"="$num"
  done

  # Get currently focused workspace.
  num="$(hyprctl monitors -j | jq '.[] | select(.focused == true).activeWorkspace.id')"
  export f"$num"="$num"

  cat <<-EOF | grep -v '"w0"' | tr -d '\n'
(box
  :class "workspaces"
  :orientation "h"
  :space-evenly false
  :spacing 12
  (button :class "w0$o1$f1" :onclick "echo 1" "1")
  (button :class "w0$o2$f2" :onclick "echo 2" "2")
  (button :class "w0$o3$f3" :onclick "echo 3" "3")
  (button :class "w0$o4$f4" :onclick "echo 4" "4")
  (button :class "w0$o5$f5" :onclick "echo 5" "5")
  (button :class "w0$o6$f6" :onclick "echo 6" "6")
  (button :class "w0$o7$f7" :onclick "echo 7" "7")
  (button :class "w0$o8$f8" :onclick "echo 8" "8")
  (button :class "w0$o9$f9" :onclick "echo 9" "9")
)
EOF
  echo ""
}

workspaces
socat -u UNIX-CONNECT:/tmp/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock - | while read -r; do
  workspaces
done
