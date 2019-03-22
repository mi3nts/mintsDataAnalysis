
# ***************************************************************************
#  mintsXU4
#   ---------------------------------
#   Written by: Lakitha Omal Harindha Wijeratne
#   - for -
#   Mints: Multi-scale Integrated Sensing and Simulation
#   ---------------------------------
#   Date: March 22nd, 2019
#   ---------------------------------
#   This module is written to convert AirBeam data into Mints Data format
#   --------------------------------------------------------------------------
#   https://github.com/mi3nts
#   http://utdmints.info/
#  ***************************************************************************


import csv
import time
from datetime import datetime
from collections import OrderedDict
import serial
import datetime
from mintsAirBeam import mintsSensorReader as mSR
from mintsAirBeam import mintsDefinitions as mD

dataFolder = mD.dataFolder



def main():

    with open('UTDOutdoorsAB2Session2.csv', mode='r') as csv_file:
        csv_reader = csv.DictReader(csv_file)
        line_count = 1
        for row in csv_reader:

            if line_count == 1:
                print("************** MINTS **************")
                print("Reading Air Beam CSV Data")
                model = row['sensor:model'].split("-")[1].lower()
                ID    = row['sensor:package'].replace("AirBeam","AB").replace(":","_")
                print("AirBeam ID:")
                print(ID)


            if row['sensor:model'].startswith('AirBeam'):
                model = row['sensor:model'].split("-")[1].lower()
                print("Writing CSV for:")
                print(model)

            if line_count > 2 and row['sensor:capability'][1].isnumeric():

                datetimePre =  row['sensor:model'].replace("T",":").replace("+0000","")

                dateTime  = datetime.datetime.strptime(datetimePre[:-4],"%Y-%m-%d:%H:%M:%S")
                sensorDictionary  =  OrderedDict([
                    ("dateTime"   ,dateTime ),
            		("latitude"   ,row['sensor:package']),
                	("longitude"  ,row['sensor:capability']),
                    ("value"         ,row['sensor:units']),
                        ])

                mSR.sensorFinisherAB(dateTime,ID,model,sensorDictionary)
                # print(sensorDictionary)

            line_count += 1


if __name__ == "__main__":
   main()
