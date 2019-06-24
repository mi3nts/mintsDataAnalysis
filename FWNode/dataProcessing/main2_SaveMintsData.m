close all 
clearvars -except dataFolderPre dataFolder nodeIDGrimm dataFolderGrimm mintsDotMats nodeID deliverablesFolder dtSteps dt dmSteps startDate endDate grimmDotMats mintsDotMats

%% Main2 - Save Mints Data 

% Collecting and Saving GRIMM Time Tables 

saveMintsDates(dataFolder,mintsDotMats,nodeID,"GPSGPRMC",startDate,endDate);
saveMintsDates(dataFolder,mintsDotMats,nodeID,"GPSGPGGA",startDate,endDate);
saveMintsDates(dataFolder,mintsDotMats,nodeID,"OPCN3",startDate,endDate);
saveMintsDates(dataFolder,mintsDotMats,nodeID,"LIBRAD",startDate,endDate);
saveMintsDates(dataFolder,mintsDotMats,nodeID,"BME280",startDate,endDate);
saveMintsDates(dataFolder,mintsDotMats,nodeID,"MGS001",startDate,endDate);
saveMintsDates(dataFolder,mintsDotMats,nodeID,"SCD30",startDate,endDate);
saveMintsDates(dataFolder,mintsDotMats,nodeID,"TSL2591",startDate,endDate);
saveMintsDates(dataFolder,mintsDotMats,nodeID,"VEML6070",startDate,endDate);


GPSGPRMCTT = table2timetable(concatDotMatsMints(mintsDotMats,nodeID,"GPSGPRMC",startDate,endDate));
GPSGPGGATT = table2timetable(concatDotMatsMints(mintsDotMats,nodeID,"GPSGPGGA",startDate,endDate));
OPCN3TT    = table2timetable(concatDotMatsMints(mintsDotMats,nodeID,"OPCN3",startDate,endDate));
BME280TT   = table2timetable(concatDotMatsMints(mintsDotMats,nodeID,"BME280",startDate,endDate));
LIBRADTT   = table2timetable(concatDotMatsMints(mintsDotMats,nodeID,"LIBRAD",startDate,endDate));
MGS001TT   = table2timetable(concatDotMatsMints(mintsDotMats,nodeID,"MGS001",startDate,endDate));
SCD30TT    = table2timetable(concatDotMatsMints(mintsDotMats,nodeID,"SCD30",startDate,endDate));
TSL2591TT  = table2timetable(concatDotMatsMints(mintsDotMats,nodeID,"TSL2591",startDate,endDate));
VEML6070TT = table2timetable(concatDotMatsMints(mintsDotMats,nodeID,"VEML6070",startDate,endDate));

 fileNameIn  = strcat("mints_node_2_1_data_from_",string(startDate),"_to_",string(endDate),"_as_is_data_Node_",nodeID);
 saveAllData(deliverablesFolder,fileNameIn)

 
   %% Time Averaging Data
    GPSGPRMCRetime  =  retime(rmmissing(GPSGPRMCTT),'regular',@nanmean,'TimeStep',dt);
    GPSGPGGARetime  =  retime(rmmissing(GPSGPGGATT),'regular',@nanmean,'TimeStep',dt);
    OPCN3Retime     =  retime(rmmissing(OPCN3TT)   ,'regular',@nanmean,'TimeStep',dt);
    BME280Retime    =  retime(rmmissing(BME280TT)  ,'regular',@nanmean,'TimeStep',dt);
    LIBRADRetime    =  retime(rmmissing(LIBRADTT)  ,'regular',@nanmean,'TimeStep',dt);
    MGS001Retime    =  retime(rmmissing(MGS001TT)  ,'regular',@nanmean,'TimeStep',dt);
    SCD30Retime     =  retime(rmmissing(SCD30TT)   ,'regular',@nanmean,'TimeStep',dt);
    TSL2591Retime   =  retime(rmmissing(TSL2591TT) ,'regular',@nanmean,'TimeStep',dt);
    VEML6070Retime  =  retime(rmmissing(VEML6070TT),'regular',@nanmean,'TimeStep',dt);

    %% Synchrozing Data 

    mints =  rmmissing(synchronize(GPSGPRMCRetime,GPSGPGGARetime,'intersection'));
    mints =  rmmissing(synchronize(mints,OPCN3Retime,'intersection'));
    mints =  rmmissing(synchronize(mints,BME280Retime,'intersection'));
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


eval(strcat("save('",deliverablesFolder,"/mints_node_2_2_data_from_",string(startDate),"_to_",string(endDate),"_in_",...
       strrep(string(dt)," ","_"),"_averaged_slices_for_Node_",nodeID,"',",...
       "'mints','dt','startDate','endDate','nodeID')"))

   