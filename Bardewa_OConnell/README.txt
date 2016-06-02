####################################################################################
This document describes how to 
* generate memory image file
* compile and simulate the pipeline processor
* compare the outcome of the pipeline processor with the expected output file

Tool Requirements for running our Neural Network Simulator:
Simulator: ModelSim
OS: Windows
Compilers/Interpreters: GCC, Python 3

############################################################################################
Follow the steps below to generate memory image file, simulate the processor and verify the output

1. Go to the folder code, and open memoryImageGenerator
	Bardewa_OConnell\code\memoryImageGenerator
2. Generate a memory image file 
   (Refer to Bardewa_OConnell\documents\generate_a_memoryImage for pictorial description)
	2a. Clean last files with the command
		make clean
	2b. Generate the assembly file and then use it as an input to assembler
		python3 assemblyCodeGenerator.py >>inputfile.txt && python3 assembler.py >>memoryImage.tx
	2c. Generate combined instruction and data image run
		make && ./dataGenerator
3. Open the project in ModelSim
	(Refer to Bardewa_OConnell\documents\simulate_in_ModelSim for pictorial description)
4. Copy and paste the "memoryImage.txt" file from the "Bardewa_OConnell\documents\generate_a_memoryImage" Folder
	 into the "Bardewa_OConnell\code"
5. Compile and simulate the project 
	(Follow the steps as shown in Bardewa_OConnell\documents\simulate_in_ModelSim)
6. Verify the output of the processor with the expected output file
	(Follow the steps as shown in Bardewa_OConnell\documents\verification_of_data.docx)