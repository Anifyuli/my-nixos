#!/usr/bin/bash

# reference: https://bbs.archlinux.org/viewtopic.php?pid=1280941#p1280941

BATTERY_CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)
BATTERY_STATUS=$(cat /sys/class/power_supply/BAT0/status)

NOTIFY_TITLE="Baterai sekarat"
NOTIFY_ICON=battery_empty
NOTIFY_MESSAGE="Mati sia anjing!!!"

SHUTDOWN_WITH=${SHUTDOWN_WITH:-5}

WM=gnome-shell
WMPID=$(pidof ${WM})
WMUSER=$(ps -e -o user,comm | grep ${WM} | cut -f1 -d " ")
DBUS=$(egrep -z 'DBUS_SESSION_BUS_ADDRESS|DISPLAY' /proc/${WMPID}/environ | sed -r -e 's/(.)DBUS_/\1 DBUS_/' -e 's/(.)DISPLAY/\1 DISPLAY/')

if [[ $BATTERY_CAPACITY -le $SHUTDOWN_WITH && $BATTERY_STATUS = "Discharging" ]]; then
	/bin/su ${WMUSER} -c "${DBUS} notify-send --urgency=critical --hint=int:transient:1 --icon $NOTIFY_ICON '$NOTIFY_TITLE' '$NOTIFY_MESSAGE'"
	sleep 60s
	BATTERY_STATUS=$(cat /sys/class/power_supply/BAT0/status)
	if [[ $BATTERY_STATUS = "Discharging" ]]; then
		systemctl poweroff
	fi
fi
