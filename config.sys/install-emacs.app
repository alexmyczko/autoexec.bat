# see https://debbugs.gnu.org/cgi/bugreport.cgi?bug=80090
git clone git://git.sv.gnu.org/emacs.git
cd emacs*/
./autogen.sh
./configure --with-ns
make
make install
# run ./nextstep/Emacs.app/Emacs
# test if M-x is working
