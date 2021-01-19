import numpy as np
import pandas as pd

loan_params = []

def create_loan():
    """
    Everytime the function is run, the user will be asked to enter paramers
    of the loan. The parameters of each loan are appended as a dictionary to
    a list containing all the laons of interest.
    """
    # enter terms of loan
    name = input("Assign name to the loan: ")

    principle = float(input("Loan ammount: "))
    rate = (float(input("Annual interest rate (%): ")))
    duration = (int(input("loan duration in years: ")))

    p = principle
    r = rate / 12 / 100
    n = duration * 12

    # Calculating monthly payment
    numerator = r * p * ((1 + r) ** n)
    denomenator = ((1 + r) ** n) - 1
    m = numerator / denomenator

    # append loan to loans list
    loan_params.append({"loan_id": name,
                        "principle": principle,
                        "rate": rate,
                        "duration": duration,
                        "m_payment": m})

def amortization_schedule():
    """
    generate an amortization schedule dataframe for each loan.

    input: loan_params list of dictionaries containing loan paramers keys:values
    :return: dictionary of dataframes, with loan name as keys, and dictionary of amortization schedule
    """

    amortization = {}

    for i in loan_params:
        name = i["loan_id"]
        n = i["duration"] * 12
        m = i["m_payment"]

        month_series = np.arange(1, (n + 1))
        payment_series = np.full((n,), m)

        df = pd.DataFrame({"Month": month_series, "Payment": payment_series})
        df["Total paid"] = df["Payment"].cumsum().round(1)  # total paid

        amortization[name] = df

    return amortization