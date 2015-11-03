#include "Python.h"
#include "libsnk.h"
#include <stdio.h>

int main (int argc, char *argv[]) {
    Py_Initialize();
    initlibsnk();

    // Create a new Petri net called "test"
    newnet("test");

    // Add a place called A with 1 token
    addplace("test", "A", 1);
    // Add a place called B with 0 token
    addplace("test", "B", 0);

    // Add a transition called T
    addtrans("test", "T");

    // Add a pre arc of weight 1 from A to T
    addarc("test", "A", "T", 1);
    // Add a post arc of weight 1 from T to B
    addarc("test", "T", "B", 1);

    // Return the number of tokens of A of the Petri net "test"
    int nbtokens = getnbtokens("test", "A");

    // Return the list of places of the Petri net "test"
    char** places = getplaces("test");

    // Return the number of places of the Petri net "test"
    int nbplaces = getnbplaces("test");

    // Fire the transition T of the Petri net "test"
    int res = fire("test", "T");
    printf("Result: %d", res);

    // Draw the Petri net "test" to the file "test.eps"
    drawnet("test", "test.eps");

    Py_Finalize();
}
