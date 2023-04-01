# Ubuntu (without the bloat)

After having it installed, you will find a lot of ring-home software, and a
lot of stuff that will be running, no matter if you need it or not.

The stuff I get rid of first is all the task that waste precious CPU cycles:
```
apt-get -uy --purge remove kerneloops switcheroo-control modemmanager fwupd \
                           whoopsie tracker unattended-upgrades gnome-online-accounts \
                           apport apport-symptoms avahi-daemon
```

Getting rid of Firefox as snap:
https://github.com/alexmyczko/autoexec.bat/blob/master/config.sys/ubuntu-remove-snap-firefox

Sound after suspend "Dummy Output": `pulseaudio -k`

Fonts you are not likely to miss:
https://github.com/alexmyczko/autoexec.bat/blob/master/config.sys/ubuntu-remove-fonts

Disabling services you most likely do not need, if you prefer amiwm or wmaker over GNOME:
```
systemctl stop polkit
systemctl disable polkit
```

Compressed memory and better OOM handling:
https://github.com/alexmyczko/autoexec.bat/blob/master/config.sys/ubuntu-system-zram
