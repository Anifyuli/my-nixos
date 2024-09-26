# reference: https://bbs.archlinux.org/viewtopic.php?pid=1280941#p1280941

BATTERY_CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)
BATTERY_STATUS=$(cat /sys/class/power_supply/BAT0/status)

NOTIFY_TITLE="Baterai sekarat"
NOTIFY_ICON=battery_empty
NOTIFY_MESSAGE="Mati sia anjing!!!"
NOTIFY_SEND=$(command -v notify-send)

SHUTDOWN_WITH=${SHUTDOWN_WITH:-5}

WM=gnome-shell
WMPID=$(pidof ${WM})
WMUSER=$(ps -e -o pid,user,comm | grep ${WMPID} | awk '{print $2}')
DBUS=$(cat /proc/${WMPID}/environ | tr \0 \n | grep 'NOTIFY_SOCKET')

if [[ $BATTERY_CAPACITY -le $SHUTDOWN_WITH && $BATTERY_STATUS = "Discharging" ]]; then
	su ${WMUSER} -c "${DBUS} ${NOTIFY_SEND} --urgency=critical --hint=int:transient:1 --icon $NOTIFY_ICON '$NOTIFY_TITLE' '$NOTIFY_MESSAGE'"
	sleep 60s
	BATTERY_STATUS=$(cat /sys/class/power_supply/BAT0/status)
	if [[ $BATTERY_STATUS = "Discharging" ]]; then
		systemctl poweroff
	fi
fi
