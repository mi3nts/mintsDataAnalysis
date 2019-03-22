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

    with open('UTDOutdoorsAB1Session2.csv', mode='r') as csv_file:
        csv_reader = csv.DictReader(csv_file)
        line_count = 1
        for row in csv_reader:

            if line_count == 1:
                print("Reading Air Beam CSV")
                print(str(row))
                model = row['sensor:model'].replace("AirBeam-","AB1_")
                ID    = row['sensor:units'].replace("AirBeam:","AB1_")
                print(model)
                print(ID)
                print(row['sensor:model'])

            if line_count > 2 and row['sensor:capability'][1].isnumeric():
                print(row)
                datetimePre =  row['sensor:model'].replace("T",":").replace("+0000","")
                print(datetimePre[:-4])
                dateTime  = datetime.datetime.strptime(datetimePre[:-4],"%Y-%m-%d:%H:%M:%S")
                sensorDictionary  =  OrderedDict([
                    ("dateTime"   ,dateTime ),
            		("latitude"   ,row['sensor:package']),
                	("longitude"  ,row['sensor:capability']),
                    ("value"         ,row['sensor:units']),
                        ])

                mSR.sensorFinisherAB(dateTime,ID,model,sensorDictionary)
                print(sensorDictionary)

            line_count += 1


if __name__ == "__main__":
   main()
