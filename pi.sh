#!/bin/sh
if [ "${1}x" = x ]; then
    echo syntax: $0 numberofdigits
    exit 1
fi
/bin/echo "scale=${1};4*a(1)" | bc -l
