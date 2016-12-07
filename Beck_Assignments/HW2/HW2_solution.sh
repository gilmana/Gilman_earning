#!/usr/bin/env python

"""
Alexey Gilman
05/16/16
"""

"""
Alexey Gilman
05/16/16
"""
import string
import random

import sys

def name_generator(size=10, char = string.ascii_uppercase + string.digits, nm_files = 10):
    """
    Generates strings of length 10 (arg1), from upper case letters and numbers (arg2). Will create
    10 indepedant strings (arg3) and will return a list.

    size = length of each string (int)
    char = choice of available characters (str)
    nm_files = number of strings to generate (int)
    """

    master_list = [] #making empty list
    for i in range(nm_files):  #iterating over number of desired strings
        file_name = "".join(random.choice(char) for i in range(size)) #joins a
        #rand char, iterated size of string
        master_list.append(file_name) #append each string to the master list
        
    for o in master_list:
        file = open(o + ".txt", "a")
        file.close()

name_generator()
