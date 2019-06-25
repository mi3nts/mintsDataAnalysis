%% MAIN 0: Definitions

clc 
clear all
close all 

addpath("../../functions/")

% dataFolderPre      = "/home/lhw150030/mintsData"
dataFolderPre   = "/media/teamlary/Team_Lary_2/air930/mintsData"

dtSteps = [seconds(30)]  

deliverablesFolder = dataFolderPre + "/deliverables"

startDate          = datetime(2019,05,01) ;
endDate            = datetime(2019,05,02);

nodeID             = "001e06323a06";
modelsFolderPre    =  deliverablesFolder + "/models"
dataFolder           = dataFolderPre + "/raw";
mintsDotMats  = dataFolderPre +  "/dotMats/raw" ;
datesIn = startDate:days(1):endDate;
    
dt = seconds(30);

   nodeList={...
        nodeID ...
        };

    WantedVariables={...
        'pm10_grimm',...
        'pm2_5_grimm',...
        'pm1_grimm',...
        'inhalable_grimm',...
        'thoracic_grimm',...
        'alveolic_grimm'...
        };

    WantedVariablesNames={...
        'PM_{10}',...
        'PM_{2.5}',...
        'PM_{1}',...
        'Inhalable',...
        'Thoracic',...
        'Alveolic'...
        };

    AllVariables={...
        'latitude_GPSGPRMC',...
        'longitude_GPSGPRMC',...
        'speedOverGround_GPSGPRMC',...
        'latitude_GPSGPGGA',...
        'longitude_GPSGPGGA',...
        'gpsQuality_GPSGPGGA',...
        'numberOfSatelites_GPSGGA',...
        'horizontalDilution_GPSGPGGA',...
        'altitude_GPSGPGGA',...
        'undulation_GPSGPGGA',...
        'valid_OPCN3',...
        'binCount0_OPCN3',...
        'binCount1_OPCN3',...
        'binCount2_OPCN3',...
        'binCount3_OPCN3',...
        'binCount4_OPCN3',...
        'binCount5_OPCN3',...
        'binCount6_OPCN3',...
        'binCount7_OPCN3',...
        'binCount8_OPCN3',...
        'binCount9_OPCN3',...
        'binCount10_OPCN3',...
        'binCount11_OPCN3',...
        'binCount12_OPCN3',...
        'binCount13_OPCN3',...
        'binCount14_OPCN3',...
        'binCount15_OPCN3',...
        'binCount16_OPCN3',...
        'binCount17_OPCN3',...
        'binCount18_OPCN3',...
        'binCount19_OPCN3',...
        'binCount20_OPCN3',...
        'binCount21_OPCN3',...
        'binCount22_OPCN3',...
        'binCount23_OPCN3',...
        'bin1TimeToCross_OPCN3',...
        'bin3TimeToCross_OPCN3',...
        'bin5TimeToCross_OPCN3',...
        'bin7TimeToCross_OPCN3',...
        'samplingPeriod_OPCN3',...
        'sampleFlowRate_OPCN3',...
        'temperature_OPCN3',...
        'humidity_OPCN3',...
        'pm1_OPCN3',...
        'pm2_5_OPCN3',...
        'pm10_OPCN3',...
        'rejectCountGlitch_OPCN3',...
        'rejectCountLongTOF_OPCN3',...
        'rejectCountRatio_OPCN3',...
        'rejectCountOutOfRange_OPCN3',...
        'fanRevCount_OPCN3',...
        'laserStatus_OPCN3',...
        'checkSum_OPCN3',...
        'temperature_BME280',...
        'pressure_BME280',...
        'humidity_BME280',...
        'alititude_BME280',...
        'countPerMinute_LIBRAD',...
        'radiationValue_LIBRAD',...
        'timeSpent_LIBRAD',...
        'LIBRADCount_LIBRAD',...
        'nh3_MGS001',...
        'co_MGS001',...
        'no2_MGS001',...
        'c3h8_MGS001',...
        'c4h10_MGS001',...
        'ch4_MGS001',...
        'h2_MGS001',...
        'c2h5oh_MGS001',...
        'c02_SCD30',...
        'temperature_SCD30',...
        'humidity_SCD30',...
        'luminosity_TSL2591',...
        'ir_TSL2591',...
        'full_TSL2591',...
        'visible_TSL2591',...
        'lux_TSL2591',...
        'UVLightLevel_VEML6070',...
        };

    RegressionVariables={...
        'binCount0_OPCN3',...
        'binCount1_OPCN3',...
        'binCount2_OPCN3',...
        'binCount3_OPCN3',...
        'binCount4_OPCN3',...
        'binCount5_OPCN3',...
        'binCount6_OPCN3',...
        'binCount7_OPCN3',...
        'binCount8_OPCN3',...
        'binCount9_OPCN3',...
        'binCount10_OPCN3',...
        'binCount11_OPCN3',...
        'binCount12_OPCN3',...
        'binCount13_OPCN3',...
        'binCount14_OPCN3',...
        'binCount15_OPCN3',...
        'binCount16_OPCN3',...
        'binCount17_OPCN3',...
        'binCount18_OPCN3',...
        'binCount19_OPCN3',...
        'binCount20_OPCN3',...
        'binCount21_OPCN3',...
        'binCount22_OPCN3',...
        'binCount23_OPCN3',...
        'temperature_OPCN3',...
        'humidity_OPCN3',...
        'pm1_OPCN3',...
        'pm2_5_OPCN3',...
        'pm10_OPCN3',...
        'temperature_BME280',...
        'pressure_BME280',...
        'humidity_BME280',...
        'altitude_BME280',...
        'nh3_MGS001',...
        'co_MGS001',...
        'no2_MGS001',...
        'c3h8_MGS001',...
        'c4h10_MGS001',...
        'ch4_MGS001',...
        'h2_MGS001',...
        'c2h5oh_MGS001',...
        'c02_SCD30',...
        'temperature_SCD30',...
        'humidity_SCD30',...
        'luminosity_TSL2591',...
        'ir_TSL2591',...
        'full_TSL2591',...
        'visible_TSL2591',...
        'lux_TSL2591',...
        'UVLightLevel_VEML6070',...
        };


    RegressionVariablesLabels={...
        'Bin 0',...
        'Bin 1',...
        'Bin 2',...
        'Bin 3',...
        'Bin 4',...
        'Bin 5',...
        'Bin 6',...
        'Bin 7',...
        'Bin 8',...
        'Bin 9',...
        'Bin 10',...
        'Bin 11',...
        'Bin 12',...
        'Bin 13',...
        'Bin 14',...
        'Bin 15',...
        'Bin 16',...
        'Bin 17',...
        'Bin 18',...
        'Bin 19',...
        'Bin 20',...
        'Bin 21',...
        'Bin 22',...
        'Bin 23',...
        'Temperature OPC',...
        'Humidity  OPC',...
        'PM_1',...
        'PM_{2.5}',...
        'PM_{10}',...
        'Temperature BME280',...
        'Pressure BME280',...
        'Humidity BME280',...
        'Altitude BME280',...
        'NH_3',...
        'CO',...
        'NO_2',...
        'C_3H_8',...
        'C_4H_10',...
        'CH_4',...
        'H_2',...
        'C_2H_5OH',...
        'CO_2 SCD30',...
        'Temperature SCD30',...
        'Humidity SCD30',...
        'Luminosity TSL2591',...
        'IR TSL2591',...
        'Full TSL2591',...
        'Visible TSL2591',...
        'Lux TSL2591',...
        'UV Light Level VEML6070',...
        };


