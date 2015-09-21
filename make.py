from distutils.core import setup
from Cython.Build import cythonize

setup(
  name = 'My SNAKES binding',
  ext_modules = cythonize("libsnk.pyx"),
)
