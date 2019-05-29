
from getmac import get_mac_address
import serial.tools.list_ports

def findAirMarPort():
    ports = list(serial.tools.list_ports.comports())
    for p in ports:
        currentPort = str(p[2])
        if(currentPort.find("PID=067B")>=0):
            return(p[0])

dataFolder            = "/media/teamlary/Team_Lary_1/gitGubRepos/data/mintsData"
airMarPort            = "001e0610c0e4"
macAddress            ="001e0610c0e4"
latestOff             = True
