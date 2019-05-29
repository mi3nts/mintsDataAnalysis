
clc 
clear all
close all 

%% P1 - Specifying Parametors  

% Put all data in one time table with the following headers - dateTime, pm1
%, pm2.5 pm10 

dataFolder       = "/media/teamlary/Team_Lary_1/gitGubRepos/data/mintsData";
dotMatsFolder    = dataFolder    +  "/dotMats";
airMarDataFolder = dataFolder    +  "/Spectrometor";
grimmDotMats     = dotMatsFolder +  "/Spectrometor";
nodeID           = "001e0610c0e4";
% 
% dtSteps = [seconds(10), seconds(20), seconds(30), minutes(1), minutes(2) , minutes(5) , minutes(10), hours(1)]  ; 

dt = seconds(30)  ; 

% countsMA = 360 ;
movingAverage = false;


startDate  = datetime(2019,02,12) ;
endDate    = datetime(2019,04,29);


% saveAllAirMarMints(dataFolder,dotMatsFolder,nodeID,"GPGGA");
% saveAllAirMarMints(dataFolder,dotMatsFolder,nodeID,"GPVTG");
% saveAllAirMarMints(dataFolder,dotMatsFolder,nodeID,"HCHDT");
% saveAllAirMarMints(dataFolder,dotMatsFolder,nodeID,"WIMDA");
% saveAllAirMarMints(dataFolder,dotMatsFolder,nodeID,"WIMWV");
% saveAllAirMarMints(dataFolder,dotMatsFolder,nodeID,"YXXDR");

% 
% saveAllGrimm(dataFolder);

GPGGATT    = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"GPGGA",startDate,endDate));
HCHDTTT    = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"HCHDT",startDate,endDate));
WIMDATT    = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"WIMDA",startDate,endDate));
WIMWVTT    = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"WIMWV",startDate,endDate));
YXXDRTT    = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"YXXDR",startDate,endDate));

eval(strcat("save('",dataFolder,"/",nodeID,"/mints_AirMar_1_1_data_from_",string(startDate),"_to_",string(endDate),"_as_is_data_Node_",nodeID,"')"))

    GPGGARetime    =  retime(rmmissing(GPGGATT)  ,'regular',@nanmean,'TimeStep',dt);
    HCHDTRetime    =  retime(rmmissing(HCHDTTT)  ,'regular',@nanmean,'TimeStep',dt);
    WIMDARetime    =  retime(rmmissing(WIMDATT)  ,'regular',@nanmean,'TimeStep',dt);
    WIMWVRetime    =  retime(rmmissing(WIMWVTT)  ,'regular',@nanmean,'TimeStep',dt);
    YXXDRRetime    =  retime(rmmissing(YXXDRTT)  ,'regular',@nanmean,'TimeStep',dt);
     
    mints =  rmmissing(synchronize(GPGGARetime,HCHDTRetime,'intersection'));
    mints =  rmmissing(synchronize(mints,WIMDARetime,'intersection'));
    mints =  rmmissing(synchronize(mints,WIMWVRetime,'intersection'));
    mints =  rmmissing(synchronize(mints,YXXDRRetime,'intersection'));

eval(strcat("save('",dataFolder,"/",nodeID,"/mints_AirMar_1_2_data_from_",string(startDate),"_to_",string(endDate),"_in_",...
       strrep(string(dt)," ","_"),"_averaged_slices_for_Node_",nodeID,"',",...
       "'mints','dt','startDate','endDate','nodeID')"))

