# Debian Packaging
pretty much the same with Ubuntu

2003-2025 Alex Myczko <tar@debian.org>

## Introduction

We will package `mguesser` for Debian. Knowledge about Makefiles, configure and shell scripting or C programming can be very helpful. Man and the manpages are also very useful. Also have a look at `help2man` or `pod2man`. I want to guide you packaging mguesser from the beginning to the end.

## What you will need

A development environment, some utilities and debhelper which we will install like this:

```
# apt-get install binutils cpp cpio dpkg-dev file gcc make patch dh-make debhelper devscripts fakeroot \
                  lintian debian-policy developers-reference man-db manpages reportbug dput-ng decopy
```

(or build-essential lintian debhelper dh-make devscripts fakeroot)
Setting up the environment. Of course you fill in your email address and your full name and choose your favourite editor, these settings is what I use:

```
$ export DEBEMAIL="tar@debian.org"
$ export DEBFULLNAME="Alex Myczko"
$ export EDITOR=mcedit
```

## Choosing software you want to package for Debian

For this course I have chosen mguesser, as I packaged it already and it is not too hard (single binary) to get you started. This should give you an idea what it is like. For Debian the package

- must be DFSG compliant
- must have some public download place (usually http/https, or ftp)
- naming should be software-maj.min.tar.gz and unpacks into software-maj.min/

## Build systems

There are plenty of build systems. The most classical ones are
`make; make install`
`./configure; make; make install`
`mk` (Plan 9)
`cmake` (ccmake is handy sometimes)
`scons`
`qmake` (for qt based software)
`gnustep-make`
`bazel`
Plenty more to check out at https://en.wikipedia.org/wiki/List_of_build_automation_software

## Write an ITP bug report

https://github.com/alexmyczko/autoexec.bat/blob/master/deb2itp

`mail -r $DEBEMAIL -s "ITP: pkg -- shortdescription" submit@bugs.debian.org`

## Ask for XS-Autobuild: yes

non-free and contrib packages are not built by default, if the license allows you can request them to be white listed
for building using an email to

`mail -r $DEBEMAIL -s "non-free/pkgname XS-Autobuild: yes activation" non-free@buildd.debian.org`

## Software without release

https://github.com/alexmyczko/autoexec.bat/blob/master/git2deb

## UDEB

This is a special case of packages for the Debian Installer.

Add `XC-Package-Type: udeb` to the binary part in `debian/control` and set `Section: debian-installer`

## Packaging the software

First you need to get the source of the software. Then put it in some directory. There you unpack the software, usually

```
$ tar xzvf software-2.1.tar.gz
$ ln -s software-2.1.tar.gz software_2.1.orig.tar.gz
$ cd software-2.1/
$ dh_make
```

`dh_make` will make a directory called `debian/` with a few files in it. Now your task is to fill them. I usually start with `control`, then edit `copyright`. There is also `changelog`, `rules`, `dirs` and more. In `rules` you will find some `dh` commands, they are all from debhelper. Each of them has a manpage, please refer to `man debhelper` for details, as well as the Debian New Maintainers' Guide. Read more about the Debian Policy Manual. Updating the `debian/changelog` is done with `dch` or debchange (symlink).

When you think the thing is ready, you can start building the package

The most important files are probably `debian/changelog`, `debian/control`, `debian/copyright`, `debian/rules` and the following ones are helpful
`debian/clean`	files to be removed that get generated at build time (make clean)
`debian/install`	files to be installed
`debian/manpages`	manpage(s) to be installed

Try running `decopy` to get started with a `debian/copyright`

Installing build dependencies can be easily done with `apt build-dep .`

You will find `licensecheck -r . | grep -v UNKNOWN` useful during the writing of `debian/copyright`.

`$ debuild`

If you want to build without tests, prepend your command with `DEB_BUILD_OPTIONS=nocheck`. Use `-S` to only build the source package.

When things are built you should check the package using

`$ lintian -vi mguesser_0.2-1_i386.changes`

If that says all is right (no Warnings or Errors). You can install it with

`$ sudo dpkg -i mguesser_0.2-1_i386.deb`

You must check if the program works. Also make sure the manpage is working.
From what I experienced I will most likely to have go through this several times.

Never forget reportbug, it will be your friend. When you package something from http://www.debian.org/devel/wnpp/requested you can close the bug also with an e-mail to <number>-done@bugs.debian.org. If you don't know what to package, check orphaned packages.

It can be helpful to look at how other packages are packaged

`$ apt-get source package`

And being in touch with upstream is important, contact them somehow.
My debian/ directory for mguesser. Here is my Makefile changes.

Ensuring completeness of Build-Depends
Use `sbuild` to ensure build-depends are complete:
```
apt-get install sbuild
mkdir -p /srv/chroot/sid
sbuild-createchroot --include=eatmydata,ccache,gnupg unstable /srv/chroot/sid http://deb.debian.org/debian
```
Now test your packages with:
`sbuild -d sid yourpackage_version-rev.dsc`

## After Work

Adding a screenshot to the package is recommended: http://screenshots.debian.net/
Check Lintian output: https://lintian.debian.org/
I did not go into detail with `debian/watch`.
Make sure it builds on as many architectures as possible: https://buildd.debian.org/
If your software works with data files, that can be detected with the file(5) utility, send patches for its detection.

## Satisfying build depends

You can either use `apt-get build-dep . # or pkg name` or `mk-build-deps`

## Backports

If you are not on stable but want to create backports for it

```
debootstrap --arch amd64 trixie trixie/
chroot trixie
apt install devscripts lynx -uy
abp srcpkg
```

Automatic Back Port (from sid or .dsc url) https://github.com/alexmyczko/autoexec.bat/blob/master/abp

## Github of Debian

It's called https://salsa.debian.org and based on gitlab. You can download projects from there
using `gbp clone`, and create the orig.tar ball using `gbp export-orig`.

## Enabling auto building for non-free/contrib

Send a mail to non-free@buildd.debian.org
explaining the license allows distributing binary packages.

## When packages.debian.org or tracker.debian.org is slow

Use https://incoming.debian.org for `dget`.

## Other useful links

http://snapshot.debian.org/

http://archive.debian.org/

## Help Debian

Get listed at https://www.debian.org/users/

Install `popularity-contest` and visit https://popcon.debian.org

## Everything else

- https://www.debian.org/doc/manuals/developers-reference/index.en.html
- https://db.debian.org/machines.cgi
- https://release.debian.org/transitions/index.html
- http://packages.debian.org/unstable/main/newpkg
- http://buildd.debian.org/quinn-diff/Packages-arch-specific
- http://www.debian.org/Bugs/Developer#severities
- http://www.debian.org/Bugs/pseudo-packages
- http://bugs.debian.org/release-critical/

## Links

A good source for free software https://github.com, and https://codeberg.org/.
All Debian project participants https://www.debian.org/devel/people

Other packaging systems (ports, pkg, rpm):
- FreeBSD: https://www.freebsd.org/doc/en/books/porters-handbook/
- Solaris: https://docs.oracle.com/cd/E26505_01/html/E28550/ch2buildpkg-17051.html
- RedHat: https://access.redhat.com/sites/default/files/attachments/rpm_building_practice_10082013.pdf
- Fedora: https://docs.fedoraproject.org/en-US/package-maintainers/
- macOS: https://guide.macports.org/#project.contributing
- macOS: https://docs.brew.sh/Formula-Cookbook
- Spack: https://github.com/spack/spack
- pkgx: https://pkgx.sh
- Alpinelinux: https://www.alpinelinux.org
