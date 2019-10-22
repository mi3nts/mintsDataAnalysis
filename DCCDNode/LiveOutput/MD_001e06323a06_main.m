

%% Loading Model Files for 
% NODE : 001e06305a12
    givenDate = datetime('now','TimeZone','UTC')
    givenDate.Hour   = 0;
    givenDate.Minute = 0;
    givenDate.Second = 0;

    tic
   
    inode =1 ;
    %% Getting Todays Data 
    mints              = getTodaysDataFile(dataFolder,mintsDotMats,nodeID,seconds(30));

    %            if(~isempty(mints))
                       calibrated = mints;
                       command=strcat(';In=[');
                       for iname=1:length(RegressionVariables)
                           command=strcat(command,'mints.',RegressionVariables{iname}," ")
                       end        
                       command=strcat(command,'];whos In Out');
                       disp(command);
                       eval(command);

    %                          % Loop over Wanted Variables for PM
    %                          Calibrations 
                       for ivar=1:length(WantedVariablesGrimm)
%                             Mdl_Dir=strcat(modelsFolder,nodeList{inode},"/",WantedVariablesGrimm{ivar}, "/");
%                             Mdl_Dir_Ver=strcat(Mdl_Dir,VersionStGrimm,"/");
%                             disp(Mdl_Dir_Ver);
% 
% %                             Mdl_Dir_Ver=strcat(Mdl_Dir,VersionSt,"/");
%                             fn_mat_ver = strcat(Mdl_Dir_Ver,WantedVariablesGrimm{ivar},'.mat');
%                             load(fn_mat_ver);
%                             predictedLabel= WantedVariablesGrimm{ivar};
%                           command = strcat("calibrated.",predictedLabel,"= predict(Mdl,In);");
                            predictedLabel= strrep(WantedVariablesGrimm{ivar},"grimm","predicted_RF");
                            command = strcat("calibrated.",predictedLabel,"= predict(mints",nodeID,WantedVariablesGrimm(ivar),",In);");
%                             WantedVariablesGrimm(ivar),"_",nodeID
                           display(command) ;
                            
                           eval(command) ;
                       
                       
                       
                       end
  %%                     
                       for ivar=1:length(WantedVariablesAirMar)
%                             Mdl_Dir=strcat(modelsFolder,nodeList{inode},"/",WantedVariablesAirMar{ivar}, "/");
%                             Mdl_Dir_Ver=strcat(Mdl_Dir,VersionStAirMar,"/");
%                             disp(Mdl_Dir_Ver);
% 
% %                             Mdl_Dir_Ver=strcat(Mdl_Dir,VersionSt,"/");
%                             fn_mat_ver = strcat(Mdl_Dir_Ver,WantedVariablesAirMar{ivar},'.mat');
%                             load(fn_mat_ver);
                            predictedLabel= WantedVariablesAirMar{ivar};
                            command = strcat("calibrated.",predictedLabel,"= predict(mints",nodeID,WantedVariablesAirMar(ivar),",In);");
%                           WantedVariablesGrimm(ivar),"_",nodeID
                            display(command) ;
                            eval(command) ;
                       
                       end
                       
                       
                       
                       
%%                       
                       
                       
                        wantedOut
                        outCalibrated            = calibrated(:,wantedOut);
                        outCalibrated.Properties.VariableNames = wantedOutLabels;
                        outCalibrated.dateTime.Format = 	'yyyy-MM-dd''T''HH:mm:ss';
                        printCSVDaily2(outCalibrated,liveResultsFolder,nodeID,givenDate,"calibrated_UTC")    ;
                        drawAllTimeSeriesPlotsDFW(outCalibrated,nodeID,givenDate,liveResultsFolder,"UTC");
                        drawContourPlot2(outCalibrated,nodeID,{"UTC Time(hours)";string(givenDate)},...
                                                           "Particle Diametors(\mum)",...
                                                           "Particle Size Distribution",...
                                                           givenDate,...
                                                           liveResultsFolder,...
                                                           "Contour_UTC_Time"...
                                                           );
          display("BF")
                                                       
                         printLatestJSON(timetable2table(outCalibrated(end-1:end,:)),latestUpdateFolder);
          display("AF")                                             
%                          break                              
                                                       
%     % RSYNCING LIVE UPDATES 
%     system('rsync -avzrtu -e "ssh -p 2222" /media/teamlary/Team_Lary_2/air930/mintsData/liveUpdate/results/ mints@mintsdata.utdallas.edu:../../Node_data') ;                                                  
% 



