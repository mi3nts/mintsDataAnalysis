%% MAIN 1: Save All Data as Dot Mats 

close all 
clearvars -except ...
WantedVariablesNames AllVariables calibratedFolder dataFolder dataFolderPre ...
datesIn deliverablesFolder dt dtSteps endDate mintsDotMats modelsFolder...
modelsFolderPre nodeID nodeList RegressionVariables RegressionVariablesLabels...
startDate VersionSt VersionStPalas VersionStAirMar wantedOut WantedVariablesPalas...
WantedVariablesAirMar saveAllInRange wantedOutLabels

dataFolderPre   = "/media/teamlary/Team_Lary_2/air930/mintsData"

dtSteps = [seconds(30)]  

deliverablesFolder = dataFolderPre + "/deliverables"
calibratedFolder   = dataFolderPre + "/calibrated"


startDate          = datetime(2019,06,25) ;
endDate            = datetime(2019,07,10);

nodeID             = "001e06305a12"
modelsFolderPre    =  deliverablesFolder + "/models"
dataFolder         =  dataFolderPre + "/raw";
mintsDotMats       = "/media/teamlary/Team_Lary_2/air930/mintsData/liveUpdate/dotMats" ;
liveResultsFolder  = "/media/teamlary/Team_Lary_2/air930/mintsData/liveUpdate/results" ;

latestUpdateFolder = "/media/teamlary/Team_Lary_2/air930/mintsData/liveUpdate/results" + "/" + nodeID;

inode=1


% Keeping the models

%% Loading Models for the Given Calibrations 


for ivar=1:length(WantedVariablesPalas)
    Mdl_Dir=strcat(modelsFolder,nodeList{inode},"/",WantedVariablesPalas{ivar}, "/");
    Mdl_Dir_Ver=strcat(Mdl_Dir,VersionStPalas,"/");
    disp(Mdl_Dir_Ver);

   fn_mat_ver = strcat(Mdl_Dir_Ver,WantedVariablesPalas{ivar},'.mat');
   load(fn_mat_ver);
   command =strcat(WantedVariablesPalas(ivar),"_",nodeID,"=Mdl;") ;
   display(command);
   eval(command) ;              
                      
                       
 end


                       
for ivar=1:length(WantedVariablesAirMar)
    Mdl_Dir=strcat(modelsFolder,nodeList{inode},"/",WantedVariablesAirMar{ivar}, "/");
    Mdl_Dir_Ver=strcat(Mdl_Dir,VersionStAirMar,"/");
    disp(Mdl_Dir_Ver);

    Mdl_Dir_Ver=strcat(Mdl_Dir,VersionSt,"/");
    fn_mat_ver = strcat(Mdl_Dir_Ver,WantedVariablesAirMar{ivar},'.mat');
    load(fn_mat_ver);
    predictedLabel= strrep(WantedVariablesAirMar{ivar},"grimm","predicted_RF");
    command = strcat("calibrated.",predictedLabel,"= predict(Mdl,In);");
    eval(command) 
                       
                       
                       
  end
                       
                       





while(true)
%     try

    givenDate = datetime('now','TimeZone','UTC')
    givenDate.Hour   = 0;
    givenDate.Minute = 0;
    givenDate.Second = 0;

    tic
    % RSYNCING LIVE UPDATES 
    system('rsync -avzrtu -e "ssh -p 2222"  mints@mintsdata.utdallas.edu:raw/ /media/teamlary/Team_Lary_2/air930/mintsData/raw/')  ;

    %% Getting Todays Data 
    mints              = getTodaysDataFile(dataFolder,mintsDotMats,nodeID,seconds(30));

    inode =1
    nodeList = {nodeID}

    %% Running the Calibration
    % 
    %            if(~isempty(mints))
                       calibrated = mints;
                       command=strcat(';In=[');
                       for iname=1:length(RegressionVariables)
                           command=strcat(command,'mints.',RegressionVariables{iname}," ");
                       end        
                       command=strcat(command,'];whos In Out');
                       disp(command);
                       eval(command);

    %                          % Loop over Wanted Variables for PM
    %                          Calibrations 
                       for ivar=1:length(WantedVariablesPalas)
                            Mdl_Dir=strcat(modelsFolder,nodeList{inode},"/",WantedVariablesPalas{ivar}, "/");
                            Mdl_Dir_Ver=strcat(Mdl_Dir,VersionStPalas,"/");
                            disp(Mdl_Dir_Ver);

