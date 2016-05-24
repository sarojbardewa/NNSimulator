/*This is the articifical neural network in c 
   Saroj Bardewa
   Spring 2016
   ECE 586
*/

 #include <stdlib.h>
 #include <stdio.h>
 #include <time.h>

 #define REGS 		64
 #define INPUTS 	4
 #define OUTPUTS 	4
 #define WEIGHTS    16

 enum registers
 {
 	R1,R2,R3,R4,R5,R6,R7,R8,R9,
 	R10,R11,R12,R13,R14,R15,R16,R17,R18,R19,
 	R20,R21,R22,R23,R24,R25,R26,R27,R28,R29,
 	R30,R31,R32,R33,R34,R35,R36,R37,R38,R39,
 	R40,R41,R42,R43,R44,R45,R46,R47,R48,R49,
 	R50,R51,R52,R53,R54,R55,R56,R57,R58,R59,
 	R60,R61,R62,R63,R64
 };

 int main(int argc, char *argv[])
 {
 	int loopVar;
 	int regs[REGS];
 	int in[INPUTS];
 	int out[OUTPUTS];
 	int inWeight[WEIGHTS];      /* Weights between ins and hidden layer*/
 	int outWeight[WEIGHTS];     /* Weights between out and hidden layer*/

 	if(argc >2)
  	{
  		printf("Must Pass an argument !\n");
  		return -1;
    }
// Random inner in 
printf("\n**** Inputs****\n");
for(loopVar = 0; loopVar<INPUTS;++loopVar)
{
	srand(clock());
	in[loopVar] = 1;  		// Generate 32 random weights -1, 0 or 1//
	//in[loopVar] = 0;
	regs[loopVar+R1] = in[loopVar];  // Registers from R1-R4 
	//printf("%d \n",in[loopVar]);
}

printf(" regs[R1] = %d\n", regs[R1]);
printf(" regs[R2] = %d\n", regs[R2]);
printf(" regs[R3] = %d\n", regs[R3]);
printf(" regs[R4] = %d\n", regs[R4]);



// Random weights of Neuron i
printf("\n**** Inputs-Hidden nodes Weights****\n");
for(loopVar = 0; loopVar<WEIGHTS;++loopVar)
{
	srand(clock());
	inWeight[loopVar] = rand()%3 -1;  		 //Generate 32 random weights -1, 0 or 1
	//inWeight[loopVar] = 1;
	regs[loopVar+R9]   = inWeight[loopVar];  // Registers from R9-R24 are weights between layer 1 and layer 2 
	//printf("%d   %d\n",inWeight[loopVar], regs[loopVar+R9]);
}
printf(" regs[R9]  = %d\n", regs[R9]);
printf(" regs[R10] = %d\n", regs[R10]);
printf(" regs[R11] = %d\n", regs[R11]);
printf(" regs[R12] = %d\n", regs[R12]);
printf(" regs[R13] = %d\n", regs[R13]);
printf(" regs[R14] = %d\n", regs[R14]);
printf(" regs[R15] = %d\n", regs[R15]);
printf(" regs[R16] = %d\n", regs[R16]);
printf(" regs[R17] = %d\n", regs[R17]);
printf(" regs[R18] = %d\n", regs[R18]);
printf(" regs[R19] = %d\n", regs[R19]);
printf(" regs[R20] = %d\n", regs[R20]);
printf(" regs[R21] = %d\n", regs[R21]);
printf(" regs[R22] = %d\n", regs[R22]);
printf(" regs[R23] = %d\n", regs[R23]);
printf(" regs[R24] = %d\n", regs[R24]);

//Random weights of Neuron j
printf("\n****Hidden Nodes-Outputs Weights****\n");
for(loopVar = 0; loopVar<WEIGHTS;++loopVar)
{
	srand(clock());
	outWeight[loopVar] = rand()%3 -1;  		 // Generate 32 random weights -1, 0 or 1
	//outWeight[loopVar] = 1;
	regs[loopVar+R25] =outWeight[loopVar];   // Registers from R25-R40 are weights between layer 2 and layer 3
	//printf("%d   %d\n",outWeight[loopVar], regs[loopVar+R25]);
}

printf(" regs[R25] = %d\n", regs[R25]);
printf(" regs[R26] = %d\n", regs[R26]);
printf(" regs[R27] = %d\n", regs[R27]);
printf(" regs[R28] = %d\n", regs[R28]);
printf(" regs[R29] = %d\n", regs[R29]);
printf(" regs[R30] = %d\n", regs[R30]);
printf(" regs[R31] = %d\n", regs[R31]);
printf(" regs[R32] = %d\n", regs[R32]);
printf(" regs[R33] = %d\n", regs[R33]);
printf(" regs[R34] = %d\n", regs[R34]);
printf(" regs[R35] = %d\n", regs[R35]);
printf(" regs[R36] = %d\n", regs[R36]);
printf(" regs[R37] = %d\n", regs[R37]);
printf(" regs[R38] = %d\n", regs[R38]);
printf(" regs[R39] = %d\n", regs[R39]);
printf(" regs[R40] = %d\n", regs[R40]); 
// Calculation of layer 1 and 2
regs[R41]  = regs[R1]*regs[R9] +regs[R2]*regs[R10]+regs[R3]*regs[R11]+regs[R4]*regs[R12];
regs[R42]  = regs[R1]*regs[R13]+regs[R2]*regs[R14]+regs[R3]*regs[R15]+regs[R4]*regs[R16];
regs[R43]  = regs[R1]*regs[R17]+regs[R2]*regs[R18]+regs[R3]*regs[R19]+regs[R4]*regs[R20];
regs[R44]  = regs[R1]*regs[R21]+regs[R2]*regs[R22]+regs[R3]*regs[R23]+regs[R4]*regs[R24];
//printf("Hidden Neuron values = %d  %d %d %d \n" ,regs[R41],regs[R42],regs[R43],regs[R44]);
     
     /* Computee the final output value */
     regs[R41] = (regs[R41] >= 0) ? 1:0;
     regs[R42] = (regs[R42] >= 0) ? 1:0;
     regs[R43] = (regs[R43] >= 0) ? 1:0;
     regs[R44] = (regs[R44] >= 0) ? 1:0;
     
     
printf("***Hidden Neuron Values After Calculation***\n");
printf(" regs[R41] = %d\n", regs[R41]);
printf(" regs[R42] = %d\n", regs[R42]);
printf(" regs[R43] = %d\n", regs[R43]);
printf(" regs[R44] = %d\n", regs[R44]);
// Calculation of layer 2 and layer 3 
regs[R45]  = regs[R41]*regs[R25]+regs[R42]*regs[R26]+regs[R43]*regs[R27]+regs[R44]*regs[R28];
regs[R46]  = regs[R41]*regs[R29]+regs[R42]*regs[R30]+regs[R43]*regs[R31]+regs[R44]*regs[R32];
regs[R47]  = regs[R41]*regs[R33]+regs[R42]*regs[R34]+regs[R43]*regs[R35]+regs[R44]*regs[R36];
regs[R48]  = regs[R41]*regs[R37]+regs[R42]*regs[R38]+regs[R43]*regs[R39]+regs[R44]*regs[R40];

printf("***Output After Calculation***\n");
printf(" regs[R45] = %d\n", regs[R45]);
printf(" regs[R46] = %d\n", regs[R46]);
printf(" regs[R47] = %d\n", regs[R47]);
printf(" regs[R48] = %d\n", regs[R48]);   

printf("***Output Value ***");

/* Computee the final output value */
regs[R5] = (regs[R45] >= 0) ? 1:0;
regs[R6] = (regs[R46] >= 0) ? 1:0;
regs[R7] = (regs[R47] >= 0) ? 1:0;
regs[R8] = (regs[R48] >= 0) ? 1:0;

printf("***Output Values***\n");
printf(" regs[R5] = %d\n", regs[R5]);
printf(" regs[R6] = %d\n", regs[R6]);
printf(" regs[R7] = %d\n", regs[R7]);
printf(" regs[R8] = %d\n", regs[R8]);   

return 0;

 }
