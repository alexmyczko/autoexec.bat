# Ubuntu (without the bloat)

After having it installed, you will find a lot of ring-home software, and a
lot of stuff that will be running, no matter if you need it or not.

The stuff I get rid of first is all the task that waste precious CPU cycles:
```
apt-get -uy --purge remove snapd kerneloops switcheroo-control modemmanager fwupd \
                           whoopsie tracker unattended-upgrades gnome-online-accounts \
                           apport apport-symptoms avahi-daemon
```

Fonts you are not likely to miss:
```
apt-get -uy --purge remove fonts-tlwg-.* fonts-smc-.* fonts-samyak-.* fonts-lohit-.* fonts-beng.* \
                           fonts-deva.* fonts-gargi fonts-gubbi fonts-kacst.* fonts-kalapi \
                           fonts-khmeros-core fonts-lao fonts-lklug-sinhala fonts-nakula fonts-navilu \
                           fonts-orya-extra fonts-pagul fonts-sahadeva fonts-sarai fonts-sil-abyssinica \
                           fonts-sil-padauk fonts-telu-extra fonts-teluguvijayam fonts-tibetan-machine \
                           fonts-yrsa-rasa
```

Disabling services you most likely do not need, if you prefer amiwm or wmaker over GNOME:
```
systemctl stop polkit
systemctl disable polkit
```

Compressed memory and better OOM handling:
```
apt-get -uy install zram-config nohang; service zram-config start
```
