#This program outputs an assembly text file that can be converted to machine code by assembler.py
#By Conor O'Connell
#designed for python 3 

#use on Conor's home machine: CD /d  E:\EZ\SCHOOL\2016\ECE486
#C:\Users\Bacon\AppData\Local\Programs\Python\Python35-32\python.exe BaseCase_ACG.py >1000testcases.txt

NUM_TEST_CASES = 1000# number of input vectors
NUM_IO = 4 # number of inputs and outputs per iteration

# NUM_CODE_LINES gives the base address (start) of the weights and inputs
# there are 34 instructions before the loop starts.
# there are 48 instructions in the loop.
# there are NUM_TEST_CASES iterations of the loop
# there are 3 instructions after the loop.
NUM_CODE_LINES = 34 + (NUM_TEST_CASES * 48) + 2 #weights start
#INPUT_VECTOR_START_ADDR = 



print (
"""ADDI,R63,R0,#""", NUM_CODE_LINES, """,
ADDI,R62,R0,#0,
LD,R9,R63,#1,
LD,R10,R63,#2,
LD,R11,R63,#3,
LD,R12,R63,#4,
LD,R13,R63,#5,
LD,R14,R63,#6,
LD,R15,R63,#7,
LD,R16,R63,#8,
LD,R17,R63,#9,
LD,R18,R63,#10,
LD,R19,R63,#11,
LD,R20,R63,#12,
LD,R21,R63,#13,
LD,R22,R63,#14,
LD,R23,R63,#15,
LD,R24,R63,#16,
LD,R25,R63,#17,
LD,R26,R63,#18,
LD,R27,R63,#19,
LD,R28,R63,#20,
LD,R29,R63,#21,
LD,R30,R63,#22,
LD,R31,R63,#23,
LD,R32,R63,#24,
LD,R33,R63,#25,
LD,R34,R63,#26,
LD,R35,R63,#27,
LD,R36,R63,#28,
LD,R37,R63,#29,
LD,R38,R63,#30,
LD,R39,R63,#31,
LD,R40,R63,#32,""",
sep = '')
for test_case_number in range(NUM_TEST_CASES):
    print("""LD,R1,R63,#""",33 + test_case_number * NUM_IO,""",
LD,R2,R63,#""",34 + test_case_number * NUM_IO,""",
LD,R3,R63,#""",35 + test_case_number * NUM_IO,""",
LD,R4,R63,#""",36 + test_case_number * NUM_IO,""",
MUL,R49,R1,R9,
MAC,R49,R2,R10,
MAC,R49,R3,R11,
MAC,R49,R4,R12,
SINN,R41,R49,R0,
MUL,R50,R1,R13,
MAC,R50,R2,R14,
MAC,R50,R3,R15,
MAC,R50,R4,R16,
SINN,R42,R50,R0,
MUL,R51,R1,R17,
MAC,R51,R2,R18,
MAC,R51,R3,R19,
MAC,R51,R4,R20,
SINN,R43,R51,R0,
MUL,R52,R1,R21,
MAC,R52,R2,R22,
MAC,R52,R3,R23,
MAC,R52,R4,R24,
SINN,R44,R52,R0,
MUL,R49,R41,R25,
MAC,R49,R42,R26,
MAC,R49,R43,R27,
MAC,R49,R44,R28,
SINN,R5,R49,R0,
ST,R5,R62,#""",0 + test_case_number * NUM_IO,""",
MUL,R50,R41,R29,
MAC,R50,R42,R30,
MAC,R50,R43,R31,
MAC,R50,R44,R32,
SINN,R6,R50,R0,
ST,R6,R62,#""",1 + test_case_number * NUM_IO,""",
MUL,R51,R41,R33,
MAC,R51,R42,R34,
MAC,R51,R43,R35,
MAC,R51,R44,R36,
SINN,R7,R51,R0,
ST,R7,R62,#""",2 + test_case_number * NUM_IO,""",	
MUL,R52,R41,R37,
MAC,R52,R42,R38,
MAC,R52,R43,R39,
MAC,R52,R44,R40,
SINN,R8,R52,R0,
ST,R8,R62,#""",3 + test_case_number * NUM_IO,',',
sep = ''
)
print(
"""NOP,		
HALT,
NOP,""")
