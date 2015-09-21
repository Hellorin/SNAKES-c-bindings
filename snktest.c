#include "Python.h"
#include "libsnk.h"
#include <stdio.h>

int main (int argc, char *argv[]) {
    Py_Initialize();
    initlibsnk();
    newnet("test");
    addplace("test", "A", 1);
    addplace("test", "B", 0);
    addtrans("test", "T");
    addarc("test", "A", "T", 1);
    addarc("test", "T", "B", 1);

    int nbtokens = getnbtokens("test", "A");
    char** places = getplaces("test");
    int nbplaces = getnbplaces("test");

    printf("%d\n", nbplaces);
    for (int i=0;i<nbplaces ; i++) {
        int token = getnbtokens("test", places[i]);     
        printf("%s: %d\n", places[i], token); 
    }
    fire("test", "T");
    drawnet("test", "test.eps");
    Py_Finalize();
}
