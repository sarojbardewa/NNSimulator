# use (in linux): python ACG.py | unix2dos.exe > output.txt

for a in range(64):
    b= hex(a)
    print ('  if arg == "R',a,'":', sep='')
    print('    command = command | (R',a,' << shift_amount)', sep='')
