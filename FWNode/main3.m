

%% MAIN 1:  Gaining and saving all GRIMM data 

clc 
clear all
close all 

addpath("../functions/")

%% P1 - Specifying Parametors  

% Put all data in one time table with the following headers - dateTime, pm1
%, pm2.5 pm10 

dataFolderPre      = "/home/lhw150030/mintsData"
% dataFolderPre    = "/media/teamlary/Team_Lary_2/air930/mintsData"
dataFolder         = dataFolderPre  +  "/reference"
% 
% dotMatsFolder   = dataFolderPre    +  "/dotMats";
% 
dtSteps = [seconds(10), seconds(20), seconds(30), minutes(1), minutes(2) , minutes(5) , minutes(10), hours(1)]  

% grimmDotMats = dotMatsFolder +  "/reference/" + nodeID
% % grimmDotMats    = dotMatsFolder +  "/" + nodeID

deliverablesFolder = dataFolderPre + "/deliverables"

dt = dtSteps(1)

startDate  = datetime(2019,02,12) ;
endDate    = datetime(2019,04,29);

%% Loading Grimm Data 
nodeID          = "GRIMM";
eval(strcat("load('",deliverablesFolder,"/mints_FW_node_1_2_data_from_",string(startDate),"_to_",string(endDate),"_in_",...
        strrep(string(dt)," ","_"),"_averaged_slices_for_Node_",nodeID,"')"))

%% Loading Node Data 
nodeID          = "001e06323a06";

eval(strcat("load('",deliverablesFolder,"/mints_FW_node_2_2_data_from_",string(startDate),"_to_",string(endDate),"_in_",...
        strrep(string(dt)," ","_"),"_averaged_slices_for_Node_",nodeID,"')"))
    
%% Syncronizing Data  

mintsAll =  rmmissing(synchronize(mints,mintsGrimm,'intersection'));
    
fileNameIn  = strcat("mints_FW_3_1_from_",string(startDate),"_to_",string(endDate),"_in_",strrep(string(dt)," ","_"),"_Slices_Node_",nodeID)
saveAllData(deliverablesFolder,fileNameIn)

%% 

eval(strcat("save('",deliverablesFolder,"/mints_FW_node_3_2_data_from_",string(startDate),"_to_",string(endDate),"_in_",...
       strrep(string(dt)," ","_"),"_averaged_slices_for_Node_",nodeID,"',",...
       "'mints','dt','startDate','endDate','nodeID')"))


for n=2:length(dtSteps)
    tic
        dt = dtSteps(n)

        %% Time Averaging Data
        mints     =  retime(rmmissing(mintsAll)   ,'regular',@nanmean,'TimeStep',dt);
        eval(strcat("save('",deliverablesFolder,"/mints_FW_node_3_2_data_from_",string(startDate),"_to_",string(endDate),"_in_",...
        strrep(string(dt)," ","_"),"_averaged_slices_for_Node_",nodeID,"',",...
        "'mints','dt','startDate','endDate','nodeID')"))

        clear mints
    toc
    
end




