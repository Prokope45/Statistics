import os
import sqlite3


class HW3:

    def extract(self, input_files, out_db_filename) -> None:
        # TODO: Conform code to pull in it, v, epoch, and beta**2_sum..
        # ..then insert into database.
        connection = sqlite3.connect("output.sqlite")
        cursor = connection.cursor()
        # cursor.execute("DROP TABLE IF EXISTS power_table")
        cursor.execute('''
        CREATE TABLE IF NOT EXISTS power_table (i, j, trt_effect_size, power)
        ''')

        for file in input_files:
            with open(file, 'r') as reader:
                file_content = reader.read()

            lines = file_content.split('\n')
            i = int(lines[0].split()[3])
            j = int(lines[0].split()[6])

            for row in lines[-12:-2]:
                one = row.split()
                trt_effect_size = float(one[1])
                power = float(one[2])
                value = (i, j, trt_effect_size, power)
                cursor.execute('''
                INSERT INTO power_table (i, j, trt_effect_size, power)
                VALUES (?, ?, ?, ?)
                ''', value)
        connection.commit()
        connection.close()
