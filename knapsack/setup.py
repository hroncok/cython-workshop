#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from setuptools import setup, find_packages, Extension
from Cython.Distutils import build_ext

setup(
    name='knapsack',
    version='0.0.1',
    description='Demo for Cython workshop',
    long_description=''.join(open('README.rst').readlines()),
    keywords='problems, knapsack',
    author='Miro Hrončok',
    author_email='miro@hroncok.cz',
    packages=find_packages(),
    cmdclass={'build_ext': build_ext},
    ext_modules=[Extension('knapsack.csolver', ['knapsack/csolver.pyx'])],
    classifiers=[
        'Intended Audience :: Developers',
        'Operating System :: POSIX :: Linux',
        'Programming Language :: Cython',
        'Programming Language :: Python',
        'Programming Language :: Python :: 3 :: Only',
    ]
)
