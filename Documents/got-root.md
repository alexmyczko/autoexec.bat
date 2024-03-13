# Got root?

Installing Software without being root.

So you have got a Linux login, but you’re not root. And you need to install some software, because it is not installed yet.

## Java Software
If you have a Java Runtime Engine installed, just download and unpack the software,
then run it with: `java -jar the.jar`

## Python Software
There’s python2, and there’s python3. And there’s pip2, and pip3 to manage python packages in your `$HOME` directory.
```
pip3 list —user	# list packages installed as user
pip3 install —user pkg	# install package for user
```

## C / Objective-C / C++ Software
```
cmake	# -DCMAKE_INSTALL_PREFIX:PATH=~/you
./configure; make; make install	# use —prefix at configure to set a destination path
make	# you might want to edit the Makefile
```

## DOS Software (.com and .exe, as well as .bat)
Try to run `dosbox .`, and then your software in there

## Windows Software (same like DOS Software)
Try to with `wine your.exe`

## Precompiled Binaries
If you do not have the source. You can find out with `ldd` which libraries the binary is linked against. And use `$LD_LIBRARY_PATH` to provide your own libraries.

## Fonts
Just put them in `~/.fonts`

## PKGX

https://pkgx.sh

## Spack

https://github.com/spack/spack
