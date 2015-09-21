PYTHON=python2.7
VIEWER=evince

snktest: snktest.c libsnk.so
	gcc -std=c99 -I/usr/include/$(PYTHON) -L. -o snktest snktest.c -lsnk -l$(PYTHON) 

libsnk.so: libsnk.pyx
	python make.py build_ext --inplace

clean:
	rm -rf libsnk.h libsnk.c libsnk.so *.pyc snktest build *~ test.eps

test.eps: clean snktest
	LD_LIBRARY_PATH=. ./snktest
	$(VIEWER) test.eps
