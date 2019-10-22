%% MAIN 2: Produce CDT Outputs

close all 
clearvars -except ...
WantedVariablesNames AllVariables calibratedFolder dataFolder dataFolderPre ...
datesIn deliverablesFolder dt dtSteps endDate mintsDotMats modelsFolder...
modelsFolderPre nodeID nodeList RegressionVariables RegressionVariablesLabels...
startDate VersionSt wantedOut WantedVariables saveAllInRange

for dateNow = 1:length(datesIn)
% Loop over dates

 
    givenDate = datesIn(dateNow)
    givenDate.TimeZone ='America/Chicago';
    for inode=1:length(nodeList)      
            
             if(~saveAllInRange)
                saveMintsDates(dataFolder,mintsDotMats,nodeID,"GPSGPRMC",givenDate,givenDate);
                saveMintsDates(dataFolder,mintsDotMats,nodeID,"GPSGPGGA",givenDate,givenDate);
                saveMintsDates(dataFolder,mintsDotMats,nodeID,"OPCN3",givenDate,givenDate);
                saveMintsDates(dataFolder,mintsDotMats,nodeID,"LIBRAD",givenDate,givenDate);
                saveMintsDates(dataFolder,mintsDotMats,nodeID,"BME280",givenDate,givenDate);
                saveMintsDates(dataFolder,mintsDotMats,nodeID,"MGS001",givenDate,givenDate);
                saveMintsDates(dataFolder,mintsDotMats,nodeID,"SCD30",givenDate,givenDate);
                saveMintsDates(dataFolder,mintsDotMats,nodeID,"TSL2591",givenDate,givenDate);
                saveMintsDates(dataFolder,mintsDotMats,nodeID,"VEML6070",givenDate,givenDate); 
            end
            
        
        
        
            mints = getCDTDailyDataForFW(givenDate,nodeID,mintsDotMats,dt);
            
            if(~isempty(mints))
                   calibrated = mints;
                   command=strcat(';In=[');
                   for iname=1:length(RegressionVariables)
                       command=strcat(command,'mints.',RegressionVariables{iname}," ");
                   end        
                   command=strcat(command,'];whos In Out');
                   disp(command);
                   eval(command);

                    drawContourPlot(calibrated,nodeID,{"CDT Time(hours)";string(givenDate)},...
                                                       "Particle Diametors(\mum)",...
                                                       "Particle Size Distribution",...
                                                       givenDate,...
                                                       calibratedFolder,...
                                                       "Contour_CDT_Time"...
                                                       )
                   
%                    
                   
                         % Loop over Wanted Variables
                   for ivar=1:length(WantedVariables)
                        Mdl_Dir=strcat(modelsFolder,nodeList{inode},"/",WantedVariables{ivar}, "/");
                        Mdl_Dir_Ver=strcat(Mdl_Dir,VersionSt,"/");
                        disp(Mdl_Dir_Ver);

                        Mdl_Dir_Ver=strcat(Mdl_Dir,VersionSt,"/");
                        fn_mat_ver = strcat(Mdl_Dir_Ver,WantedVariables{ivar},'.mat');
                        load(fn_mat_ver);
                        predictedLabel= strrep(WantedVariables{ivar},"grimm","predicted_RF");
                        command = strcat("calibrated.",predictedLabel,"= predict(Mdl,In);");
                        eval(command) 
                   end

                    outCalibrated            = calibrated(:,wantedOut);
                    printCSVDaily(calibrated,wantedOut,calibratedFolder,nodeID,givenDate,"calibrated_CDT")    
                    drawAllTimeSeriesPlots(calibrated,nodeID,givenDate,calibratedFolder,"CDT")


                    clear calibrated mdl 
            end % Check If data is Available
            
    end% Loop over Nodes
   
end % Loop over Dates 






