#!/bin/sh
export DISPLAY=:0.0
xset dpms 0 0 0 s off
matchbox-window-manager &
unclutter &
while true; do
  midori -e Fullscreen -a http://172.16.10.1/statusboard &
  sleep 43200
  killall midori
done
