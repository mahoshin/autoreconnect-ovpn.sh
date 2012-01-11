#!/bin/bash
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/usr/local/sbin

#set the VPN　ｓｅｒｖｉｃｅ　ｎａｍｅ
VPN=PPTP

function xxtest () {
	ifconfig|grep $1&&return 1
	return 0
}
while [[ 1 ]]; do
	xxtest ppp0
	if [[ $? == 0 ]]; then
		echo "VPN is not connected!"
		echo "Reconnecting!"
		networksetup -connectpppoeservice $VPN
		sleep 5
	fi
	sleep 5
done