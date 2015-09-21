from libc.stdlib cimport malloc, free
from _libsnk import * #PetriNet, Place, Transition, Value, MultiArc, dot, nets

cdef public int newnet (char *name) :
    '''
        Create a new Petri net with a given name

        @param name
            Name of the new Petri net
        @return
            0, if a Petri net with the given name already exist, 1 otherwise
    '''
    if name in nets :
        return 0
    nets[name] = PetriNet(name)
    return 1

cdef public int delnet (char *name) :
    '''
        Delete a Petri net from the Petri nets structure

        @param name
            the name of the Petri net to remove
        @return
            1 if the Petri net was deleted, 0 otherwise
    '''
    try :
        del nets[name]
        return 1
    except :
        return 0

cdef public int addplace (char *net, char *place_name, int tokens) :
    '''
        Add a place with a certain number of tokens to a given Petri net

        @param net
            The name of the Petri net to add a place
        @param place_name
            Name of the place to add
        @param tokens
            Number of tokens in the place created
        @return
            1 if the place was added successfully, 0 otherwise
    '''
    try :
        nets[net].add_place(Place(place_name, tokens*[dot]))
        return 1
    except :
        return 0

cdef public int addtrans (char *net, char *trans_name) :
    '''
        Add a transition to a given Petri net

        @param net
            The name of the Petri net to add a transition
        @param trans_name
            The name of the transition to add
        @return
            1 if the transition was added successfully, 0 otherwise
    '''
    try :
        nets[net].add_transition(Transition(trans_name))
        return 1
    except :
        return 0

cdef public int addarc (char *net, char *src, char *dst, int weight) :
    '''
        Add an arc from a src to a dst with a given weight
        to a given Petri net

        @param net
            The name of the Petri net to add an arc
        @param src
            Name of the source place or the transition of the arc
        @param dst
            Name of the destination place or transition of the arc
        @param weight
            Weight of the arc
        @return
            1 if the arc was added successfully, 0 otherwise
    '''
    try :
        if weight <= 0 :
            return 0
        elif weight == 1 :
            arc = Value(dot)
        else :
            arc = MultiArc([Value(dot) for i in range(weight)])
        if nets[net].has_place(src) :
            nets[net].add_input(src, dst, arc)
        else :
            nets[net].add_output(dst, src, arc)
        return 1
    except :
        return 0

cdef public int getnbtokens (char *net, char *place_name) :
    '''
        Return the number of token of a given place of a given Petri net

        @param net
            Name of the Petri net in which we want to know
            for a given place its number of tokens
        @param place_name
            Name of the place we want to know the number of tokenss
        @return
            The number of tokens if the place exists, -1 otherwise
    '''
    try:
        nbtokens = len(nets[net].place(place_name).tokens)
        return nbtokens
    except:
        return -1 

cdef public int getnbplaces (char *net) :
    '''
        Return the number of places of a given Petri net

        @param net
            Name of the Petri net in which we want to know
            the number of places
        @return
            The number of places of the Petri net with the given name
    '''
    return len(nets[net].place())

cdef public char** getplaces (char *net) :
    '''
        Return the list of places names of a given Petri net

        @param net
            Name of the Petri net for which we want to know
            the places names
        @return
            The list of names of places of the given Petri net
    '''
    nb_places= len(nets[net].get_marking())
    cdef char** places = <char**>malloc(sizeof(char *) * nb_places)
    
    i = 0
    for p in nets[net].place():
        places[i] = p.name
        i += 1

    return places

cdef public int fire(char *net, char* trans_name) :
    '''
        Fire a given transition from a given Petri net

        @param net
            Name of the Petri net for which we want to fire
            a given transition
        @param trans_name
            Name of the transition to be fired
        @return
            Return 1 if a transition was fired,
            0 if the given transition cannot be fired,
            -1 if the transition doesn't exist
    '''
    try:
        transition = nets[net].transition(trans_name)
        if len(transition.modes()):
            transition.fire(nets[net].get_marking())
            return 1
        return 0
    except:
        return -1
        
cdef public int drawnet (char *net, char *target) :
    '''
        Draw a dot file for the given Petri net

        @param net
            The name of the Petri net that must be drawn
        @param target
            The name of the target file
        @return
            1 if the net was drawn successfully, 0 otherwise
    '''
    try :
        nets[net].draw(target)
        return 1
    except :
        return 0
