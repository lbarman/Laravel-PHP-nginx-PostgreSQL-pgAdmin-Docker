#!/bin/sh

# this script is run by Travis when some Dusk test failed.
# Its sole purpose is to make debugging easier by copying the
# output of test results to sdtout, and uploading screenshots
# of failed pages

FOLDER="/website/tests/Browser/"
CONSOLE_FOLDER="${FOLDER}console/"
SCREENSHOT_FOLDER="${FOLDER}screenshots/"

for logFile in "${CONSOLE_FOLDER}"*.log; do
	echo "-----------"
	echo "${logFile}"
	cat "${logFile}"
	echo ""
done

echo "Uploading " "${SCREENSHOT_FOLDER}"*.png
imgur.sh "${SCREENSHOT_FOLDER}"*.png

echo "[Done]"