% saveMintsDates(dataFolder,mintsDotMats,nodeID,"GPSGPRMC",startDate,endDate);
% saveMintsDates(dataFolder,mintsDotMats,nodeID,"GPSGPGGA",startDate,endDate);
% saveMintsDates(dataFolder,mintsDotMats,nodeID,"OPCN3",startDate,endDate);
% saveMintsDates(dataFolder,mintsDotMats,nodeID,"LIBRAD",startDate,endDate);
% saveMintsDates(dataFolder,mintsDotMats,nodeID,"BME280",startDate,endDate);
% saveMintsDates(dataFolder,mintsDotMats,nodeID,"MGS001",startDate,endDate);
% saveMintsDates(dataFolder,mintsDotMats,nodeID,"SCD30",startDate,endDate);
% saveMintsDates(dataFolder,mintsDotMats,nodeID,"TSL2591",startDate,endDate);
% saveMintsDates(dataFolder,mintsDotMats,nodeID,"VEML6070",startDate,endDate);  
%     
% 
% fn_mat_ver=strcat(Mdl_Dir_Ver,WantedVariables{ivar},'.mat');

for dateNow = 1:length(datesIn)
% Loop over dates

    Mdl_Dir=strcat(modelsFolder,nodeList{inode},"/",WantedVariables{ivar}, "/");
    Mdl_Dir_Ver=strcat(Mdl_Dir,VersionSt,"/");

    disp(Mdl_Dir_Ver)

  
    givenDate = datesIn(dateNow)
    for inode=1:length(nodeList)
    % Loop over Nodes  
%          mints = getDailyDataForFW(givenDate,nodeID,mintsDotMats,dt);
%                     
             % Loop over Wanted Variables
             for ivar=1:length(WantedVariables)
                 Mdl_Dir_Ver=strcat(Mdl_Dir,VersionSt,"/")
                 fn_mat     = strcat(Mdl_Dir,WantedVariables{ivar},'.mat')
                 fn_mat_ver = strcat(Mdl_Dir_Ver,WantedVariables{ivar},'.mat')
                 fn_data    = strcat(Mdl_Dir_Ver,nodeList{inode},'_Data.mat')             
             end
             
    end
        
end 


