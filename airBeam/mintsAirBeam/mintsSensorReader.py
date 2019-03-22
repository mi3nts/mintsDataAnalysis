# ***************************************************************************
#  mintsXU4
#   ---------------------------------
#   Written by: Lakitha Omal Harindha Wijeratne
#   - for -
#   Mints: Multi-scale Integrated Sensing and Simulation
#   ---------------------------------
#   Date: February 4th, 2019
#   ---------------------------------
#   This module is written for generic implimentation of MINTS projects
#   --------------------------------------------------------------------------
#   https://github.com/mi3nts
#   http://utdmints.info/
#  ***************************************************************************

import serial
import datetime
import os
import csv

from mintsAirBeam import mintsDefinitions as mD
import time
from collections import OrderedDict

#
# macAddress    = mD.macAddress
dataFolder    = mD.dataFolder
# latestOff     = mD.latestOff
# (dateTime,ID,model,sensorDictionary)



def sensorFinisherAB(dateTime,ID,model,sensorDictionary):
    #Getting Write Path
    writePath = getWritePathAB(ID,model,dateTime)
    exists    = directoryCheck(writePath)
    writeCSV2(writePath,sensorDictionary,exists)
    # print(writePath)
    # print("-----------------------------------")
    # print(sensorDictionary)


def getWritePathAB(ID,labelIn,dateTime):
    #Example  : MINTS_0061_OOPCN3_2019_01_04.csv
    writePath = dataFolder+"/"+ID+"/"+str(dateTime.year).zfill(4)  + "/" + str(dateTime.month).zfill(2)+ "/"+str(dateTime.day).zfill(2)+"/"+ "MINTS_"+ ID+ "_" +labelIn + "_" + str(dateTime.year).zfill(4) + "_" +str(dateTime.month).zfill(2) + "_" +str(dateTime.day).zfill(2) +".csv"
    return writePath;

def writeCSV2(writePath,sensorDictionary,exists):
    keys =  list(sensorDictionary.keys())
    with open(writePath, 'a') as csv_file:
        writer = csv.DictWriter(csv_file, fieldnames=keys)
        # print(exists)
        if(not(exists)):
            writer.writeheader()
        writer.writerow(sensorDictionary)


def directoryCheck(outputPath):
    exists = os.path.isfile(outputPath)
    directoryIn = os.path.dirname(outputPath)
    if not os.path.exists(directoryIn):
        os.makedirs(directoryIn)
    return exists
