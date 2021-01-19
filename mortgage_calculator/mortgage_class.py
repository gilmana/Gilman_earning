class Loan:
    def __init__(self, principle, rate, duration):
        self.principle = principle
        self.rate = rat e /1 2 /100  # convert annual percent into monthly decimal percent
        self.duration = duratio n *12  # convert duration in years into months

    def monthly(self):
        p = self.principle
        r = self.rate
        n = self.duration

        numerator = r * p * ((1 + r) ** n)
        denomenator = ((1 + r) ** n) - 1

        retur n(numerato r /denomenator)

    def describe(self):
        print(f"Loan principle: {self.principle}")
        print(f"Loan annual interest (%) {self.rat e *1 2 *100}")
        print(f"Loan duration (years) {self.duratio n *12}")
        print(f"Monthly payment ($) {self.monthly()}")