%% MAIN 1: Save All Data as Dot Mats 

close all 
clearvars -except ...
WantedVariablesNames AllVariables calibratedFolder dataFolder dataFolderPre ...
datesIn deliverablesFolder dt dtSteps endDate mintsDotMats modelsFolder...
modelsFolderPre nodeID nodeList RegressionVariables RegressionVariablesLabels...
startDate VersionSt wantedOut WantedVariables saveAllInRange

saveMintsDates(dataFolder,mintsDotMats,nodeID,"GPSGPRMC",startDate,endDate);
saveMintsDates(dataFolder,mintsDotMats,nodeID,"GPSGPGGA",startDate,endDate);
saveMintsDates(dataFolder,mintsDotMats,nodeID,"OPCN3",startDate,endDate);
saveMintsDates(dataFolder,mintsDotMats,nodeID,"LIBRAD",startDate,endDate);
saveMintsDates(dataFolder,mintsDotMats,nodeID,"BME280",startDate,endDate);
saveMintsDates(dataFolder,mintsDotMats,nodeID,"MGS001",startDate,endDate);
saveMintsDates(dataFolder,mintsDotMats,nodeID,"SCD30",startDate,endDate);
saveMintsDates(dataFolder,mintsDotMats,nodeID,"TSL2591",startDate,endDate);
saveMintsDates(dataFolder,mintsDotMats,nodeID,"VEML6070",startDate,endDate);  


