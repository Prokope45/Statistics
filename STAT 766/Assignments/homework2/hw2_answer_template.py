import numpy as np
import pandas as pd
import os


# Note: Compress your .py file and hw1_1_dat.txt together into a zip file 
#       and submit the zip file to gradescope. 

class homework2:

    file_name = os.getcwd()+ '/' + 'hw1_1_dat.txt'   
    def __init__(self):
        self.hw_a, self.hw_b = self.hw_ab_fun(self.file_name)
        

    def hw_ab_fun(self, file_name):
        #fill in your code to get answer to part a and b here
        # Assign your answer to part a to variable answer_1a
        # and assign your answer to part b to variable answer_1b.
        lines = []
        with open(filename, 'r') as reader:
            lines = reader.readlines()
        
        print(lines)
        # return answer_a, answer_b
        return 0, 1
        
        

    def findmin(self, it, v, df):
        # fill in your code to find the smallest log10Ubeta2sum 
        # among all rows with the same it and v. 
        # Assign the smallest value to variable smallest. 
        
        # return smallest
        return 0