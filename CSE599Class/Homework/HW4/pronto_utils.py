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

def download_if_needed(url,filename):
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
    #accessing trips and weather data

    trips = get_trip_data()
    weather = get_weather_data()

    #setting the index of trips

    trip_times = pd.DatetimeIndex(trips["starttime"])
    trips.index = trip_times.date

    # A pivot table is a two dimensional array
    datetime = pd.DatetimeIndex(trips["starttime"])
    trips_by_day = trips.pivot_table("trip_id", index = datetime.date,
                                     columns = "usertype", aggfunc = "count" )


    #cleaning up weather and setting index

    weather = weather.iloc[:-1]
    weather_times = pd.DatetimeIndex(weather["Date"])
    weather.index = weather_times.date

    #joining trips and weather data
    return weather.join(trips_by_day)


def ploting_joined_totals():
    data = joined_weather_and_trips()
    fig, ax = plt.subplots(2, figsize = (14,6), sharex = True)
    data["Annual Member"].plot(ax = ax[0], title = "Annual Member")
    data["Short-Term Pass Holder"].plot(ax = ax[1], title = "Short Term Pass Holder")
    fig.savefig("daily_totals.png")
    return 9 #if plot succesful return 9 for unittest



def checkUrl(url):
    """
    will do some magic in order to check if error is returned from url.
    If URL error code <400 (no error) return True.
    If URL error code >400 (error from server) return False.
    """
    p = urllib.parse.urlparse(url)
    conn = http.client.HTTPConnection(p.netloc)
    conn.request('HEAD', p.path)
    resp = conn.getresponse()
    return resp.status < 400


def download_if_needed_urllib3(url,filename):
    """
    if file isnt on the computer in pwd, this will download or
    tell you that it already exists
    """
    if os.path.exists(filename):
        print(filename, "already exists")
        return 7

    elif checkUrl(url) == False:
        print("there is a problem with the provided URL ")

    else:
        print("downloading", filename)
        urllib.request.urlretrieve(url,filename)
        return 8

def get_pronto_data_urllib3():
    """
    The download if needed function specific for the pronto data url
    """

    download_if_needed_urllib3("https://s3.amazonaws.com/pronto-data/open_data_year_one.zip",
                       "open_data_year_one.zip")

def remove_data():
    """
    If open_data_year_one.zip exists, this function will remove it. Allows for testing other functions.
    """
    if os.path.exists("open_data_year_one.zip"):
        os.remove("open_data_year_one.zip")
        print("open_data_year_one.zip has been removed")
        return 5
    else:
        print("no open_data_year_one.zip exists")
        return 6
