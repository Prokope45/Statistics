import pandas as pd
import numpy as np
import sys


class Solution:

    def strStr(self, haystack: str, needle: str) -> int:
        haystack_len: int = len(haystack)
        needle_len: int = len(needle)

        position: int = -1

        # Preconditions
        if not (haystack.isascii() or needle.isascii()):
            return position + 1

        if (
            (haystack_len <= 0 or needle_len <= 0) or
            (haystack_len >= 10000 or needle_len >= 10000)
        ):
            return position + 1

        if (needle in haystack):
            curr = 0
            while curr < haystack_len:
                if (
                    haystack[curr] == needle[0] and
                    haystack[curr + needle_len - 1] == needle[-1]
                ):
                    position = curr
                    curr = haystack_len
                else:
                    curr += 1
        return position

    def slowMerge(self, lists: list[list[int]]) -> list:
        # assumption: lists already sorted
        merged: list[int] = list()
        for i in range(0, len(lists)):
            merged.extend(lists[i])
        merged.sort()
        return merged  # Inefficient; lists presorted already.

    def MergeSort(self, lists: list) -> list:
        X: list[int] = lists[0]
        Y: list[int] = lists[1]

        n: int = len(X) + len(Y)
        z: list[int] = []

        j: int = 0
        k: int = 0
        l: int = 0

        X_inf: list[int] = X.copy()
        X_inf.extend([float('inf')])

        Y_inf: list[int] = Y.copy()
        Y_inf.extend([float('inf')])

        while l <= n:
            if X_inf[j] < Y_inf[k]:
                z.append(X_inf[j])
                j += 1
            elif X_inf[j] > Y_inf[k]:
                z.append(Y_inf[k])
                k += 1
            elif (
                (X_inf[j] == Y_inf[k]) and
                (X_inf[j] != float('inf') and Y_inf[k] != float('inf'))
            ):
                z.append(Y_inf[k])
                k += 1
            l += 1
        return z

    def find_customers(
        self, customers: pd.DataFrame | None = None, orders: pd.DataFrame | None = None
    ) -> pd.DataFrame:
        customers_with_no_orders = customers.where(~customers['id'].isin(orders['customerId']))

        # Clean up dataframe
        customers_with_no_orders.rename({"name": "Customers"}, axis=1, inplace=True)
        customers_with_no_orders.drop(columns=["id"], inplace=True)
        customers_with_no_orders.dropna(axis=0, inplace=True)

        return customers_with_no_orders

    def find_managers(self, employee: pd.DataFrame) -> pd.DataFrame:
        # groupby the managerId column and count the number of employees for each manager
        counts = employee.groupby("managerId")["id"].count()

        # filter the counts dataframe to only include managers with 5 or more employees
        filtered_managers = counts[counts >= 5].index
        manager_names = employee.where(employee["id"].isin(filtered_managers))["name"]
        return pd.DataFrame(manager_names[manager_names.notna()], columns=["name"])
