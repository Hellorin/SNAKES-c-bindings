# SNAKES-c-bindings
C bindings to use the high level Petri net library called SNAKES.

## What is SNAKES ?
> SNAKES is a Python library that provides all the necessary to define and execute many sorts of Petri nets, in particular algrebras of Petri nets. SNAKES' main aim is to be a general Petri net library, being able to cope with most Petri nets models, and providing the researcher with a tool to quickly prototype new ideas.
> 
> -- <cite>Franck Pommereau</cite>

## This project

### Goals
In order to provide a way to simulate High level Petri nets as part as FMUs, a C Petri net library was required. Unfortunately, most of the exisiting one are centered around model checking and not really modelling and simulation. Since it is rather easy to make C bindings for Python and because the library SNAKES exists, C bindings for the latter has been made. 

### Structure
This repository is structured as follow:
* *libsnk.pyx*: actual C binding functions that call the Python SNAKES library
* *_libsnk.py*: file used to keep a Python structure for the C set of Petri nets
* *Makefile*: Makefile used to compile and execute the example and the bindings
* *make.py*: Setup for the generation of the static library of C bindings
* *requirements.txt*: Pip Python libraries requirements needed to compile
* *snktest.c*: Example of usage of the SNAKES C bindings
