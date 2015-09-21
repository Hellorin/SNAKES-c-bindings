import snakes.plugins
snakes.plugins.load("gv", "snakes.nets", "snk")
from snk import PetriNet, Place, Transition, Value, MultiArc, dot

nets = {}

