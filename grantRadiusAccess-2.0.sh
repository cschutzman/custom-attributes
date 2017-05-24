#!/usr/bin/env bash
# Attribute Title: Grant Wifi Access via RADIUS Registration
# Version: 2.0
# Author: Conor Schutzman <conor@mac.com>
# VARIABLES
networkTest(){ /usr/bin/curl -L -s -o /dev/null --silent --head --write-out '%{http_code}' "$1" --location-trusted -X GET; }
accessURL= #Enter the web URL of the RADIUS Server here
currentHostname=$(/usr/sbin/scutil --get HostName)
consoleUser=$(/usr/bin/stat -f %Su '/dev/console')
wirelessMAC=$(/usr/sbin/networksetup -listallhardwareports | /usr/bin/sed -n -e '/Wi-Fi/{n;n;s/Ethernet Address: //;p;}' -e '/AirPort/{n;n;s/Ethernet Address: //;p;}')
connectionLog='/Library/Logs/accessWifi.log'
# ATTEMPT CONNECTION
if [[ $(networkTest $accessURL) -eq 403 ]]; then
	/usr/bin/logger -s -t "${consoleUser} ${currentHostname} ${wirelessMAC}" -p "user.info" "$(date)" 2>> "$connectionLog"
	/usr/bin/curl -s -o /dev/null "${accessURL}/MacbookRegistration.aspx?hostname=${currentHostname}&userid=${consoleUser}&AirportMAC=${wirelessMAC}"
else
	/usr/bin/logger -s -t "${consoleUser} ${currentHostname} ${wirelessMAC}" -p "user.warning" "Error $(networkTest $accessURL)" 2>> "$connectionLog"
fi
# REPORT LAST CONNECTION
if [[ -e "$connectionLog" ]]; then
	connectionCount=$(cat "$connectionLog" | /usr/bin/grep -c '<Info>')
	if [[ "$connectionCount" -eq 0 ]]; then
		echo "== No Successful Connections =="
	else
		echo "$(cat "$connectionLog" | /usr/bin/grep '<Info>' | /usr/bin/tail -n 1 | /usr/bin/awk -F ': ' '{print $2}')"
	fi
else
	touch "$connectionLog"
	echo "== No Connection Log Found =="
fi
exit 0
