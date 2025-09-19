import sqlite3
from sqlite3 import Connection, Cursor
import glob


class HW3:

    def __init__(self):
        self.__connection: Connection | None = None
        self.__cursor: Cursor | None = None

    def __write_output_table(self, input_files):
        """Parse text contents and write to db output table."""
        self.__cursor.execute('''
        CREATE TABLE IF NOT EXISTS output (it, v, epoch, U_beta_square_sum)
        ''')

        for file_name in input_files:
            lines = []
            with open(file_name, 'r') as reader:
                lines = reader.readlines()
                lines = [line.rstrip('\n') for line in lines]

            u_beta_lines = [
                line for line in lines
                if (line.startswith("it=") and "U_beta**2" in line)
            ]

            it: int = 0
            v: int = 0
            epoch: int = 0
            u: float = 0.0

            for line in u_beta_lines:
                it_part = line.find("it=")
                v_part = line.find("v=")
                epoch_part = line.find("epoch")
                u_beta_part = line.find("U_beta**2")

                it = int(line[it_part:v_part].split()[1])
                v = int(line[v_part:epoch_part].split()[1])
                epoch = int(line[epoch_part:u_beta_part].split()[1])

                u1 = line.find("sum is")
                u2 = line.find("change")
                u = float(line[(u1+len("sum is")):u2])

                self.__cursor.execute('''
                INSERT INTO output (it, v, epoch, U_beta_square_sum)
                VALUES (?, ?, ?, ?)
                ''', (it, v, epoch, u))
        self.__connection.commit()

    def __write_epoch0_table(self):
        """Filter where epoch is 0, and sort it and v by ascending order."""
        self.__cursor.execute('''
        CREATE TABLE IF NOT EXISTS epoch0 (it, v, epoch, U_beta_square_sum)
        ''')
        # Select rows where epoch is 0
        query = self.__cursor.execute('''
        SELECT * FROM output
        WHERE epoch = 0
        ORDER BY it ASC, v ASC
        ''')
        query_rows = query.fetchall()

        for row in query_rows:
            self.__cursor.execute('''
            INSERT INTO epoch0 (it, v, epoch, U_beta_square_sum)
            VALUES (?, ?, ?, ?)
            ''', (row[0], row[1], row[2], row[3]))

        self.__connection.commit()

    def extract(
        self,
        input_files=None,
        out_db_filename="output.sqlite"
    ) -> None:
        self.__connection = sqlite3.connect(out_db_filename)
        self.__cursor = self.__connection.cursor()

        # input_files = glob.glob("out*.txt")
        self.__write_output_table(input_files)
        self.__write_epoch0_table()

        self.__connection.close()
