/*
https://www.basicinputoutput.com/2024/11/the-keyboard-controller-interface.html
*/

#include <unistd.h>
#include <stdio.h>

#ifdef BSD
#include <err.h>
#include <machine/sysarch.h>
#include <machine/cpufunc.h>
#else
#include <sys/io.h>
#endif

int main(int argc, char** argv)
{
    /* iopl()
       inb() */
    if (getuid()!=0) {
        printf("Must be root to run %s, you're only %u.\n",argv[0],getuid());
        return 1;
    }

#ifdef BSD
    if (i386_set_ioperm(0x60,5,1) == -1)
        err(1,"i386_set_ioperm failed");
#else
    iopl(3);
#endif

    outb(0xFE,0x64);

    return 0;
}
