#!/usr/bin/env bash

# https://github.com/hyprwm/Hyprland/issues/871

# NB: Event grabbed from fullscreening.
#
# WINDOWADDRESS,WORKSPACENAME,WINDOWCLASS,WINDOWTITLE
# openwindow>>37bcc00,3,,

handle() {
  case $1 in
    openwindow*)
      IFS=',' read -r _WINDOWADDRESS _WORKSPACENAME WINDOWCLASS WINDOWTITLE <<< "${1#*>>}"

      # When "fakefullscreen" happens, an openwindow event will fire for a
      # nondescript window that is floating and has no class or title.
      #
      # When that happens, we resize the activewindow so that its geometry gets
      # set appropriately..
      if [[ -z "$WINDOWCLASS" && -z "$WINDOWTITLE" ]]; then
        if [[ "$(hyprctl activewindow -j | jq -r '.class')" = "google-chrome" ]]; then
          hyprctl dispatch resizeactive 1 0
          hyprctl dispatch resizeactive -1 0
        elif [[ -z "$(hyprctl activewindow -j | jq -r '.class')" ]]; then
          hyprctl dispatch setfloating
        fi
      fi
      ;;
  esac
  [[ -n "$DEBUG" ]] && echo "[DBG] $1"
}

socat \
  -U - \
  "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | \
while read -r line; do handle "$line"; done
