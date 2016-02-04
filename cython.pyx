def pyfib(n):
    a, b = 0, 1
    for i in range(n):
        a, b = a + b, a
    return a


# In IPython, try to run it like:
%timeit pyfib(190)

########################################################################

def pyfib(n):
    a, b = 0, 1
    for i in range(n):
        a, b = a + b, a
    return a


def cyfib(int n):
    cdef int i
    cdef long a = 0, b = 1
    for i in range(n):
        a, b = a + b, a
    return a

########################################################################

%load_ext cythonmagic

%%cython
def cyfib(int n):
    cdef int i
    cdef long a = 0, b = 1
    for i in range(n):
        a, b = a + b, a
    return a

%timeit cyfib(190)

########################################################################

from setuptools import setup, Extension
from Cython.Distutils import build_ext

setup(
    cmdclass={'build_ext': build_ext},
    ext_modules=[
        Extension('fib', ['fib.pyx'])],
    classifiers=[
        'Programming Language :: Cython'],
)

########################################################################

a = [x + 1 for x in range(12)]
b = a
a[3] = 42.0
assert b[3] == 42.0
a = 13
assert isinstance(b, list)

########################################################################

def dummy_func():
    cdef int i
    cdef int j
    cdef float k

    j = 0
    i = j
    k = 12.0
    j = 2 * k
    assert i != j

########################################################################

def several_at_once():
    cdef int i, j, k
    cdef float price, margin
    #...

def optional_initial_value():
    cdef int i = 0
    cdef long int j = 0, k = 0
    cdef float price = 0.0, margin = 1.0
    #...

########################################################################

cdef int *p
cdef void **buf = NULL
cdef void (*func)(int, double)

cdef size_t arr[3]

cdef double golden_ratio
cdef double *p_double

p_double = &golden_ratio
p_double[0] = 1.618
print(golden_ratio)
print(p_double[0])

cdef bint ok

########################################################################

cdef struct coord:
    float x
    float y
    float z

cdef union uu:
    int a
    short b, c

ctypedef struct coord:
    #...

ctypedef union uu:
    #...

cdef uu myvar

########################################################################

cdef coord a = coord(0.0, 2.0, 1.5)

cdef coord b = coord(x=0.0, y=2.0, z=1.5)

cdef coord c
c.x = 42.0
c.y = 2.0
c.z = 4.0

cdef coord d = {'x':2.0,
                'y':0.0,
                'z':-0.75}

########################################################################

def cyfib(int n):
    cdef int i
    cdef long a = 0, b = 1
    for i in range(n):
        a, b = a + b, a
    return a

cdef long cyfib(int n):
    #...

cpdef long cyfib(int n):
    #...

########################################################################

from libc.stdlib cimport malloc, free

cdef class Matrix:
    cdef readonly unsigned int nr, nc
    cdef double *_matrix

    def __cinit__(self, nr, nc):
        self.nr, self.nc = nr, nc
        self._matrix = <double*>malloc(nr * nc * sizeof(double))
        if self._matrix == NULL:
            raise MemoryError()

    def __dealloc__(self):
        if self._matrix != NULL:
            free(self._matrix)


########################################################################

sack = {
    'id': 1,
    'count': 15,
    'capacity': 18.5,
    'items': [
        {'weight': 2.0, 'cost': 2.5},
        #...
    ],
}

solver = BruteSolver(sack)
maxcombo, maxcost = solver.solve()

########################################################################