% 
% for now 
% defining the time steps 
% 
% % Gaining data sets for different time steps
% 
% for n=1:length(dtSteps)
% 
%     dt = dtSteps(n)
% 
%     % Time Averaging Data
%     grimmRetime     =  retime(rmmissing(grimmTT)   ,'regular',@nanmean,'TimeStep',dt);
%     OPCN3Retime     =  retime(rmmissing(OPCN3TT)   ,'regular',@nanmean,'TimeStep',dt);
%     BME280Retime    =  retime(rmmissing(BME280TT)  ,'regular',@nanmean,'TimeStep',dt);
%     LIBRADRetime    =  retime(rmmissing(LIBRADTT)  ,'regular',@nanmean,'TimeStep',dt);
%     MGS001Retime    =  retime(rmmissing(MGS001TT)  ,'regular',@nanmean,'TimeStep',dt);
%     SCD30Retime     =  retime(rmmissing(SCD30TT)   ,'regular',@nanmean,'TimeStep',dt);
%     TSL2591Retime   =  retime(rmmissing(TSL2591TT) ,'regular',@nanmean,'TimeStep',dt);
%     VEML6070Retime  =  retime(rmmissing(VEML6070TT),'regular',@nanmean,'TimeStep',dt);
% 
%     % Synchrozing Data 
% 
%     TT1   =  synchronize(grimmRetime,OPCN3Retime,'intersection');
%     mints =  rmmissing(synchronize(TT1,BME280Retime,'intersection'));
%     mints =  rmmissing(synchronize(mints,LIBRADRetime,'intersection'));
%     mints =  rmmissing(synchronize(mints,MGS001Retime,'intersection'));
%     mints =  rmmissing(synchronize(mints,SCD30Retime,'intersection'));
%     mints =  rmmissing(synchronize(mints,TSL2591Retime,'intersection'));
%     mints =  rmmissing(synchronize(mints,VEML6070Retime,'intersection'));
% 
%     if( nodeID == "001e06323a06")
%         deleteRangeBegin  =  datetime(2019,2,15,16,00,00,'timezone','utc');
%         deleteRangeEnd    =  datetime(2019,2,16,2,00,00,'timezone','utc');
%         mints(mints.dateTime>deleteRangeBegin&mints.dateTime<deleteRangeEnd,:) = []  ;
%         deleteRangeEnd  =  datetime(2019,2,12,12,00,00,'timezone','utc');
%         mints(mints.dateTime<deleteRangeEnd,:) = []  ;   
%     end
% 
% 
% eval(strcat("save('",dataFolder,"/",nodeID,"/mints_FW_node_1_2_data_from_",string(startDate),"_to_",string(endDate),"_in_",...
%        strrep(string(dt)," ","_"),"_averaged_slices_for_Node_",nodeID,"',",...
%        "'mints','dt','startDate','endDate','nodeID')"))
% 
% 
% clear grimmRetime  OPCN3Retime  BME280Retime  LIBRADRetime MGS001Retime SCD30Retime TSL2591Retime  VEML6070Retime 
% clear TT1 mints
% 
% end
% 
% % Code to gain a moving average 
% 
% 
% load(strcat("mints_1_2_from_",string(startDate),"_to_",string(endDate),"_in_",strrep(string(dtSteps(1))," ","_"),"_Chuncks_Node_",nodeID))
% clear grimmRetime  OPCN3Retime  BME280Retime  LIBRADRetime MGS001Retime SCD30Retime TSL2591Retime  VEML6070Retime TT1
% clear grimmTT  OPCN3TT  BME280TT  LIBRADTT MGS001TT SCD30TT TSL2591TT  VEML6070TT mintsMA 
% mintsMA  = mints;
%     
% eval(strcat("save mints_1_3_from_",string(startDate),"_to_",string(endDate),"_in_",strrep(string(dtSteps(1))," ","_"),"_Moving_Average_Node_",nodeID))
%     
% for n=2:length(dtSteps)
%     
%     maDt    = dtSteps(n)
%     dt      = dtSteps(1);
%     mintsMA = getMovingAverage(mints,maDt,dtSteps(1));
%     eval(strcat("save mints_1_3_from_",string(startDate),"_to_",string(endDate),"_in_",strrep(string(maDt)," ","_"),"_Moving_Average_Node_",nodeID))
%     clear mintsMA   
%     
%  end 
% 
% % MSCLNS
% 
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
