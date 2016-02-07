knapsack
========

A demo for Cython workshop. This is a `knapsack problem <https://en.wikipedia.org/wiki/Knapsack_problem>`_ solver. A very naive one using brute force. It was implemented in pure Python and you can find it in ``knapsack/solver.py``. The very same code lives in ``knapsack/csolver.pyx`` waiting to be optimized by you. Your goal is not to optimize the algorithm itself, let's keep it naive as it is, but try to speed up the implementation as much as possible by using static typing a C structs.

Usage
-----

To compile the ``.pyx`` file into a module extension, run the following::

    python3 setup.py build_ext --inplace

To run the Python implementation on example data, run::

    python3 -c 'import knapsack; knapsack.solve("python")'

The data are processed from the smallest problem size to the largest. Feel free to Ctrl+C at any point when you feel the time is over a reasonable waiting period.

Similarly  run the Cython implementation by::

    python3 -c 'import knapsack; knapsack.solve("cython")'

After you update the code, don't forget to rebuild it! The same thing applies about Ctrl+C'ing. If you screw up somehow and the data are not correct, you should get an ``AssertinError``.

Annotate your Cython code and see what's yellow::

   cython3 --annotate knapsack/csolver.pyx # see knapsack/csolver.html

Once you gather some data, you can plot the time results as follows::

    python3 -c 'import knapsack; knapsack.plot_times()'

You'll need ``matplotlib`` for that. Even with identical code, Cython should give you some boost for free. Have fun.
