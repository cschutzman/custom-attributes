#!/usr/bin/env bash
# Attribute Title: iCloud Keychain Checker
# Version: 1.1.20140514
# Author: Conor Schutzman <conor@mac.com>
ConsoleUser=$(stat -f %Su '/dev/console')
KeychainPrefs="/Users/$ConsoleUser/Library/Preferences/MobileMeAccounts.plist"
KeychainStatus(){ /usr/libexec/PlistBuddy -c "Print Accounts:0:Services" "$KeychainPrefs" | /usr/bin/grep -a1 KEYCHAIN_SYNC | /usr/bin/grep $1; }
[[ "$ConsoleUser" = "root" ]] && exit 0
if [[ $(/usr/bin/sw_vers -productVersion | /usr/bin/awk -F. '{print $2}') -ge 9 ]] && [[ -e "$KeychainPrefs" ]] && [[ $(KeychainStatus true) -gt 0 ]]; then
	echo "<result>1</result>"
else
	echo "<result>0</result>"
fi
exit 0