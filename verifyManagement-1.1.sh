#!/usr/bin/env bash
# Attribute Title: Verify AirWatch Management
# Version: 1.1
# Author: Conor Schutzman <conor@mac.com>
fileLocation='/Library/Receipts/db'
verificationFile='fdf9342DFFd92rfdFILE4398fdfDFDSFCHECK3492843DFfdsad.bin'
if [[ -e "${fileLocation}/${verificationFile}" ]]; then
	echo "Installed"
else
	echo "=== NOT INSTALLED ==="
fi
exit 0