import os
import time
import glob
import json

import matplotlib.pyplot as plt

from . import dataloader
from . import csolver
from . import solver


def solve(impl='python'):
    if impl == 'cython':
        solvercls = csolver.CBruteSolver
    else:
        solvercls = solver.BruteSolver
    try:
        os.mkdir('data/' + impl)
    except FileExistsError:
        pass
    for filename in sorted(glob.glob('data/*.inst.dat')):
        print(filename)
        loaded_data = list(dataloader.load_input(filename))
        count = loaded_data[0]['count']
        correct = list(dataloader.load_provided_results(
            'data/knap_{0:02d}.sol.dat'.format(count)))
        outname = filename.replace('.inst.dat', '.results.jsons')
        outname = outname.replace('data/', 'data/' + impl + '/')
        with open(outname, 'w') as f:
            filestartime = time.process_time()
            for idx, backpack in enumerate(loaded_data):
                startime = time.process_time()
                s = solvercls(backpack)
                backpack['maxcombo'], backpack['maxcost'] = s.solve()
                endtime = time.process_time()
                delta = endtime - startime
                backpack['time'] = delta
                assert backpack['maxcost'] == correct[idx]['maxcost']
                del backpack['items']
                f.write(json.dumps(backpack) + '\n')
            fileendtime = time.process_time()
            delta = fileendtime - filestartime
            f.write('{}\n'.format(delta))


def get_x_y_times(g):
    x = []
    y = []
    for filename in glob.glob(g):
        results, avg = dataloader.load_jsons_results(filename)
        try:
            count = results[0]['count']
        except IndexError:
            # empty file
            continue
        x.append(count)
        y.append(avg)
    return x, y


def plot_times():
    plt.title('Time consumption based on problem size')
    plt.xlabel('problem size (number of possible items)')
    plt.ylabel('time (s)')

    x, y = get_x_y_times('data/python/*.results.jsons')
    plt.plot(x, y, 'bo')

    x, y = get_x_y_times('data/cython/*.results.jsons')
    plt.plot(x, y, 'yo')

    plt.axes().set_yscale('log')
    plt.axes().legend(['Python', 'Cython'], loc='upper left')
    plt.grid(True)
    plt.savefig('times.pdf')
