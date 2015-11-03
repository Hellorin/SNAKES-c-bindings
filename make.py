'''
    make.py

    File used to be able to compile the C bindings for SNAKES library
    into a static library .so

    David LAWRENCE
'''

from distutils.core import setup
from Cython.Build import cythonize

setup(
  name = 'My SNAKES binding',
  ext_modules = cythonize("libsnk.pyx"),
)
