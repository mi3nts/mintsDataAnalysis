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
endDate    = datetime(2019,03,12);

%% For Airbeam 1 
saveAllMints(dataFolder,dotMatsFolder,nodeID,"pm");
saveAllMints(dataFolder,dotMatsFolder,nodeID,"f");
saveAllMints(dataFolder,dotMatsFolder,nodeID,"rh");


%% For Airbeam 2 
nodeID          = "AB_001896107DBA";
saveAllMints(dataFolder,dotMatsFolder,nodeID,"pm1");
saveAllMints(dataFolder,dotMatsFolder,nodeID,"pm2.5");
saveAllMints(dataFolder,dotMatsFolder,nodeID,"pm10");
saveAllMints(dataFolder,dotMatsFolder,nodeID,"f");
saveAllMints(dataFolder,dotMatsFolder,nodeID,"rh");