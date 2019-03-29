

%% P1 - Read Spectrometor Data - 

% Put all data in one time table with the following headers - dateTime, pm1
%, pm2.5 pm10 

dataFolder      = "/media/teamlary/Team_Lary_1/gitGubRepos/data/mintsData";
dotMatsFolder   = dataFolder    +  "/dotMats";
grimmDataFolder = dataFolder    +  "/Spectrometor";
grimmDotMats    = dotMatsFolder +  "/Spectrometor";
nodeID          = "001e06323a06";

dt =minutes(1);
countsMA = 360 ;
movingAverage = false;

startDate  = datetime(2019,02,12) ;
endDate    = datetime(2019,03,12);


%% Load the files you need as one 

% saveAllGrimm(dataFolder);
% grimmTT    =  table2timetable(concatDotMatsGrimm(grimmDotMats,startDate,endDate));
% 
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"OPCN3");
% OPCN3TT    = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"OPCN3",startDate,endDate));
% 
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"BME280");
% BME280TT   = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"BME280",startDate,endDate));
% 
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"LIBRAD");
% LIBRADTT   = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"LIBRAD",startDate,endDate));
% 
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"MGS001");
% MGS001TT   = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"MGS001",startDate,endDate));
% 
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"SCD30");
% SCD30TT    = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"SCD30",startDate,endDate));
% 
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"TSL2591");
% TSL2591TT  = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"TSL2591",startDate,endDate));
% 
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"VEML6070");
% VEML6070TT = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"VEML6070",startDate,endDate));







grimmRetime     =  retime(rmmissing(grimmTT)   ,'regular',@nanmean,'TimeStep',dt);
OPCN3Retime     =  retime(rmmissing(OPCN3TT)   ,'regular',@nanmean,'TimeStep',dt);
BME280Retime    =  retime(rmmissing(BME280TT)  ,'regular',@nanmean,'TimeStep',dt);
LIBRADRetime    =  retime(rmmissing(LIBRADTT)  ,'regular',@nanmean,'TimeStep',dt);
MGS001Retime    =  retime(rmmissing(MGS001TT)  ,'regular',@nanmean,'TimeStep',dt);
SCD30TTRetime   =  retime(rmmissing(SCD30TT)   ,'regular',@nanmean,'TimeStep',dt);
TSL2591Retime   =  retime(rmmissing(TSL2591TT) ,'regular',@nanmean,'TimeStep',dt);
VEML6070Retime  =  retime(rmmissing(VEML6070TT),'regular',@nanmean,'TimeStep',dt);
% 
TT1   =  synchronize(grimmRetime,OPCN3Retime,'intersection');
mints =  rmmissing(synchronize(TT1,BME280Retime,'intersection'));
mints =  rmmissing(synchronize(mints,LIBRADRetime,'intersection'));
mints =  rmmissing(synchronize(mints,MGS001Retime,'intersection'));
mints =  rmmissing(synchronize(mints,SCD30TTRetime,'intersection'));
mints =  rmmissing(synchronize(mints,TSL2591Retime,'intersection'));
mints =  rmmissing(synchronize(mints,VEML6070Retime,'intersection'));

% if(movingAverage)
%     mints = getMovingAverage(mints,countsMA);
%     eval(strcat("save mints_",strrep(string(dt)," ","_"),"_Chuncks"))
% end
 





if( nodeID == "001e06323a06")
    deleteRangeBegin  =  datetime(2019,2,15,16,00,00,'timezone','utc');
    deleteRangeEnd    =  datetime(2019,2,16,2,00,00,'timezone','utc');
    mints(mints.dateTime>deleteRangeBegin&mints.dateTime<deleteRangeEnd,:) = []  ;
    
    deleteRangeEnd  =  datetime(2019,2,12,12,00,00,'timezone','utc');
    mints(mints.dateTime<deleteRangeEnd,:) = []  ;
    
end
    

eval(strcat("save mints_1_",strrep(string(dt)," ","_"),"_Chuncks"))

% nodeDataFolder = dataFolder+  "/001e06323a06";
% nodeDotMats    =  dotMatsFolder + "/OPCN3";
% 
% nodeDataAll    = dir(nodeDataFolder+ "/**/**/*.csv");
% nodeDataTable  = unique(struct2table(nodeDataAll),'rows');
% nodeDataWanted = grimmDataTable(endsWith(nodeDataTable.name,'-M.dat'),:);
% 
% OPCN3Data      = nodeDataTable(contains(nodeDataTable.name,"OPCN3"),:);
% OPCN3MintsFiles = getMintsSensorFiles(dataFolder,nodeID,"OPCN3") ;
% 
