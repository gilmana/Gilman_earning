#!/usr/bin/python

"""
Version 1.0 

to execute: 

$ ./gilmanscript.sh > new_file.txt 

The above command will only work if the executible bit is turned on.
hint: chmod +x scriptname.sh

""" 


import random

# for range to # of randoms
#  populate array
#  random_array[i] = random.randint
#	while(already exists in random_array)
#	generate a new one
ran1 = random.randint(0,100)
ran2 = random.randint(0,100)
ran3 = random.randint(0,100)
ran4 = random.randint(0,100)
ran5 = random.randint(0,100)
ran6 = random.randint(0,100)
ran7 = random.randint(0,100)
ran8 = random.randint(0,100)
ran9 = random.randint(0,100)
ran10 = random.randint(0,100)

file = open("output.txt","r")

for i, line in enumerate(file):
	# for item in rand_array
	# if
    if i == (ran1-1):
        print(line)#, end = "")
    elif i == (ran2-1):
        print(line)#, end = "")
    elif i == (ran3-1):
        print(line)#, end = "")
    elif i == (ran4-1):
        print(line)#, end = "")
    elif i == (ran5-1):
        print(line)#, end = "")
    elif i == (ran6-1):
        print(line)#, end = "")
    elif i == (ran7-1):
        print(line)#, end = "")
    elif i == (ran8-1):
        print(line)#, end = "")
    elif i == (ran9-1):
        print(line)#, end = "")
    elif i == (ran10-1):
        print(line)#, end = "")
    else:
        pass

