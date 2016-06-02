
in windows, press the windows key, type "cmd.exe" and press enter. navigate to the assembly code folder.
it should look something like this:

	C:\Users\oconnelc>cd /d N:NNsimulator\NNSimulator\assemblyCode\baseCaseAssemblyCodeGenerator

make sure you have python 3 installed. you may need to specify the full path to your python executable if it is not
in your path.

run the base case assembly code generator. redirect the output to a file.
Naming the file inputfile.txt will save a step later.

	python BaseCase_ACG.py > inputfile.txt

copy the file to 





###################################

This document describes how to use the assembler and assembly code generator to generate executable code for 
the Artificial Neural Network Simulator CPU module.

Tool Requirements for running our Neural Network Simulator:
Simulator: ModelSim
OS: Windows
Compilers/Interpreters: GCC, Python 3

###################################


1. Navigate to the base case assembly code folder (\NNSimulator\assemblyCode\baseCaseAssemblyCodeGenerator).
2. Make sure you have python 3 installed. Run the base case assembly code generator. Redirect the output to a file.
3. Rename the file inputfile.txt and move the file to the assembler folder (\NNSimulator\assembler).
4. Run assembler.py. Redirect the output to a file.
	for example: python BaseCase_ACG.py > inputfile.txt
5. 