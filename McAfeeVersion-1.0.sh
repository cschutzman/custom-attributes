#!/usr/bin/env bash
# Attribute Title: McAfee Installed
# Version: 1.0-20160922
# Author: Conor Schutzman <conor@mac.com>
appName='McAfee Endpoint Security for Mac'
if [[ -e "/Applications/${appName}.app" ]]; then
	appVersion=$(/usr/bin/mdls -name kMDItemVersion "/Applications/${appName}.app" | awk -F '"' '{print $2}')
	echo "$appVersion"
else
	echo "=== Not Installed==="
fi
exit 0