#!/bin/bash

# exclue cpan and build them with native tools like
# dh-make-perl --build --cpan CPAN::Name

# maybe add nix packaging, stuck in debian new queue

# spack packaging
# http://spack.readthedocs.io/en/latest/tutorial_packaging.html#packaging-tutorial

# should do the same with pip using pypi2deb
# py2dsp pythonpkg

# module -V
# pip* -V

for a in apk dpkg rpm nix snap spack 0install flatpak opam cpan module pip2 pip3 brew zypper; do
    which $a &>/dev/null && (
	case $a in
            apk)
                num=$(apk info | wc -l)
            ;;
	    dpkg)
		num=`dpkg -l |grep ^ii |wc -l`
		#num="${num}\n"
		#num="${num}`ls -1 /etc/apt/sources.list.d | sed s/^/\ \ \ \ /g`"
	    ;;
	    rpm)
		# rpm --version | awk '{print $NF}'
		num=`rpm -qa | wc -l`
	    ;;
	    nix)
	    	num=`echo ?`
	    ;;
	    brew)
		num=`brew list| wc -l`
	    ;;
	    pip2)
		num=`pip2 list 2>/dev/null | wc -l`
	    ;;
	    pip3)
		num=`pip3 list 2>/dev/null | wc -l`
	    ;;
	    spack)
		num=`spack find 2>/dev/null |wc -l`
	    ;;
	    snap)
		num=`snap list |sed 1d |wc -l`
	    ;;
	    flatpak)
		num=`flatpak list | wc -l`
	    ;;
	    zypper)
	    	num=`zypper search --installed-only | grep package$ | wc -l`
	    ;;
	    # 0install is braindead
	    #0install)
	    #	num=`0install list |wc -l`
	    #;;
	    *)
		num="n/a"
	    ;;
	esac
	echo -e "$a found... $num"
    ) || echo "$a not found..."
done
