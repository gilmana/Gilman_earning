Alexey Gilman
05/06/16 
Beck Research Group 

HW Assignment #1: 

1) create a shell script file (.sh) that will generate numbers 1-100 and output it into
	a .txt file. Use python to do write the script (solution will also be provided in bash). 

	a) touch command makes a blank file (touch script_name) 

	b) to make this shell file executible, the first line has to start with #! this tells the computer 
		that its an executible script and which program to use. 

	c) an example of using shell script:

	#!/usr/bin/bash 

	echo "this is working" 

	d) if the scipt file with the above contents is executed, it will simply echo (print) "this is 
		working". in order to make it executible you need to set it to executible. 

		$ chmod +x script_name 

		now you can type: 

		$ bash script_name

		This will execute the script script_name which should print "this is working". 

	e) now do the same thing with python (hint:!#/usr/bin/python3), and make a python script to 
		generate 1-100 numbers. Output the script into a .txt file output.txt 

2) create a python shell script that take the output.txt file (100 lines 
	of 1 to 100), selects 10 lines at random and returns the result. 

	 
