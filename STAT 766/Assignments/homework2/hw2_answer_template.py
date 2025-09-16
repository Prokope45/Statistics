import numpy as np
import pandas as pd
import os


# Note: Compress your .py file and hw1_1_dat.txt together into a zip file 
#       and submit the zip file to gradescope. 

class homework2:

    # file_name = os.getcwd()+ '/' + 'hw2_data_files/' + 'hw1_1_dat.txt'
    file_name = os.getcwd() + '/' + 'hw1_1_dat.txt'

    def __init__(self):
        self.hw_a, self.hw_b = self.hw_ab_fun(self.file_name)

    def hw_ab_fun(self, file_name):
        lines = []
        with open(file_name, 'r') as reader:
            lines = reader.readlines()
            lines = [line.rstrip('\n') for line in lines]
        
        answer_a = dict()
        answer_a["n_lines"] = len(lines)

        u_beta_lines = [
            line for line in lines
            if (line.startswith("it=") and "U_beta**2 sum" in line)
        ]

        n_it, it_collections = self.__process_answer_a(u_beta_lines)
        answer_a["n_it"] = n_it
        answer_a["it"] = it_collections

        answer_b = self.__process_answer_b(u_beta_lines)

        return answer_a, answer_b
    
    def __process_answer_a(self, u_beta_lines):
        it_values = list()
        for line in u_beta_lines:
            detail = line.split('  ')
            it_values.append(detail[0].split(' ')[1])

        unique_it_values = set(it_values)

        n_it = len(unique_it_values)

        it_collections = dict()

        for it in unique_it_values:
            temp_set = set()
            for line in u_beta_lines:
                if f"it= {it}" in line:
                    v = line.split('  ')[1].split(' ')[1]
                    temp_set.add(int(v))
            it_collections[it] = list(temp_set)
        print(it_collections)
        return n_it, it_collections

    def __process_answer_b(self, u_beta_lines):
        it = []
        v = []
        epoch = []
        u = []
        for line in u_beta_lines:
            it_part = line.find("it=")
            v_part = line.find("v=")
            epoch_part = line.find("epoch")
            u_beta_part = line.find("U_beta**2")

            it.append(int(line[it_part:v_part].split()[1]))
            v.append(int(line[v_part:epoch_part].split()[1]))
            epoch.append(int(line[epoch_part:u_beta_part].split()[1]))

            u1 = line.find("sum is")
            u2 = line.find("change")
            u.append(float(line[(u1+len("sum is")):u2]))
        answer_b = pd.DataFrame(
            data={
                "it": it,
                "v": v,
                "epoch": epoch,
                "log10Ubeta2sum": np.log10(u)
            }
        )
        return answer_b

    def findmin(self, it, v, df):
        min_log10_ubeta = 0

        matched_df = df[(df["it"] == it) & (df["v"] == v)]
        if not matched_df.empty:
            min_log10_ubeta = matched_df["log10Ubeta2sum"].min()
        return min_log10_ubeta
