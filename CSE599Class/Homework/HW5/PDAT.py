"""
This is a utilities package that automatically downloads pronto data zip file, it also
creates functions to automatically extract trip data and weather data without unzipping
the contents of the file. This is useful to be able to import the code in a packaged function.

"""

import wget
import os
import zipfile
import pandas as pd
import matplotlib.pyplot as plt
import seaborn; seaborn.set()
import http.client
import urllib.parse
import wget
import urllib3
import urllib.request


def download_if_needed(url, filename):
    """
    if file isnt on the computer in pwd, this will download or
    tell you that it already exists
    """
    if os.path.exists(filename):
        print(filename, "already exists")
    else:
        print("downloading", filename)
        wget.download(url)


def get_pronto_data():
    """
    The download if needed function specific for the pronto data url
    """

    download_if_needed("https://s3.amazonaws.com/pronto-data/open_data_year_one.zip",
                       "open_data_year_one.zip")


def get_trip_data():
    """
    returns dataframe of the trip data csv from zipfile without extraction
    """
    get_pronto_data()
    zf = zipfile.ZipFile("open_data_year_one.zip")
    file_handle = zf.open("2015_trip_data.csv")
    return pd.read_csv(file_handle)


def get_weather_data():
    """
    returns weather data from the pronto csv file
    """
    get_pronto_data()
    zf = zipfile.ZipFile("open_data_year_one.zip")
    file_handle = zf.open("2015_weather_data.csv")
    return pd.read_csv(file_handle)


def joined_weather_and_trips():

    """
    Cleaning and joining both the trips and weather data
    """

    # accessing trips and weather data
    trips = get_trip_data()
    weather = get_weather_data()

    # setting the index of trips
    trip_times = pd.DatetimeIndex(trips["starttime"])
    trips.index = trip_times.date

    # A pivot table is a two dimensional array
    datetime = pd.DatetimeIndex(trips["starttime"])
    trips_by_day = trips.pivot_table("trip_id", index=datetime.date,
                                     columns="usertype", aggfunc="count")

    # cleaning up weather and setting index
    weather = weather.iloc[:-1]
    weather_times = pd.DatetimeIndex(weather["Date"])
    weather.index = weather_times.date

    # joining trips and weather data
    return weather.join(trips_by_day)


def plot_x_vs_y():
    """
    Allows user to choose desired x and y axis and then generates a plot. Creates a .pdf file of the plot.
    """
    data = joined_weather_and_trips()
    return 7 
    argument_y = str(input("Enter your choice of data for y axis from the following options: Mean_Temperature_F,"
                           " Precipitation_In, Annual Member, Short-Term Pass Holder"))
    argument_x = str(input("Enter your choice of data for x axis from the following options: Date, Mean_Temperature_F,"
                           " Precipitation_In, Annual Member, Short-Term Pass Holder"))
    if argument_x == "Date":
        plt.scatter(data.index, data[argument_y])
        plt.xlabel("Date")
        plt.ylabel(argument_y)
        plt.savefig("plot.pdf")
    else:
        plt.scatter(data[argument_x], data[argument_y])
        plt.xlabel(argument_x)
        plt.ylabel(argument_y)
        plt.savefig("plot.pdf")


if __name__ == "__main__":
    get_pronto_data()
    get_trip_data()
    get_weather_data()
    joined_weather_and_trips()
    plot_x_vs_y()
