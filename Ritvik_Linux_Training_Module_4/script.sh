#!/bin/bash

file="./input.txt"

cat "${file}" | grep -e "frame.time\":" -e "wlan.fc.type\":" -e "wlan.fc.subtype\":" | sed "s/^[ \t]*//" >output.txt

exit 0

