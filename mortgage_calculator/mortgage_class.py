import numpy as np
import pandas as pd

class Loan:
    def __init__(self, principle, rate, duration):
        self.principle = principle
        self.rate = rate/12/100  # convert annual percent into monthly decimal percent
        self.duration = duration*12  # convert duration in years into months

    def monthly(self):
        p = self.principle
        r = self.rate
        n = self.duration

        numerator = r * p * ((1 + r) ** n)
        denomenator = ((1 + r) ** n) - 1

        return(numerator/denomenator)

    def describe(self):
        print(f"Loan principle: {self.principle}")
        print(f"Loan annual interest (%) {self.rate*12*100}")
        print(f"Loan duration (Month) {self.duration}")
        print(f"Monthly payment ($) {self.monthly()}")

    def schedule(self):
        """
        Plot the amortization schedule of the loan class
        """
        m = self.monthly()  # monthly payment
        count = np.arange(1, self.duration + 1)  # array with payment counts
        paid = count * m  # array with total paid for every payment
        array = np.stack([count, paid], axis=1)
        df = pd.DataFrame(array, columns=["Months", "Paid"])

        return (df.set_index("Months").plot())
