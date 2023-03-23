%title: Debian Packaging - mdp presentation
%author: Alex Myczko <tar@debian.org>
%date: 2020-05-24

-> Debian Packaging <-
=========

-> Debian is a binary distribution of software <-

I will go through these steps with you:

* Overview 
* History
* Statistics
* Open Source vs. Free Software (Licensing and Copyright)
* Build Systems
* Building a simple package the standard way
* What we need, what we do
* Backports
* Quality Control, Lintian, Details
* But why?
* Questions?

-------------------------------------------------

-> History <-

Debian exists since 1993, .deb exists since 1995.
Red Hat was founded 1993, .rpm exists since 1997.
The Linux kernel was first released in 1991.

Main difference of the package formats is case sensitiveness of package names,
another is the automatic dependency management where apt was way a head 
of its time (and still is IMHO).

How they are built, debian has a debian/rules, rpms do .spec files.
According my observations rpm distributions (also affected are
AppImage, flatpak and snap, they don't take licensing serious)

repology.org has some great information about software distributions,
not limited to Linux.

The webpage softwareheritage.org tries to collect as much as possible
sources.

-------------------------------------------------

-> Statistics <-

[An excerpt](https://sources.debian.org/stats/)
337 GB (sid), 31k source packages, 1370 million lines of source code.
Nearly 17 million source files.
* 43 % ANSI C
* 25 % C++
* 6 % Java
* 5 % Shell
* 4 % Python
* 17 % not so important languages

More than 6000 people worked on it, I do since 2001. It's currently
about 1.2k people working on it. Active bugs 180k, Archived 840k.
The bug tracking [BTS](https://bugs.debian.org/) is open (we have a mirror).
Debian also rebuilds its archive with clang regularly https://clang.debian.net/

-------------------------------------------------

-> Open Source vs. Free Software (Licensing and Copyright) <-

What can be officially packaged for Debian?
Free Software vs. Open Source

Microsoft has a program, where you can view parts of their source code:
https://www.microsoft.com/en-us/sharedsource/
But you can't take it, improve it, and distribute those improvements
in source form.

Free Software, as defined by GNU
https://www.gnu.org/philosophy/free-sw.en.html

* The freedom to run the program as you wish, for any purpose (freedom 0).
* The freedom to study how the program works, and change it so it does your computing as you wish (freedom 1). Access to the source code is a precondition for this.
* The freedom to redistribute copies so you can help others (freedom 2).
* The freedom to distribute copies of your modified versions to others (freedom 3). By doing this you can give the whole community a chance to benefit from your changes. Access to the source code is a precondition for this.

-------------------------------------------------

-> Build Systems <-

https://en.wikipedia.org/wiki/List_of_build_automation_software
scons, manual steps, make, ./configure make, cmake.

Disqualifications for accessing and downloading from the Internet.

`ccmake ..` is often useful to figure out the same as
`./configure --help` tells you.

-------------------------------------------------

Setting up your environment:

```
# apt-get install build-essential lintian debhelper dh-make devscripts fakeroot
```

Debian specific environment variables:

```
$ export DEBEMAIL="tar@debian.org"
$ export DEBFULLNAME="Alex Myczko"
$ export EDITOR=mcedit
```

-------------------------------------------------

It's important to have the naming right, otherwise `debuild`
will bail out with an error message.

```
$ tar xzvf software-2.1.tar.gz
$ ln -s software-2.1.tar.gz software_2.1.orig.tar.gz
$ cd software-2.1/
$ dh_make
```

If licensing requires the source tarball to be repacked dropping
files it should be noted in the version with +dfsg.n (just +dfsg),
or +ds, depending what exactly the reason is.

For uploads `dput` is used, and can be used to create PPAs for Ubuntu.
`debsign` is used to sign a package cryptically (PGP key).

Creating updates to an existing package is done using `dch -i`.

-------------------------------------------------

Edit debian/*
```
$ debuild
```

Consult the output carefully, if it's gone, you will always also
find build log files.

`sbuild` (and `pbuilder`) are tools to check your package build in a
`chroot` - to ensure you have all the Build-Depends right.

`-S` is an option to only rebuild the source package.

There is a helper utility to package CPAN modules

```
dh-make-perl --build --cpan astro::suntime
```

-------------------------------------------------

-> What we need, what we do <-

D-PHYS
lie (ITP, 2006-2018), form (ITP, 2016-2023), foremost (hardware, 2006-2010),
memtester (hardware, 2006-2008), flashrom (hardware, 2019-2023),
coreboot, pynpoint (ASTRO),
rclone-browser (ASTRO, 2019), hpx (noch nicht drin), cadabra (ITP, 2009-2010),
cadabra2, gnudatalanguage (ASTRO, 2007-2011, 2019), kokkos, ffcv, callisto, drs4eb, csaps, nusolve,
liblhapdf-dev (ITP, 2007), goaccess (dual-bin Version, 2019-2020), geant4, root-system, nohang, mimalloc, qvge, zfp, unuran, vdt, mfem, uftrace, guider

D-BAUG
colmap (2018-2020), cloudcompare (2018-2020),
labelme (2019-2020), meshlab (2019-2020)
libpointmatcher & libnabo (2018, pf-pc15), groops

D-BIOL
ctffind, coot

D-INFK
libnfsidmap-regex (2019-2020), got merged upstream in
nfs-utils (nfs-utils-2-4-4-rc3+)

FIRST
kic (2007-2012)

-------------------------------------------------

-> Backports <-

First, check for a backport on debian-backports, if unavailable
Sometimes newer unreleased, being worked on packagings of software can
be found at salsa.debian.org or somewhere on the internet, most likely
not at warez.debian.net

`dget` the wanted source package from packages.debian.org
(another way would be to add deb-src for sid, sometimes experimental
line for sources.list, that would allow `apt-get source pkg/sid`)

`dpkg-source -x the.dsc` will unpack it for further processing.

`apt build-dep pkg` would install build-depends of a package.

-------------------------------------------------

-> Quality Control, Lintian, Details <-

Quality control means check if your package installs without problems,
the software works as expected, a manual page is included.

```
$ lintian -Ivi your.changes
```
detects a lot of W: (warnings) and E: (errors) that should get fixed,
sometimes it is wrong, these can be overridden and reported.

Details in afterwork are
* add screenshot where applicable to screenshots.debian.net
* tag your package at debtags.debian.org
* check the lintian output at lintian.debian.org
* put to salsa.debian.org (gitlab)

-------------------------------------------------

-> But why? <-

Advantage, for the overview that you get and the control

Disadvantage, maybe an initial effort that will only paid back
in the future. Depending on the developers and source (changes
that require reworking debian/*) can cause some more work.

Examples for that are gui toolkit upgrades that were not designed
well. gtk1 > gtk2 > gtk3 > gtk4 is a classical example.

-------------------------------------------------

-> ## Last words <-

Questions?
