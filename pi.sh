#!/bin/sh
# 20:04 < io> tarzeau: there's a better formula btw: 
# https://www.johndcook.com/blog/2019/10/29/computing-pi-with-bc/ time bc -l <<< 
# "scale=10000;16*a(1/5) - 4*a(1/239)"
if [ "${1}x" = x ]; then
    echo syntax: $0 numberofdigits
    exit 1
fi
/bin/echo "scale=${1};4*a(1)" | bc -l
