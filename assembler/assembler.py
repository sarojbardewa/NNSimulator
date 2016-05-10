# use (in linux): python assembler.py | unix2dos.exe > output.txt

R0 = 0x0
R1 = 0x1
R2 = 0x2
R3 = 0x3
R4 = 0x4
R5 = 0x5
R6 = 0x6
R7 = 0x7
R8 = 0x8
R9 = 0x9
R10 = 0xa
R11 = 0xb
R12 = 0xc
R13 = 0xd
R14 = 0xe
R15 = 0xf
R16 = 0x10
R17 = 0x11
R18 = 0x12
R19 = 0x13
R20 = 0x14
R21 = 0x15
R22 = 0x16
R23 = 0x17
R24 = 0x18
R25 = 0x19
R26 = 0x1a
R27 = 0x1b
R28 = 0x1c
R29 = 0x1d
R30 = 0x1e
R31 = 0x1f
R32 = 0x20
R33 = 0x21
R34 = 0x22
R35 = 0x23
R36 = 0x24
R37 = 0x25
R38 = 0x26
R39 = 0x27
R40 = 0x28
R41 = 0x29
R42 = 0x2a
R43 = 0x2b
R44 = 0x2c
R45 = 0x2d
R46 = 0x2e
R47 = 0x2f
R48 = 0x30
R49 = 0x31
R50 = 0x32
R51 = 0x33
R52 = 0x34
R53 = 0x35
R54 = 0x36
R55 = 0x37
R56 = 0x38
R57 = 0x39
R58 = 0x3a
R59 = 0x3b
R60 = 0x3c
R61 = 0x3d
R62 = 0x3e
R63 = 0x3f


NOP = 0x0
ADD = 0x1
MUL = 0x2
SINN = 0x3
SGT = 0x3
MAC = 0x4
ADDI = 0x9
#J = 0xA
LD = 0xE
ST = 0xF
HALT = 0xB

opcode_shift_amount = 28
rs_shift_amount = 22 # assuming 64 (2^6) registers
rt_shift_amount = 16 # assuming 64 registers
rd_shift_amount = 10 # assuming 64 registers
immediate_shift_amount = 0 #NOTE: up to programer not to exceed limit.

#NOTE: all params passed by referance in python.
def modifycommand( command, arg, shift_amount ):
  
  if arg == "NOP":
    return 0x00000000
  if arg == "ADD":
    command = command | (ADD << shift_amount)
  if arg == "ADDI":
    command = command | (ADDI << shift_amount)
  if arg == "MUL":
    command = command | (MUL << shift_amount)
  if arg == "SINN":
    command = command | (SINN << shift_amount)
  if arg == "SGT":
    command = command | (SGT << shift_amount)
  if arg == "MAC":
    command = command | (MAC << shift_amount)
