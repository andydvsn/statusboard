export DISPLAY=:0.0
setterm -blank 0 -powersave off -powerdown 0
xset dpms 0 0 0 s off
unclutter &
matchbox-window-manager &
while true; do
  midori -e Fullscreen -a http://172.16.10.2/statusboard &
  sleep 43200
  killall midori
done
