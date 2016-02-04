with open('cython.tex') as f:
    read = False
    for line in f.readlines():
        if '\\begin{lstlisting}' in line:
            read = True
            continue
        if '\\end{lstlisting}' in line:
            read = False
            print()
            print('#' * 72)
            print()
            continue
        if read:
            print(line, end='')

