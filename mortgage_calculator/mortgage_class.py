import numpy as np
import pandas as pd


class Loan:
    """
    Stores parameters about a single loan.
    """
    def __init__(self):
        self.loan = {}

    def input_loan(self):
        """
        calls user input for three

        :return: None
        """
        # data inputs
        principle = float(input("Enter principle amount: "))
        rate = float(input("Enter interest rate as %: "))
        duration = int(input("Enter loan duration in years: "))

        # calculating monthly payment
        p = principle
        r = rate / 12 / 100
        n = duration * 12

        numerator = r * p * ((1 + r) ** n)
        denomenator = ((1 + r) ** n) - 1
        monthly = numerator / denomenator

        # assigning values to attributes
        self.loan["principle"] = principle
        self.loan["rate"] = rate
        self.loan["duration"] = duration
        self.loan["monthly"] = monthly


class Portfolio:
    """
    Creating a portfolio of loans. Utilization of Loan class to add new loans to portfolio.
    """
    def __init__(self):
        self.portfolio = {}

    def add_loan(self, loan_id=None):

        if loan_id == None:
            loan_id = input("Enter loan ID: ")
        else:
            pass

        loan_dict = Loan()
        loan_dict.input_loan()

        self.portfolio[str(loan_id)] = loan_dict.loan


x = 5
print(y)
