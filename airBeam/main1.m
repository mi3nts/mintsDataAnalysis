clc
clear all 
close all 

% 

%% P1 - AirBeam Data - 

% Put all data in one time table with the following headers - dateTime, pm1
%, pm2.5 pm10 

dataFolder      = "/media/teamlary/Team_Lary_1/gitGubRepos/data/mintsData";
dotMatsFolder   = dataFolder    +  "/dotMats";
grimmDataFolder = dataFolder    +  "/Spectrometor";
grimmDotMats    = dotMatsFolder +  "/Spectrometor";
nodeID          = "AB_001896107DBA";

dt =minutes(1);
countsMA = 360 ;
movingAverage = false;

startDate  = datetime(2019,02,12) ;
endDate    = datetime(2019,04,12);

%% For Airbeam 1 
% 
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"pm");
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"f");
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"rh");


AB1PMTT           = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"pm",startDate,endDate));
AB1TemperatureTT  = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"f",startDate,endDate));
AB1HumidityTT     = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"rh",startDate,endDate));


% 
% %% For Airbeam 2 
% 
nodeID          = "AB_001896107DBA";
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"pm1");
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"pm2.5");
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"pm10");
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"f");
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"rh");
% 

AB2PM1TT          = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"pm1",startDate,endDate));
AB2PM2_5TT        = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"pm2.5",startDate,endDate));
AB2PM10TT         = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"pm10",startDate,endDate));
AB2TemperatureTT  = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"f",startDate,endDate));
AB2HumidityTT     = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"rh",startDate,endDate));


AB1PMTTRetime         =  retime(rmmissing(AB1PMTT)   ,'regular',@nanmean,'TimeStep',dt);
AB1TemperatureRetime  =  retime(rmmissing(AB1TemperatureTT)   ,'regular',@nanmean,'TimeStep',dt);
AB1HumidityRetime     =  retime(rmmissing(AB1HumidityTT)  ,'regular',@nanmean,'TimeStep',dt);
LIBRADRetime          =  retime(rmmissing(LIBRADTT)  ,'regular',@nanmean,'TimeStep',dt);
MGS001Retime          =  retime(rmmissing(MGS001TT)  ,'regular',@nanmean,'TimeStep',dt);
SCD30TTRetime         =  retime(rmmissing(SCD30TT)   ,'regular',@nanmean,'TimeStep',dt);
TSL2591Retime         =  retime(rmmissing(TSL2591TT) ,'regular',@nanmean,'TimeStep',dt);
VEML6070Retime        =  retime(rmmissing(VEML6070TT),'regular',@nanmean,'TimeStep',dt);


