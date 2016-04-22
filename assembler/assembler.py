R1 = 0x1
R2 = 0x2
R3 = 0x3
R31 = 0x1F

ADD = 0x1
MUL = 0x2

opcode_shift_amount = 28
rs_shift_amount = 23 # assuming 32 (2^5) registers
rt_shift_amount = 18 # assuming 32 registers
rd_shift_amount = 13 # assuming 32 registers
immediate_shift_amount = 0 #NOTE: up to programer not to exceed limit.

#NOTE: all params passed by referance in python.
def modifycommand( command, arg, shift_amount ):
  
  if arg == "ADD":
    command = command | (ADD << shift_amount)
  if arg == "MUL":
    command = command | (MUL << shift_amount)
 
  if arg == "R1":
    command = command | (R1 << shift_amount)
  if arg == "R2":
    command = command | (R2 << shift_amount)
  if arg == "R3":
    command = command | (R3 << shift_amount)
  if arg == "R31":
    command = command | (R31 << shift_amount)
  
  if arg[0:1] == "#":
    command = command | arg[1:] #<< immediate_shift_amount
    #NOTE: up to programer not to exceed limit. currently 2^12.
    #NOTE: this implimentation leads to some "interesting" behavior
  return command


s = "ADD,R1,R2,R31"

argsin = s.split(',')

print argsin
print argsin[0]

command = 0x00000000


command = modifycommand(command, argsin[0], opcode_shift_amount)
command = modifycommand(command, argsin[1], rs_shift_amount)
command = modifycommand(command, argsin[2], rt_shift_amount)
command = modifycommand(command, argsin[3], rd_shift_amount)

print hex(command)
print bin(command)
