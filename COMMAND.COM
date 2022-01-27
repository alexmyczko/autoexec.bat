#!/bin/bash

# cp to /bin
# and add to /etc/shells
# use chsh to change the shell for users

# rd/md/type/set

export PS1="C:\\>"
ver=0.1

while (sleep 0); do
    echo -n $PS1
    read n

    case $n in
	?:)
	    echo "Drive $n does not exist."
	    echo
	;;
	cd\ *)
	    $n
	    export PS1="C:"$(echo $PWD | sed "s,/,\\\,g"|tr '[:lower:]' '[:upper:]')">"
	;;
	dir*)
	    ls -1
	;;
	ver*/?)
	    echo "View and set the reported DOS version."
	    echo
	    echo "VER"
	    echo
	;;
	ver)
	    echo "DOS version $ver."
	    echo
	;;
	cls*/?)
	;;
	cls)
	    clear
	;;
	mem)
	    free -m
	;;
	exit)
	    exit 0
	;;
	ls*|pwd)
	    echo Illegal command: $n.
	;;
	*)
	    if [ ! "${n}x" = x ]; then
		which $n &>/dev/null && $n || echo "Illegal command: $n."
	    fi
	;;

    esac
done
