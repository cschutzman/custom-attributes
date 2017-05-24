#!/usr/bin/env bash
# Attribute Title: McAfee Process Count
# Version: 1.1
# Author: Conor Schutzman <conor@mac.com>
processCount=$(/bin/ps aux | /usr/bin/grep 'McAfee')
echo "$processCount"
exit 0