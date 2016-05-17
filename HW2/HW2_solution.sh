#!/usr/bin/env python

"""
Alexey Gilman
05/16/16
"""
import string 
import random
def name_generator(size=10, char = string.ascii_uppercase + string.digits, nm_files = 10):
    master_list = []
    for i in range(nm_files):
        file_name = "".join(random.choice(char) for i in range(size))
        master_list.append(file_name)
    return master_list


print(name_generator()) 
