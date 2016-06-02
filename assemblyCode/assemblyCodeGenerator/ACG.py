# use (in linux): python ACG.py | unix2dos.exe > output.txt
HMM = """
INPUT_VAL_ADDR
HIDDEN_VAL_ADDR
OUTPUT_VAL_ADDR

INPUT_WEIGHT_ADDR
HIDDEN_WEIGHT_ADDR
OUTPUT_WEIGHT_ADDR

NUM_INPUT
NUM_HIDDEN
NUM_OUTPUT
"""
# set R13-15

INPUT_VAL_ADDR = 0
INPUT_WEIGHT_ADDR = 0

HIDDEN_VAL_ADDR = 0
HIDDEN_WEIGHT_ADDR = 0

OUTPUT_VAL_ADDR = 0 # need to calc
#OUTPUT_WEIGHT_ADDR = 0

NUM_INPUT = 3
NUM_HIDDEN = 3
NUM_OUTPUT = 3

NUM_TEST_CASES = 3

def calc_node(node_val_temp_reg,
              node_val_base_addr_reg,
              node_val_offset,
              weight_val_temp_reg,
              weight_base_addr_reg,
              node_weight_offset,
              mac_reg,
              ):
    print ('LD,',node_val_temp_reg,',',node_val_base_addr_reg,',#',node_val_offset, sep='')
    print ('LD,',weight_val_temp_reg,',',weight_base_addr_reg,',#',node_weight_offset, sep='')
    print ('MAC,',mac_reg,',',weight_val_temp_reg,',',node_val_temp_reg, sep='')

    return 0

def calc_node_vector(node_val_temp_reg,
                     node_val_base_addr_reg,
                     node_val_offset,
                     weight_val_temp_reg,
                     weight_base_addr_reg,
                     node_weight_offset,
                     mac_reg,
                     num_nodes_Ln,
                     num_nodes_Lnp1,
                     nodes_Lnp1_addr,
                     node_num,
                     test_case_number,
                     storage_val_base_addr_reg,
                     ):
    print("ADDI,",mac_reg,",R0,#0", sep='') # zero out the MAC register
    for offset in range(num_nodes_Ln): # then loop over each input node and its weight #offset = input & weight number
        calc_node(node_val_temp_reg,
                  node_val_base_addr_reg,
                  offset + node_val_offset,
                  weight_val_temp_reg,
                  weight_base_addr_reg,
                  offset + (node_num*num_nodes_Lnp1),
                  mac_reg)
    print("SINN,",mac_reg,",",mac_reg, sep='') #and then regularize it...
    print("ST,",mac_reg,",",storage_val_base_addr_reg,",#",(nodes_Lnp1_addr + node_num + (test_case_number * NUM_TEST_CASES)), sep='') #... and store it.
    return 0

#the double loop:
def calc_test_case(node_val_temp_reg,
                   input_val_base_addr_reg,
                   input_node_val_offset,
                   weight_val_temp_reg,
                   input_weight_base_addr_reg,
                   input_node_weight_offset,
                   hidden_val_base_addr_reg,
                   hidden_node_val_offset,
                   hidden_weight_base_addr_reg,
                   hidden_node_weight_offset,
                   mac_reg,
                   NUM_HIDDEN,
                   NUM_OUTPUT,
                   OUTPUT_VAL_ADDR,
                   test_case_number,
                   output_val_base_addr_reg,
                   ):
    
    #loop over each input to calculate each hidden node,
    for node_num in range(NUM_HIDDEN): #for each hidden node (node_num = hidden node number (zero indexed))
        calc_node_vector(node_val_temp_reg,
                         input_val_base_addr_reg,
                         input_node_val_offset,
                         weight_val_temp_reg,
                         input_weight_base_addr_reg,
                         input_node_weight_offset,
                         mac_reg,
                         NUM_INPUT,
                         NUM_HIDDEN,
                         HIDDEN_VAL_ADDR,
                         node_num,
                         test_case_number,
                         hidden_val_base_addr_reg,
                         )
    #... then loop over each hidden node to calculate each output node.
    for node_num in range(NUM_OUTPUT):
        calc_node_vector(node_val_temp_reg,
                         hidden_val_base_addr_reg,
                         hidden_node_val_offset,
                         weight_val_temp_reg,
                         hidden_weight_base_addr_reg,
                         hidden_node_weight_offset,
                         mac_reg,
                         NUM_HIDDEN,
                         NUM_OUTPUT,
                         OUTPUT_VAL_ADDR,
                         node_num,
                         test_case_number,
                         output_val_base_addr_reg,
                         )
    return 0



node_val_temp_reg = "R1"
weight_val_temp_reg = "R2"
node_weight_offset = 0
mac_reg = "R3"


#node_val_offset = 0
input_node_val_offset = 0
hidden_node_val_offset = 0

input_node_weight_offset = 0
hidden_node_weight_offset = 0

input_val_base_addr_reg     ='R11'
input_weight_base_addr_reg  ='R12'
hidden_val_base_addr_reg    ='R13'
hidden_weight_base_addr_reg ='R14'
output_val_base_addr_reg    ='R15'


#hidden_node_base_addr_storage_reg ='R13'
#output_node_base_addr_storage_reg ='R15'

#node_val_base_addr_reg
#weight_base_addr_reg = 12




#here begins the actual code:

#preamble: set base regs
print('ADDI,',input_val_base_addr_reg,",R0,#",INPUT_VAL_ADDR, sep='')
print('ADDI,',input_weight_base_addr_reg,",R0,#",INPUT_WEIGHT_ADDR, sep='')
#print('ADDI,',hidden_val_base_addr_reg,",R0,#",HIDDEN_VAL_ADDR, sep='') # replace node_val_base_addr_reg with real final value
#print('ADDI,',hidden_weight_base_addr_reg,",R0,#",HIDDEN_WEIGHT_ADDR, sep='')
#print('ADDI,',output_val_base_addr_reg,",R0,#",OUTPUT_VAL_ADDR, sep='')


for test_case_number in range(NUM_TEST_CASES):
    calc_test_case(node_val_temp_reg,           #const
                   input_val_base_addr_reg,     #text
                   input_node_val_offset + (test_case_number * NUM_INPUT),    #this is the onw that changes over the test cases
                   weight_val_temp_reg,         #const
                   input_weight_base_addr_reg,  #text
                   input_node_weight_offset,    #not really needed at his level?
                   hidden_val_base_addr_reg,    #text
                   hidden_node_val_offset,      #not really needed at his level?
                   hidden_weight_base_addr_reg, #text
                   hidden_node_weight_offset,   #const
                   mac_reg,                     #const
                   NUM_HIDDEN,                  #const
                   NUM_OUTPUT,                  #const
                   OUTPUT_VAL_ADDR,             #const
                   test_case_number,
                   output_val_base_addr_reg,
                   )
