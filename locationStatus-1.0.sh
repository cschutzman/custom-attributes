#!/usr/bin/env bash
# Attribute Title: locationStatus
# Version: 1.0
# Author: Conor Schutzman <conor@mac.com>
locationServices=$(python -c "from CoreLocation import CLLocationManager; is_enabled=CLLocationManager.locationServicesEnabled();print is_enabled")
if [[ "$locationServices" -eq "true" ]]; then
    echo "1"
elif [[ "$locationServices" -eq "false" ]]; then
    echo "0"
else
    echo "?"
fi
exit 0