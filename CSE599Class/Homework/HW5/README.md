CSE599     
02/09/16    
Alexey Gilman

Pronto Data Analysis Tool (PDAT)
====================

The purpose of this tool is to allow the use to quickly and easily analyze Seattle PRONTO users data for 2015. This package will allow the user to download the data directly from the source, perform basic data manipulation, plot the data, and export the resulting figures. This package will automatically compute PRONTO trip counts by day (for both annual members and single day pass users) combine with weather data for that day and allow the user to continue to process the data interactively. 

For more information about data source, visit: 
[Pronto Cycle Share](https://www.prontocycleshare.com/data)

----------------------
PDAT User Guide
----------------------
----------------------
Software dependencies
----------------------
**All the required software is open source.**

Python 3.5:                                          
[https://www.python.org/downloads/](https://www.python.org/downloads/)

---------
Files
---------

**PDAT.py** - This script will automatically download the ProntoData.csv to the present working directory if it isnt there already. The script contains all the functions needed for data analysis, and will interact with the user from the command prompt. Read below for details about available functions. 

**UnitTest.py** - The unit test is intended to test each component (unit) of the PDAT.py script in order to truobleshoot errors in the case that someone intends to build complexity on top of the existing script. 

**README.md** - Explanation to the user about how to properly run this code for data reproducibility.   

-------------------
Running code from terminal 
-------------------
Navigate to directory containing .py file. The following command will download the data, and prepare the data to be analyzed interactively by the user. After the data has been manipulated by the user, it will direct the user to choose x and y axis to plot the data and export it to a .pdf file. 

    $ python PDAT.py 


-------------------
Troubleshooting via UnitTest 
-------------------

Navigate to directory containing downloaded files. 

    python UnitTest.py 
    
------------------------------------
Avilable list of commands for interactive data manipulation
------------------------------------
#1 compute_max_trips() 
----
Interacts with the PRONTO dataframe to reveal the maximum number of trips taken in a day in 2015, also reveals the day on which this occured. 

Input: Annual Member, Short-Term Pass Holder


Output: The maximum trip count for selected group, and the date on which this occured. 

#2 compute_min_trips()
--
Interacts with the PRONTO dataframe to reveal the minimum number of trips taken in a day in 2015, also reveals the day on which this occured. 

Input: Annual Member, Short-Term Pass Holder


Output: The minimum trip count for selected group, and the date on which this occured. 

#3 compute_ave_trips()
--
Interacts with the PRONTO dataframe to reveal the average number of trips taken in a day in 2015, also reveals the day on which this occured. 

Input: Annual Member, Short-Term Pass Holder

Output: The average trip count for selected group, and the date on which this occured. 

#4 compute_busiest_month()
--
Interacts with the PRONTO dataframe to reveal the total number of trips taken by either category in the busiest month in 2015, also reveals the month during which this occured. 

Input: Annual Member, Short-Term Pass Holder

Output: The total trip count for busiest month for selected group, and the date on which this occured. 

#5 plot_x_vs_y() 
--
Instructs the user to input the x and y columns from a list of available column names. After setting the x and y axis, the function will plot the selcted data, and produce a .pdf file of the plot. Interacts with the dataframe of PRONTO data merged with weather data. 

Input: data column for x-axis, data column for y-axis. 

output: .pdf file of plot of selected x vs y axis. 

-----------------------------
Acknowledgements
---
David A. C. Beck

Joseph L. Hellerstein

Jake VanderPlas