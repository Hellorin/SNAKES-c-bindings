#include "Python.h"
#include "libsnk.h"
#include <stdio.h>

int main (int argc, char *argv[]) {
    Py_Initialize();
    initlibsnk();
    newnet("test");
    addplace_f("test", "A", 1);
    addplace_f("test", "B", 0);
    addtrans("test", "T");
    addarc_f("test", "A", "T", 1);
    addarc_f("test", "T", "B", 1);

    int nbtokens = getnbtokens("test", "A");
    char** places = getplaces("test");
    int nbplaces = getnbplaces("test");

    /*printf("%d\n", nbplaces);
    for (int i=0;i<nbplaces ; i++) {
        int token = getnbtokens("test", places[i]);     
        printf("%s: %d\n", places[i], token);
    }*/
    int res=fire("test", "T");
    printf("Result: %d", res);
    drawnet("test", "test.eps");
    Py_Finalize();
}
