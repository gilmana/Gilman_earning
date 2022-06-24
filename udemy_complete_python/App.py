class Loan:
    """
    Stores parameters about a single loan: (value, down_payment, rate, duration)
    
    args:
        value: int, total house value
        down_payment: int, down payment amount
        rate: float, interest rate as a percentage
        duration: int, loan duration in years
    
    """
    
    def __init__(self, value, down_payment, rate, duration = None):
        
        #main instance arguments
        self.value = value 
        self.down_payment = down_payment 
        self.rate = rate 
        
        
        #duration in years, default to 30
        if duration is None:
            duration = 30
        self.duration = duration
            
        #calculated attributes
        self.principle = self.value - self.down_payment
        self.monthly = self.calculate_monthly(self.principle, self.rate, self.duration)
    
    
    @classmethod
    def from_dict(cls, loan_dict):
        """
        Alternate constructor to create Loan object from dict
        
        args: loan_dict, dictionary with following keys 
            {"value": int,
            "down_payment": int,
            "rate": float}
        """
        value, down_payment, rate = loan_dict["value"], loan_dict["down_payment"], loan_dict["rate"]
        
        return cls(value, down_payment, rate)
    
    
    def calculate_monthly(self, principle, rate, duration):
        """
        Calculates monthly payment from given principle, rate, and loan duration

        """
        p = self.principle
        r = self.rate / 12 / 100
        n = self.duration * 12

        numerator = r * p * ((1 + r) ** n)
        denomenator = ((1 + r) ** n) - 1
        return numerator / denomenator
    
    
class Portfolio:
    """
    Create a portfolio of loan parameters. Uses loan objects to create dict of loan parameters.
    """
    
    def __init__(self):
        self.loans = {}
        self.count = 0
    
    def add_loan_dict(self, loan_dict):
        """
        args: loan_dict, dictionary with following keys:
            {"value": int,
            "down_payment": int,
            "rate": float}
        """
        new_loan = Loan.from_dict(loan_dict)
        self.count += 1 
        self.loans[f"Loan_{self.count}"] = new_loan.__dict__
        
    def add_loan_portfolito_dict(self, portfolio_dict):
        """
        args: dictionary of dictionaries:
            {
                "Loan_1":{
                    "value": int,
                    "down_payment": int,
                    "rate": float}
                "Loan_2: {
                    "value": int,
                    "down_payment": int,
                    "rate": float}
            }
        """
        for key, value in portfolio_dict.items():
            new_loan = Loan.from_dict(value) #create a Loan object from dict input values
            self.count += 1 
            self.loans[f"Loan_{self.count}"] = new_loan.__dict__            
        
    def return_portfolio_dict(self):
        """
        Return loan parameter dictionary. 
        """
        return self.loans