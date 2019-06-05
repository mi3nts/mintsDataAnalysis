
%% MAIN 1:  Gaining and saving all NODE Data 

clc 
clear all
close all 

addpath("../functions/")

%% P1 - Specifying Parametors  

% Put all data in one time table with the following headers -
% dateTime, pm1, pm2.5 pm10 

dataFolder      = "/media/teamlary/Team_Lary_1/gitGubRepos/data/mintsData";
dotMatsFolder   = dataFolder    +  "/dotMats";

grimmDataFolder = dataFolder    +  "/Spectrometor";
grimmDotMats    = dotMatsFolder +  "/Spectrometor";

nodeID          = "001e06323a06";

deliverablesFolder = dataFolder + "/deliverables/" + nodeID

dtSteps = [seconds(10)]  ; 
dt = dtSteps(1)
dmSteps = [minutes(5), minutes(10)]  ; 

startDate  = datetime(2019,02,12) ;
endDate    = datetime(2019,04,29);

%% Collecting Time Tables 
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"GPSGPRMC");
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"GPSGPGGA");
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"OPCN3");
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"LIBRAD");
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"BME280");
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"MGS001");
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"SCD30");
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"TSL2591");
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"VEML6070");


% GPSGPRMCTT = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"GPSGPRMC",startDate,endDate));
% GPSGPGGATT = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"GPSGPGGA",startDate,endDate));
% OPCN3TT    = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"OPCN3",startDate,endDate));
% BME280TT   = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"BME280",startDate,endDate));
% LIBRADTT   = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"LIBRAD",startDate,endDate));
% MGS001TT   = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"MGS001",startDate,endDate));
% SCD30TT    = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"SCD30",startDate,endDate));
% TSL2591TT  = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"TSL2591",startDate,endDate));
% VEML6070TT = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"VEML6070",startDate,endDate));
% 
% 

fileNameIn  = strcat("mints_FW_node_1_1_data_from_",string(startDate),"_to_",string(endDate),"_as_is_data_Node_",nodeID);
saveAllData(deliverablesFolder,fileNameIn)

% 
