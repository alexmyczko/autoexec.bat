# Energy Saving

This was a proof of concept implementation from 2016, to let managed
Linux workstations sleep under some conditions.

Due to the current state of things:
https://www.energieschweiz.ch/programme/nicht-verschwenden/startseite/

The project is published here, maybe if it is of some use to you.

The details:
You will need the package `pm-utils` from your distribution, which is
a command line interface to https://www.kernel.org/doc/Documentation/power/.
Some conditions are checked if it is feasible to let the computer sleep.
`/etc/pm/sleep.d/99-energysaving`

First check, if the machine is allowed to go to sleep, must be listed
in `/etc/sleeper`.
Following conditions abort the suspend mode
- if remote mounts are active (showmount -a)
- if cronjobs for the user or root are set up
- if any remote user is logged in
On success a note is sent to our Hobbit / Xymon Monitoring (this can 
be adapted to whatever monitoring system you use) system.

## Installation

More or less, this:

```
cp sleeper /etc
cp 99-energysaving /etc/pm/sleep.d
cat cron >> /var/spool/cron/crontabs/root
```

## Debugging / Known Problems

Please consult `/var/log/pm-*.log`
