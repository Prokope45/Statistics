import numpy as np


class activity3:
    def get_odd(self, array: np.ndarray):
        indices: list[int] = list()
        for idx, elem in enumerate(array):
            if idx % 2 == 1:
                indices.append(elem.item())
        return indices

    def replace_odd(self, a: np.ndarray):
        a2: np.ndarray = a.copy()
        for idx, val in enumerate(a2):
            if val % 2 == 1:
                a2[idx] = -1
        return a, a2

    def stack_v_h(self, a, b):
        stack = np.vstack((a, b))
        stack = np.hstack((stack, stack.copy()))
        return stack

    def get_dif_elem(self, a, b):
        output: list[int] = list()
        for x_a, x_b in zip(a, b):
            for y_a, y_b in zip(x_a, x_b):
                if (y_a != y_b) and len(output) <= 0:
                    output.append(y_a.item())
                    output.append(y_b.item())
        return output
