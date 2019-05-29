
import serial
import datetime
from mintsC1Plus import mintsSensorReader as mSR
from mintsC1Plus import mintsDefinitions as mD
import time
import serial
from collections import OrderedDict
import glob
import os

dataFolder    =  mD.dataFolder
airMarPort    =  mD.airMarPort

def main():
    inFolder  = "drive-download-20190515T205149Z-001"
    dateFiles = (glob.glob(inFolder + "/*.LOG"))

    for dateFile in dateFiles:
        dateData = dateFile.split('/')[1].split('_PORT')[0].split('_')
        dateData[0] = getMonthNum(dateData[0])
        print(dateData)
        with open(dateFile) as timeFiles:
            for timeFile in timeFiles:
                timeFile = timeFile.replace("<- ","")
                timeFile = timeFile.strip('\n')
                if ": $" in timeFile:
                    timeData    = timeFile.split(": $")[0].split(":")
                    timeData.append(timeData[2].split(".")[0])
                    timeData[3] = int(timeData[2].split(".")[1])*1000
                    timeData[2] = timeData[2].split(".")[0]
                    dateTime  = datetime.datetime(int(dateData[2]),\
                                                     int(dateData[0]),\
                                                     int(dateData[1]),\
                                                     int(timeData[0]),\
                                                     int(timeData[1]),\
                                                     int(timeData[2]),\
                                                     int(timeData[3])\
                                                     )
                    # print(timeFile.split(": $")[1])

                    dataString =timeFile.split(": $")[1]

                    if dataString.startswith("HCHDT"):
                        mSR.HCHDTWrite(dataString,dateTime)

                    if dataString.startswith("WIMWV"):
                        mSR.WIMWVWrite(dataString,dateTime)

                    if dataString.startswith("GPGGA"):
                        mSR.GPGGAWrite(dataString,dateTime)

                    if dataString.startswith("GPVTG"):
                        mSR.GPVTGWrite(dataString,dateTime)

                    if dataString.startswith("GPZDA"):
                        lastGZDA = time.time()

                    if dataString.startswith("WIMDA"):
                        mSR.WIMDAWrite(dataString,dateTime)

                    if dataString.startswith("YXXDR,"):
                        mSR.YXXDRWrite(dataString,dateTime)
                    #
                    #
                    #


    # inFolder  =
    # # Read log files
    # infile = "Feb_12_2019_PORT_38_0183.LOG"
    # with open(infile) as f:
    #     f = f.readlines()
    #
    # for line in f:
    #     #
    #     print(line)
        # time.sleep(1)
        # for phrase in keep_phrases:
        #     if phrase in line:
        #         important.append(line)
        #         break
    # #this will store the line
    # line = []
    # while True:
    #
    #     for c in ser.read():
    #         line.append(chr(c))
    #         if chr(c) == '\n':
    #             dataString     = (''.join(line)).replace("\r\n","")
    #             dateTime  = datetime.datetime.now()
    #
    #             if (dataString.startswith("$HCHDT") and mSR.getDeltaTime(lastHCHDT,delta)):
    #                 mSR.HCHDTWrite(dataString,dateTime)
    #                 lastHCHDT = time.time()
    #                 # print(str(dataString))
    #
    #             if (dataString.startswith("$WIMWV") and mSR.getDeltaTime(lastWIMWV,delta)):
    #                 mSR.WIMWVWrite(dataString,dateTime)
    #                 lastWIMWV = time.time()
    #                 # print(str(dataString))
    #
    #             if (dataString.startswith("$GPGGA") and mSR.getDeltaTime(lastGPGGA,delta)):
    #                 mSR.GPGGAWrite(dataString,dateTime)
    #                 lastGPGGA = time.time()
    #                 # print(str(dataString))
    #
    #             if (dataString.startswith("$GPVTG") and mSR.getDeltaTime(lastGPVTG,delta)):
    #                 mSR.GPVTGWrite(dataString,dateTime)
    #                 lastGPVTG = time.time()
    #                 # print(str(dataString))
    #
    #             if (dataString.startswith("$GPZDA") and mSR.getDeltaTime(lastGPZDA,delta)):
    #                 mSR.GPZDAWrite(dataString,dateTime)
    #                 lastGZDA = time.time()
    #                 # print(str(dataString))
    #
    #             if (dataString.startswith("$WIMDA") and mSR.getDeltaTime(lastWIMDA,delta)):
    #                 mSR.WIMDAWrite(dataString,dateTime)
    #                 lastWIMDA = time.time()
    #                 # print(str(dataString))
    #
    #             if (dataString.startswith("$YXXDR,") and mSR.getDeltaTime(lastYXXDR,delta)):
    #                 mSR.YXXDRWrite(dataString,dateTime)
    #                 lastYXXDR = time.time()
    #                 # print(str(dataString))
    #
    #             line = []
    #             break

def getMonthNum(monthStr):
    if monthStr == "Jan":
        return "01"
    if monthStr == "Feb":
        return "02"
    if monthStr == "Mar":
        return "03"
    if monthStr == "Apr":
        return "04"
    if monthStr == "May":
        return "05"
    if monthStr == "Jun":
        return "06"
    if monthStr == "Jul":
        return "07"
    if monthStr == "Aug":
        return "08"
    if monthStr == "Sep":
        return "09"
    if monthStr == "Oct":
        return "10"
    if monthStr == "Nov":
        return "11"
    if monthStr == "Dec":
        return "12"
    else:
        return "xx"



if __name__ == "__main__":
   main()
