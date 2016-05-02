#!/usr/bin/env python

import pandas as pd

df=pd.read_csv("output.txt")
print(df.sample(n=10, replace=True))
