%title: Debian on Apple M1 and M2 - mdp presentation %author: Alex Myczko tar@debian.org %date: 2024-05-18

-> Debian on Apple M1 and M2 <-

I will go through these steps with you:

Overview, what is Asahi Linux?
Statistics
History
Why no M3 support?
Magic Surprise
Questions?

---

-> Overview, what is Asahi Linux? <-

NeXT.com (Apple) did bring out arm64 (some call it aarch64) SOC computers
in 2020.

Originally it was an Arch Linux distribution, but the rest did not sleep,
a few months ago they switched to Fedora.

https://wiki.debian.org/InstallingDebianOn/Apple/M1

Someone created a Debian installer, then came the packages, and #debian-bananas
as well as http://bananas.debian.net

Eight persons work on Asahi Linux. They have got IRC and a web page,
sources can be found on https://github.com

Future https://social.treehouse.systems/@marcan/112277289414246878

---

-> Statistics <-

An excerpt 490 GB (sid), 31k source packages, 2129 million lines of source code.
Nearly 23 million source files.

42 % ANSI C
26 % C++
5 % Java
3.9 % Shell
4.7 % Python
19.3 % not so important languages
More than 6000 people worked on it, I do since 2001. It's currently about 1.2k
people working on it. Active bugs 180k, Archived 840k. The bug tracking BTS is
open (we have a mirror). Debian also rebuilds its archive with clang regularly
https://clang.debian.net/

See https://sources.debian.org/stats/

According to buildd stats, https://buildd.debian.org/stats/graph-week-big.png
there is ~99 % built packages for arm64.

---

-> Why no M3 support? <-

https://github.com/AsahiLinux/docs/wiki/M3-Series-Feature-Support

M4 arrived for iPad, but not the computers yet, that will certainly change.

So what works? It is pretty well documented:

https://github.com/AsahiLinux/docs/wiki/M1-Series-Feature-Support

https://github.com/AsahiLinux/docs/wiki/M2-Series-Feature-Support

---

-> One More Thing <-

So I've always been unhappy with Debian not being popular. No wonder,
there is no commercial for it after all.

Here is one, enjoy! Made with shotcut, a free software video editor,
that has great documentation.

And do not forget, install popularity-contest.

---

-> ## Last words <-

Questions?
