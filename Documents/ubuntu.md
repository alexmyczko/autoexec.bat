# Ubuntu (without the bloat)

After having it installed, you will find a lot of ring-home software, and a
lot of stuff that will be running, no matter if you need it or not.

The stuff I get rid of first is all the task that waste precious CPU cycles:
```
apt-get -uy --purge remove snapd kerneloops switcheroo-control modemmanager \
                           whoopsie fwupd tracker unattended-upgrades \
                           gnome-online-accounts
```
