# Why waste time say lot word when few word do trick

It is written in the Book of Linux on the desktop:

```
    Ubuntu is an ancient african word meaning,
    unfortunately I can not install Debian.
    But Debian really is what I need.

You, a new Linux admin, face a ton of Linux installations,
with many users, and no organisation. You are destined to
recover the chaos. Your hour of destiny has come. For the
sake of us all:  Go bravely and send back patches!
```

# Read the source, Luke

Obviously this doesn't help, so here's a short description about what these things are for

`ubuntu-remove-snap-firefox` remove snap from your Ubuntu, and install the Firefox Mozilla PPA repository

`ubuntu-remove-phased-updates` getting rid of phased updates of Ubuntu (useful if you turn off automatic error reporting, which is not publicly accessible anymore). See comments for reference.

`debian-system-zram` install zram, and activate it (50 % of RAM as compressed RAM), check with `swapon` or `zramctl`

`debian-system-dmesg` give users a chance to run `dmesg` to check if some of their processes did OOM

`debian-system-initramfs` enable compression of initramfs, makeing space in /boot

`ubuntu-remove-fonts` removes fonts you are not likely to ever need (if you're in Europe)

# Installer scripts

These are so self explanatory, I will not comment them.

`install-edge`

`install-google-chrome`

`install-google-earth-pro`

`install-slack-desktop`

`install-virtualbox`

`install-vscode`

`install-zoom`

# Ubuntu is Debian-based the same way milk is grass-based

`ubuntu-deluxe` kind of Ubuntu Pro, without the Ubuntu, makes a Debian 12 from your Ubuntu 22.04 (WIP)

# Helpers

`apt-history` check which packages have been installed with apt

`kexec-reboot` try to reboot to the latest installed kernel (if kexec-tools is installed)

`lint-hostname` lint your hostname

`ipmi-detect` check if computer has IPMI and what version of it

`reduce-bin` use UPX (compression) on known huge binaries

`netlimit` limit upload/download speeds on a interface

`which-firmware` check which firmware packages should get installed

# Next.

Another happy customer leaves the building.
