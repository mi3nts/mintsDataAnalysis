clc
clear all 
close all


%% Loading the Models 


clc 
clear all
close all 

%% P1 - Specifying Parametors  

% Put all data in one time table with the following headers - dateTime, pm1
%, pm2.5 pm10 

dataFolder         = "/media/teamlary/Team_Lary_1/gitGubRepos/data/mintsData";
rawDataFolder        = dataFolder + "/raw"

rawDotMatsFolder     = dataFolder    +  "/rawDotMats";


nodeID             = "001e06323a06";

dtSteps = [seconds(10), seconds(20), seconds(30), minutes(1), minutes(2) , minutes(5) , minutes(10), hours(1)]  ; 

% countsMA = 360 ;
movingAverage = false;


startDate  = datetime(2019,02,12) ;
endDate    = datetime(2019,05,05);

%% Collecting Time Tables 
% 
saveAllMints(rawDataFolder,rawDotMatsFolder,nodeID,"OPCN3");
saveAllMints(rawDataFolder,rawDotMatsFolder,nodeID,"BME280");
saveAllMints(rawDataFolder,rawDotMatsFolder,nodeID,"LIBRAD");
saveAllMints(rawDataFolder,rawDotMatsFolder,nodeID,"MGS001");
saveAllMints(rawDataFolder,rawDotMatsFolder,nodeID,"SCD30");
saveAllMints(rawDataFolder,rawDotMatsFolder,nodeID,"TSL2591");
saveAllMints(rawDataFolder,rawDotMatsFolder,nodeID,"VEML6070");


OPCN3TT    = table2timetable(concatDotMatsMints(rawDotMatsFolder,nodeID,"OPCN3",startDate,endDate));
% 
% saveAllMints(rawDataFolder,rawDotMatsFolder,nodeID,"BME280");
BME280TT   = table2timetable(concatDotMatsMints(rawDotMatsFolder,nodeID,"BME280",startDate,endDate));
% 
% saveAllMints(rawDataFolder,rawDotMatsFolder,nodeID,"LIBRAD");
LIBRADTT   = table2timetable(concatDotMatsMints(rawDotMatsFolder,nodeID,"LIBRAD",startDate,endDate));
% 
% saveAllMints(rawDataFolder,rawDotMatsFolder,nodeID,"MGS001");
MGS001TT   = table2timetable(concatDotMatsMints(rawDotMatsFolder,nodeID,"MGS001",startDate,endDate));
% 
% saveAllMints(rawDataFolder,rawDotMatsFolder,nodeID,"SCD30");
SCD30TT    = table2timetable(concatDotMatsMints(rawDotMatsFolder,nodeID,"SCD30",startDate,endDate));
% 
% saveAllMints(rawDataFolder,rawDotMatsFolder,nodeID,"TSL2591");
TSL2591TT  = table2timetable(concatDotMatsMints(rawDotMatsFolder,nodeID,"TSL2591",startDate,endDate));
% 
% saveAllMints(rawDataFolder,rawDotMatsFolder,nodeID,"VEML6070");
VEML6070TT = table2timetable(concatDotMatsMints(rawDotMatsFolder,nodeID,"VEML6070",startDate,endDate));
% % 
% eval(strcat("save('",rawDataFolder,"/",nodeID,"/mints_FW_node_1_1_data_from_",string(startDate),"_to_",string(endDate),"_as_is_data_Node_",nodeID,"')"))



%% Make One Folder to save all 

    dt = seconds(60)

    %% Time Averaging Data
    OPCN3Retime     =  retime(rmmissing(OPCN3TT)   ,'regular',@nanmean,'TimeStep',dt);
    BME280Retime    =  retime(rmmissing(BME280TT)  ,'regular',@nanmean,'TimeStep',dt);
    LIBRADRetime    =  retime(rmmissing(LIBRADTT)  ,'regular',@nanmean,'TimeStep',dt);
    MGS001Retime    =  retime(rmmissing(MGS001TT)  ,'regular',@nanmean,'TimeStep',dt);
    SCD30Retime     =  retime(rmmissing(SCD30TT)   ,'regular',@nanmean,'TimeStep',dt);
    TSL2591Retime   =  retime(rmmissing(TSL2591TT) ,'regular',@nanmean,'TimeStep',dt);
    VEML6070Retime  =  retime(rmmissing(VEML6070TT),'regular',@nanmean,'TimeStep',dt);

    %% Synchrozing Data 

    mints =  rmmissing(synchronize(OPCN3Retime,BME280Retime,'intersection'));
    mints =  rmmissing(synchronize(mints,LIBRADRetime,'intersection'));
    mints =  rmmissing(synchronize(mints,MGS001Retime,'intersection'));
    mints =  rmmissing(synchronize(mints,SCD30Retime,'intersection'));
    mints =  rmmissing(synchronize(mints,TSL2591Retime,'intersection'));
    mints =  rmmissing(synchronize(mints,VEML6070Retime,'intersection'));

    if( nodeID == "001e06323a06")
        deleteRangeBegin  =  datetime(2019,2,15,16,00,00,'timezone','utc');
        deleteRangeEnd    =  datetime(2019,2,16,2,00,00,'timezone','utc');
        mints(mints.dateTime>deleteRangeBegin&mints.dateTime<deleteRangeEnd,:) = []  ;
        deleteRangeEnd  =  datetime(2019,2,12,12,00,00,'timezone','utc');
        mints(mints.dateTime<deleteRangeEnd,:) = []  ;   
    end

    
eval(strcat("save('",dataFolder,"/",nodeID,"/mints_FW_node_Calib_2_1_data_from_",string(startDate),"_to_",string(endDate),"_in_",...
       strrep(string(dt)," ","_"),"_averaged_slices_for_Node_",nodeID,"',",...
       "'mints','dt','startDate','endDate','nodeID')"))

   
   
   

   
 
% 
% clear grimmRetime  OPCN3Retime  BME280Retime  LIBRADRetime MGS001Retime SCD30Retime TSL2591Retime  VEML6070Retime 
% clear TT1 mints
% 














