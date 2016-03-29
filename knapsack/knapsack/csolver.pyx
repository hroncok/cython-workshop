from libc.stdlib cimport malloc, free

cdef struct item:
    double weight
    double cost


cdef class CBruteSolver:
    '''
    Bruteforce solver for the sack problem
    '''

    cdef int numitems
    cdef double capacity 
    cdef item *_items

    def __cinit__(self, sack):
        '''
        Takes a sack dict as returned by DataLoader
        '''
        cdef size_t i
        self.numitems = sack['count']
        self.capacity = sack['capacity']
        self._items = <item*>malloc(self.numitems * sizeof(item))
        if self._items == NULL:
            raise MemoryError()
        for i in range(self.numitems):
            self._items[i] = sack['items'][i]

    def __dealloc__(self):
        if self._items != NULL:
            free(self._items)

    def int2list(self, int n):
        cdef int i
        l = []
        for i in range(self.numitems):
            l.append(n & 1 == 1)
            n >>= 1
        return l

    cdef item weight_and_cost(self, int combo):
        cdef item ret
        cdef int i, tmpcombo

        tmpcombo = combo
        ret.weight = 0.0
        ret.cost = 0.0

        for i in range(self.numitems):
            if (tmpcombo & 1 == 1):
                ret.weight += self._items[i].weight
                ret.cost += self._items[i].cost
            tmpcombo >>= 1
        return ret

    def solve(self):
        '''
        Main rutine, solves the problem,
        returns the combination with maximal cost and the cost
        '''
        cdef double maxcost
        cdef int num, maxcombo = 0
        cdef item wc
        maxcost = -1.0
        for num in range(2 ** self.numitems):
            wc = self.weight_and_cost(num)
            if wc.weight <= self.capacity and wc.cost > maxcost:
                maxcost = wc.cost
                maxcombo = num
        
        return self.int2list(maxcombo), maxcost
