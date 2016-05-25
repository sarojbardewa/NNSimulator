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
/*
 	if(argc <2)
  	{
  		printf("Must Pass an argument !\n");
  		return -1;
    } */
// Random inner in 
//printf("\n**** Inputs****\n");
for(loopVar = 0; loopVar<INPUTS;++loopVar)
{
	srand(clock());
	in[loopVar] = 1;  		// Generate 32 random weights -1, 0 or 1//
	//in[loopVar] = 0;
	regs[loopVar+R1] = in[loopVar];  // Registers from R1-R4 
	//printf("%x \n",in[loopVar]);
}

printf("%x\n", regs[R1]);
printf("%x\n", regs[R2]);
printf("%x\n", regs[R3]);
printf("%x\n", regs[R4]);



// Random weights of Neuron i
//printf("\n**** Inputs-Hidden nodes Weights****\n");
for(loopVar = 0; loopVar<WEIGHTS;++loopVar)
{
	srand(clock());
	inWeight[loopVar] = rand()%3 -1;  		 //Generate 32 random weights -1, 0 or 1
	//inWeight[loopVar] = 1;
	regs[loopVar+R9]   = inWeight[loopVar];  // Registers from R9-R24 are weights between layer 1 and layer 2 
	//printf("%x   %x\n",inWeight[loopVar], regs[loopVar+R9]);
}
printf("%x\n", regs[R9]);
printf("%x\n", regs[R10]);
printf("%x\n", regs[R11]);
printf("%x\n", regs[R12]);
printf("%x\n", regs[R13]);
printf("%x\n", regs[R14]);
printf("%x\n", regs[R15]);
printf("%x\n", regs[R16]);
printf("%x\n", regs[R17]);
printf("%x\n", regs[R18]);
printf("%x\n", regs[R19]);
printf("%x\n", regs[R20]);
printf("%x\n", regs[R21]);
printf("%x\n", regs[R22]);
printf("%x\n", regs[R23]);
printf("%x\n", regs[R24]);

//Random weights of Neuron j
//printf("\n****Hidden Nodes-Outputs Weights****\n");
for(loopVar = 0; loopVar<WEIGHTS;++loopVar)
{
	srand(clock());
	outWeight[loopVar] = rand()%3 -1;  		 // Generate 32 random weights -1, 0 or 1
	//outWeight[loopVar] = 1;
	regs[loopVar+R25] =outWeight[loopVar];   // Registers from R25-R40 are weights between layer 2 and layer 3
	//printf("%x   %x\n",outWeight[loopVar], regs[loopVar+R25]);
}

printf("%x\n", regs[R25]);
printf("%x\n", regs[R26]);
printf("%x\n", regs[R27]);
printf("%x\n", regs[R28]);
printf("%x\n", regs[R29]);
printf("%x\n", regs[R30]);
printf("%x\n", regs[R31]);
printf("%x\n", regs[R32]);
printf("%x\n", regs[R33]);
printf("%x\n", regs[R34]);
printf("%x\n", regs[R35]);
printf("%x\n", regs[R36]);
printf("%x\n", regs[R37]);
printf("%x\n", regs[R38]);
printf("%x\n", regs[R39]);
printf("%x\n", regs[R40]); 
// Calculation of layer 1 and 2
regs[R41]  = regs[R1]*regs[R9] +regs[R2]*regs[R10]+regs[R3]*regs[R11]+regs[R4]*regs[R12];
regs[R42]  = regs[R1]*regs[R13]+regs[R2]*regs[R14]+regs[R3]*regs[R15]+regs[R4]*regs[R16];
regs[R43]  = regs[R1]*regs[R17]+regs[R2]*regs[R18]+regs[R3]*regs[R19]+regs[R4]*regs[R20];
regs[R44]  = regs[R1]*regs[R21]+regs[R2]*regs[R22]+regs[R3]*regs[R23]+regs[R4]*regs[R24];
//printf("Hidden Neuron values = %x  %x %x %x \n" ,regs[R41],regs[R42],regs[R43],regs[R44]);
     
     /* Computee the hidden neuron value */
     regs[R41] = (regs[R41] >= 0);
     regs[R42] = (regs[R42] >= 0);
     regs[R43] = (regs[R43] >= 0); 
     regs[R44] = (regs[R44] >= 0); 
     
    
printf("***Hidden Neuron Values After Calculation***\n");
printf("%x\n", regs[R41]);
printf("%x\n", regs[R42]);
printf("%x\n", regs[R43]);
printf("%x\n", regs[R44]); 
// Calculation of layer 2 and layer 3 
regs[R45]  = regs[R41]*regs[R25]+regs[R42]*regs[R26]+regs[R43]*regs[R27]+regs[R44]*regs[R28];
regs[R46]  = regs[R41]*regs[R29]+regs[R42]*regs[R30]+regs[R43]*regs[R31]+regs[R44]*regs[R32];
regs[R47]  = regs[R41]*regs[R33]+regs[R42]*regs[R34]+regs[R43]*regs[R35]+regs[R44]*regs[R36];
regs[R48]  = regs[R41]*regs[R37]+regs[R42]*regs[R38]+regs[R43]*regs[R39]+regs[R44]*regs[R40];


printf("***Output After Calculation***\n");
printf("%x\n", regs[R45]);
printf("%x\n", regs[R46]);
printf("%x\n", regs[R47]);
printf("%x\n", regs[R48]);   

//printf("***Output Value ***");

/* Computee the final output value */
regs[R5] = (regs[R45] >= 0) ;
regs[R6] = (regs[R46] >= 0) ;
regs[R7] = (regs[R47] >= 0) ;
regs[R8] = (regs[R48] >= 0) ;

printf("***Output Values***\n");
printf("%x\n", regs[R5]);
printf("%x\n", regs[R6]);
printf("%x\n", regs[R7]);
printf("%x\n", regs[R8]);   

return 0;

 }