%                             Mdl_Dir_Ver=strcat(Mdl_Dir,VersionSt,"/");
                            fn_mat_ver = strcat(Mdl_Dir_Ver,WantedVariablesPalas{ivar},'.mat');
                            load(fn_mat_ver);
                            predictedLabel= strrep(WantedVariablesPalas{ivar},"grimm","predicted_RF");
%                             command = strcat("calibrated.",predictedLabel,"= predict(Mdl,In);");
                            command = strcat("calibrated.",predictedLabel,"= predict(",WantedVariablesPalas(ivar),"_",nodeID,",In);");
%                             WantedVariablesPalas(ivar),"_",nodeID
                           display(command) ;
                            
                            eval(command) ;
                       
                       
                       
                       end
                       
                       for ivar=1:length(WantedVariablesAirMar)
                            Mdl_Dir=strcat(modelsFolder,nodeList{inode},"/",WantedVariablesAirMar{ivar}, "/");
                            Mdl_Dir_Ver=strcat(Mdl_Dir,VersionStAirMar,"/");
                            disp(Mdl_Dir_Ver);

%                             Mdl_Dir_Ver=strcat(Mdl_Dir,VersionSt,"/");
                            fn_mat_ver = strcat(Mdl_Dir_Ver,WantedVariablesAirMar{ivar},'.mat');
                            load(fn_mat_ver);
                            predictedLabel= strrep(WantedVariablesAirMar{ivar},"grimm","predicted_RF");
                            command = strcat("calibrated.",predictedLabel,"= predict(Mdl,In);");
                            eval(command) 
                       
                       
                       
                       end
                       
                       
                       
                       
                       
                       
                       
                       
                        wantedOut
                        outCalibrated            = calibrated(:,wantedOut);
                        outCalibrated.Properties.VariableNames = wantedOutLabels;
%                         outCalibrated.dateTime.Format = 	'yyyymmdd''T''HHMMSS';
                        printCSVDaily2(outCalibrated,liveResultsFolder,nodeID,givenDate,"calibrated_UTC")    
                        drawAllTimeSeriesPlots2(outCalibrated,nodeID,givenDate,liveResultsFolder,"UTC")
                        drawContourPlot2(outCalibrated,nodeID,{"UTC Time(hours)";string(givenDate)},...
                                                           "Particle Diametors(\mum)",...
                                                           "Particle Size Distribution",...
                                                           givenDate,...
                                                           liveResultsFolder,...
                                                           "Contour_UTC_Time"...
                                                           )
                        
                       printLatestJSON(outCalibrated(end,:),latestUpdateFolder)
                                                       
%                          break                              
                                                       
    % RSYNCING LIVE UPDATES 
    system('rsync -avzrtu -e "ssh -p 2222" /media/teamlary/Team_Lary_2/air930/mintsData/liveUpdate/results/ mints@mintsdata.utdallas.edu:../../Node_data') ;                                                  



    close all 
    clearvars -except ...
    WantedVariablesNames AllVariables calibratedFolder dataFolder dataFolderPre ...
    datesIn deliverablesFolder dt dtSteps endDate mintsDotMats modelsFolder...
    modelsFolderPre nodeID nodeList RegressionVariables RegressionVariablesLabels...
    startDate VersionSt wantedOut WantedVariables saveAllInRange wantedOutLabels ...
    liveResultsFolder latestUpdateFolder ...
    WantedVariablesNames AllVariables calibratedFolder dataFolder dataFolderPre ...
    datesIn deliverablesFolder dt dtSteps endDate mintsDotMats modelsFolder...
    modelsFolderPre nodeID nodeList RegressionVariables RegressionVariablesLabels...
    startDate VersionSt VersionStPalas VersionStAirMar wantedOut WantedVariablesPalas...
    WantedVariablesAirMar saveAllInRange wantedOutLabels
        toc

    
    
 end
        