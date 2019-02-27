

%% P1 - Read Spectrometor Data - 

% Put all data in one time table with the following headers - dateTime, pm1
%, pm2.5 pm10 

dataFolder      = "/media/teamlary/Team_Lary_1/gitGubRepos/data/mintsData";
dotMatsFolder   = dataFolder+  "/dotMats";
grimmDataFolder = dataFolder+  "/Spectrometor";
grimmDotMats    = dotMatsFolder + "/Spectrometor";

startDate  = datetime(2019,02,12) ;
endDate    = datetime(2019,02,15);



%% Saving All Files As .mat for the Grimm Device




%% Load the files you need as one 

grimmTT =  table2timetable(concatDotMatsGrimm(grimmDotMats,startDate,endDate));

dataFolder     = "/media/teamlary/Team_Lary_1/gitGubRepos/data/mintsData";
dotMatsFolder  =  dataFolder    + "/dotMats";
nodeID         = "001e06323a06";

% saveAllGrimm(dataFolder);
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"OPCN3");
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"BME280");
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"LIBRAD");
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"MGS001");
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"SCD30");
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"TSL2591");
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"VEML6070");


OPCN3TT  = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"OPCN3",startDate,endDate));
BME280TT = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"BME280",startDate,endDate));
LIBRADTT  = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"LIBRAD",startDate,endDate));
MGS001TT = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"MGS001",startDate,endDate));
SCD30TT  = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"SCD30",startDate,endDate));
TSL2591TT = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"TSL2591",startDate,endDate));
VEML6070TT = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"VEML6070",startDate,endDate));




grimmRetime     =  retime(grimmTT,'regular','linear','TimeStep',dt);
OPCN3Retime     =  retime(OPCN3TT,'regular','linear','TimeStep',dt);
BME280Retime    =  retime(BME280TT,'regular','linear','TimeStep',dt);
LIBRADRetime    =  retime(LIBRADTT,'regular','linear','TimeStep',dt);
MGS001Retime    =  retime(MGS001TT,'regular','linear','TimeStep',dt);
SCD30TTRetime   =  retime(SCD30TT,'regular','linear','TimeStep',dt);
TSL2591Retime   =  retime(TSL2591TT,'regular','linear','TimeStep',dt);
VEML6070Retime  =  retime(VEML6070TT,'regular','linear','TimeStep',dt);


TT1 = synchronize(grimmRetime,OPCN3Retime,'intersection');
mints = synchronize(TT1,BME280Retime,'intersection');

if(movingAverage)
    mints = getMovingAverage(mints,countsMA);
end

save mintsDataFinal1 

% nodeDataFolder = dataFolder+  "/001e06323a06";
% nodeDotMats   =  dotMatsFolder + "/OPCN3";
% 
% nodeDataAll    = dir(nodeDataFolder+ "/**/**/*.csv");
% nodeDataTable  = unique(struct2table(nodeDataAll),'rows');
% % nodeDataWanted = grimmDataTable(endsWith(nodeDataTable.name,'-M.dat'),:);
% 
% OPCN3Data      = nodeDataTable(contains(nodeDataTable.name,"OPCN3"),:)
% 

%  OPCN3MintsFiles = getMintsSensorFiles(dataFolder,nodeID,"OPCN3") ;








