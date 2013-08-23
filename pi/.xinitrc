export DISPLAY=:0.0
setterm -blank 0 -powersave off -powerdown 0
xset dpms 0 0 0 s off
unclutter &
chromium-browser --kiosk 172.16.10.2/statusboard