#  if arg == "J":
#    command = command | (J << shift_amount)
  if arg == "ST":
    command = command | (ST << shift_amount)
  if arg == "LD":
    command = command | (LD << shift_amount)
  if arg == "HALT":
    command = command | (HALT << shift_amount)
  
 
  if arg == "R0":
    command = command | (R0 << shift_amount)
  if arg == "R1":
    command = command | (R1 << shift_amount)
  if arg == "R2":
    command = command | (R2 << shift_amount)
  if arg == "R3":
    command = command | (R3 << shift_amount)
  if arg == "R4":
    command = command | (R4 << shift_amount)
  if arg == "R5":
    command = command | (R5 << shift_amount)
  if arg == "R6":
    command = command | (R6 << shift_amount)
  if arg == "R7":
    command = command | (R7 << shift_amount)
  if arg == "R8":
    command = command | (R8 << shift_amount)
  if arg == "R9":
    command = command | (R9 << shift_amount)
  if arg == "R10":
    command = command | (R10 << shift_amount)
  if arg == "R11":
    command = command | (R11 << shift_amount)
  if arg == "R12":
    command = command | (R12 << shift_amount)
  if arg == "R13":
    command = command | (R13 << shift_amount)
  if arg == "R14":
    command = command | (R14 << shift_amount)
  if arg == "R15":
    command = command | (R15 << shift_amount)
  if arg == "R16":
    command = command | (R16 << shift_amount)
  if arg == "R17":
    command = command | (R17 << shift_amount)
  if arg == "R18":
    command = command | (R18 << shift_amount)
  if arg == "R19":
    command = command | (R19 << shift_amount)
  if arg == "R20":
    command = command | (R20 << shift_amount)
  if arg == "R21":
    command = command | (R21 << shift_amount)
  if arg == "R22":
    command = command | (R22 << shift_amount)
  if arg == "R23":
    command = command | (R23 << shift_amount)
  if arg == "R24":
    command = command | (R24 << shift_amount)
  if arg == "R25":
    command = command | (R25 << shift_amount)
  if arg == "R26":
    command = command | (R26 << shift_amount)
  if arg == "R27":
    command = command | (R27 << shift_amount)
  if arg == "R28":
    command = command | (R28 << shift_amount)
  if arg == "R29":
    command = command | (R29 << shift_amount)
  if arg == "R30":
    command = command | (R30 << shift_amount)
  if arg == "R31":
    command = command | (R31 << shift_amount)
  if arg == "R32":
    command = command | (R32 << shift_amount)
  if arg == "R33":
    command = command | (R33 << shift_amount)
  if arg == "R34":
    command = command | (R34 << shift_amount)
  if arg == "R35":
    command = command | (R35 << shift_amount)
  if arg == "R36":
    command = command | (R36 << shift_amount)
  if arg == "R37":
    command = command | (R37 << shift_amount)
  if arg == "R38":
    command = command | (R38 << shift_amount)
  if arg == "R39":
    command = command | (R39 << shift_amount)
  if arg == "R40":
    command = command | (R40 << shift_amount)
  if arg == "R41":
    command = command | (R41 << shift_amount)
  if arg == "R42":
    command = command | (R42 << shift_amount)
  if arg == "R43":
    command = command | (R43 << shift_amount)
  if arg == "R44":
    command = command | (R44 << shift_amount)
  if arg == "R45":
    command = command | (R45 << shift_amount)
  if arg == "R46":
    command = command | (R46 << shift_amount)
  if arg == "R47":
    command = command | (R47 << shift_amount)
  if arg == "R48":
    command = command | (R48 << shift_amount)
  if arg == "R49":
    command = command | (R49 << shift_amount)
  if arg == "R50":
    command = command | (R50 << shift_amount)
  if arg == "R51":
    command = command | (R51 << shift_amount)
  if arg == "R52":
    command = command | (R52 << shift_amount)
  if arg == "R53":
    command = command | (R53 << shift_amount)
  if arg == "R54":
    command = command | (R54 << shift_amount)
  if arg == "R55":
    command = command | (R55 << shift_amount)
  if arg == "R56":
    command = command | (R56 << shift_amount)
  if arg == "R57":
    command = command | (R57 << shift_amount)
  if arg == "R58":
    command = command | (R58 << shift_amount)
  if arg == "R59":
    command = command | (R59 << shift_amount)
  if arg == "R60":
    command = command | (R60 << shift_amount)
  if arg == "R61":
    command = command | (R61 << shift_amount)
  if arg == "R62":
    command = command | (R62 << shift_amount)
  if arg == "R63":
    command = command | (R63 << shift_amount)
  
  if arg[0:1] == "#":
    command = command | int(arg[1:]) #<< immediate_shift_amount
    #NOTE: up to programer not to exceed limit. currently 2^12.
    #NOTE: this implimentation leads to some "interesting" behavior

  if arg[0:2] == "0x":
    command = command | int(arg[2:], 16)
    
  return command

def output_command( sline ):
  #sline = "ADD,R1,R2,R31"

  argsin = sline.split(',')

# print argsin
# print argsin[0]

  command = 0x00000000
  field_order = [opcode_shift_amount,
                 rs_shift_amount,
                 rt_shift_amount,
                 rd_shift_amount]
  arglen = len(argsin)

  for field in range(arglen):
    command = modifycommand(command, argsin[field], field_order[field])
# command = modifycommand(command, argsin[0], opcode_shift_amount)
# command = modifycommand(command, argsin[1], rs_shift_amount)
# command = modifycommand(command, argsin[2], rt_shift_amount)
# command = modifycommand(command, argsin[3], rd_shift_amount)
# if argsin[4]
#
# command = modifycommand(command, argsin[3], rd_shift_amount)
#
#
# print hex(command)
# print bin(command)
  return command

#http://stackoverflow.com/questions/7165749/open-file-in-a-relative-location-in-python
#http://stackoverflow.com/questions/4934806/how-can-i-find-scripts-directory-with-python
import os
script_dir = os.path.dirname(os.path.realpath(__file__)) #<-- absolute dir the script is in
rel_path = "inputfile.txt"
abs_file_path = os.path.join(script_dir, rel_path)


with open(abs_file_path) as f:
 for lines in f:
    print hex(output_command(lines)).lstrip("0x").zfill(8)


