#!/bin/bash
: '
The file "battery-monitor.service should be placed in ~/.config/systemd/user/"

start the service:
systemctl --user start battery-monitor.service

set the service for start on reboot
systemctl --user enable battery-monitor.service

to enable this when using i3, insert this line at the end of your
i3 config file:
exec --no-startup-id systemctl --user start battery-monitor.service

'


for (( ; ; ))
do
   STATUS=$(cat /sys/class/power_supply/BAT0/status)
   CHARGE=$(cat /sys/class/power_supply/BAT0/capacity)
   if [ "$STATUS" = "Discharging" ] && [ "$CHARGE" -lt 20 ];then
      ( /usr/bin/notify-send -u critical -a power_supply_low "Low Battery" "You are running low on battery" )
   fi
   sleep 30
done
