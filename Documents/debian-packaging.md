#### markdown conversion of
#### https://www.icloud.com/pages/0LWQ2LkV15Hvi49zYRwzS1AcA#Debian-Packaging

# Debian Packaging
pretty much the same with Ubuntu

2003-2021 Gürkan Myczko <tar@debian.org>

## Introduction

We will package `mguesser` for Debian. Knowledge about Makefiles, configure and shell scripting or C programming can be very helpful. Man and the manpages are also very useful. Also have a look at `help2man` or `pod2man`. I want to guide you packaging mguesser from the beginning to the end.

## What you will need

A development environment, some utilities and debhelper which we will install like this:

```
# apt-get install binutils cpp cpio dpkg-dev file gcc make patch \
                  dh-make debhelper devscripts fakeroot lintian \
                  debian-policy developers-reference \
		  man-db manpages reportbug dput-ng
```

(or build-essential lintian debhelper dh-make devscripts fakeroot)
Setting up the environment, see www.linuks.mine.nu/conf/. Of course you fill in your email address and your full name and choose your favourite editor, these settings is what I use:

```
$ export DEBEMAIL="tar@debian.org"
$ export DEBFULLNAME="Gürkan Myczko"
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

You will find `licensecheck -r . | grep -v UNKNOWN` useful during the writing of `debian/copyright`.

`$ debuild`

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
Tagging the package is also a good idea: https://debtags.debian.org/
Check Lintian output: https://lintian.debian.org/
I did not go into detail with `debian/watch`.
Make sure it builds on as many architectures as possible: https://buildd.debian.org/
If your software works with data files, that can be detected with the file(5) utility, send patches for its detection.

## Links

A good source for free software https://github.com
All Debian project participants www.debian.org/devel/people

Other packaging systems (ports, pkg, rpm)
Freebsd: https://www.freebsd.org/doc/en/books/porters-handbook/
Solaris: https://docs.oracle.com/cd/E26505_01/html/E28550/ch2buildpkg-17051.html
RedHat: https://access.redhat.com/sites/default/files/attachments/rpm_building_practice_10082013.pdf
macOS: https://guide.macports.org/#project.contributing
Spack: https://github.com/spack/spack
flatpak/flathub: https://flatpak.org/ / https://flathub.org/
Ubuntu Snap: https://snapcraft.io/
