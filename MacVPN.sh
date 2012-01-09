#!/bin/bash
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/usr/local/sbin

#set the gateway
oldgw=192.168.1.101
vpngw=10.102.20.1

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
		#delete old routes
		route delete default gw $oldgw
		route delete default gw $vpngw
		route add default gw $oldgw
		networksetup -connectpppoeservice $VPN
	fi
	sleep 5
done