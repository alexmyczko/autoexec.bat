# Some notes about Linux as a user/developer/sysadmin

## General

Hint for getting your sources.list as you want
```
debian-distro-info -af
ubuntu-distro-info -r -f --all
```

sources.list sid+experimental
```
deb http://debian.ethz.ch/debian sid main contrib non-free
deb http://debian.ethz.ch/debian experimental main contrib non-free
deb-src http://debian.ethz.ch/debian sid main contrib non-free
deb-src http://debian.ethz.ch/debian experimental main contrib non-free
```

sources.list debian gnu/kfreebsd
```
deb http://deb.debian.org/debian-ports unstable main
deb-src http://ftp.ch.debian.org/debian unstable main contrib non-free
deb http://deb.debian.org/debian-ports unreleased main
deb http://deb.debian.org/debian-ports experimental main
deb-src http://ftp.ch.debian.org/debian experimental main contrib non-free
```

## Special function files

https://github.com/xen0vas/UserManager/issues/8#issuecomment-622936119

## Monitor resolution

```
auth=$(ps -ef |grep X | grep auth |sed s,.*-auth.,, | awk '{print $1}')
timeout 5 env XAUTHORITY=$auth DISPLAY=:0 xrandr |grep \ connected| sed s/$/\<br\>/g
```

## Popularity of window managers

`cat /home/*/.wm_style | awk '{wm[$0]++} END {for (n in wm) print wm[n] " " n}'`

## Web

`woff2_compress your.ttf|otf` saves a lot of bytes to transfer for custom fonts.

## Networking

`lltdscan -v |awk '/100 Mbit/ {print; print ""}' RS= -`

## RTL SDR

rtl-433
`rtl_433 -G4 -Csi`

dump1090
`dump1090 --interactive --metric`

## Check your disk read only or read write

```
badblocks -nsv /dev/sdX
badblocks -b4096 -sv /dev/sdX
```

## Wrapper scripts for binary only software

```
#!/bin/bash
latest=`ls -1d /opt/whatever-* | sort -Vr | head -1`
$latest/whatever "$@"
```
