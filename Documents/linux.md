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

## Networking

`lltdscan -v |awk '/100 Mbit/ {print; print ""}' RS= -`

## RTL SDR

rtl-433
`rtl_433 -G4 -Csi`

dump1090
`dump1090 --interactive --metric`
