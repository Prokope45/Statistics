import pandas as pd
import numpy as np


class Solution:

    def strStr(self, haystack: str, needle: str) -> int:
        haystack_len: int = len(haystack)
        needle_len: int = len(needle)

        # Preconditions
        if not (haystack.isascii() or needle.isascii()):
            raise ValueError("Haystack and needle must be ASCII.")

        if (
            (haystack_len <= 0 or needle_len <= 0) or
            (haystack_len >= 10000 or needle_len >= 10000)
        ):
            raise ValueError(
                "Length of haystack or needle exceeds 10,000 character."
            )

        position: int = -1
        if (needle in haystack):
            for i in range(0, haystack_len):
                if haystack[i] == needle[0]:
                    position = i
        return position

    def slowMerge(self, lists: list[list[int]]) -> list:
        # assumption: lists already sorted
        merged: list[int] = list()
        for i in range(0, len(lists)):
            merged.extend(lists[i])
        return merged.sort()  # Inefficient; lists presorted already.

    def MergeSort(self, lists: list) -> list:
        n: int = sum(len(li) for li in lists)
        merged: list[int | None] = [None] * n

        j: int = 0
        k: int = 0
        l: int = 0

        x: list[int] = lists[0].copy()
        x.extend([float('inf') * (n - len(x))])
        y: list[int] = lists[1].copy()
        y.extend([float('inf') * (n - len(y))])

        while l <= n - 1:
            if x[j] < y[k]:
                merged[l] = x[j]
                j += 1
            else:
                merged[l] = y[k]
                k += 1
            l += 1
        return merged

    def find_customers(
        self, customers: pd.DataFrame, orders: pd.DataFrame
    ) -> pd.DataFrame:
        pass

    def find_managers(self, employee: pd.DataFrame) -> pd.DataFrame:
        pass


if __name__ == '__main__':
    print(Solution().MergeSort([[1,4,5],[1,3,4,6]]))
