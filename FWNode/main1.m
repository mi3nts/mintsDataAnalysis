
%% MAIN 1:  Gaining and saving all GRIMM data 

clc 
clear all
close all 

addpath("../functions/")

%% P1 - Specifying Parametors  

% Put all data in one time table with the following headers - dateTime, pm1
%, pm2.5 pm10 

dataFolderPre      = "/home/lhw150030/mintsData"
% dataFolder      = "/media/teamlary/Team_Lary_1/gitGubRepos/data/mintsData/reference";
dataFolder      = dataFolderPre  +  "/reference"

dotMatsFolder   = dataFolderPre    +  "/dotMats";

nodeID          = "GRIMM";

grimmDotMats = dotMatsFolder +  "/reference/" + nodeID
% grimmDotMats    = dotMatsFolder +  "/" + nodeID

deliverablesFolder = dataFolderPre + "/deliverables/"

dtSteps = [seconds(10)]  ; 
dt = dtSteps(1)
dmSteps = [minutes(5), minutes(10)]  ; 

startDate  = datetime(2019,02,12) ;
endDate    = datetime(2019,04,29);

%% Collecting Time Tables 

% saveAllGrimm(dataFolder,dataFolderPre);
% saveAllGrimmCounts(dataFolder,dataFolderPre);

grimmTT          =  table2timetable(concatDotMatsGrimm(grimmDotMats,startDate,endDate));
grimmCountsTT    =  table2timetable(concatDotMatsGrimmCounts(grimmDotMats,startDate,endDate));

GRIMMRetime       =  retime(rmmissing(grimmTT) ,'regular',@nanmean,'TimeStep',dt);
GRIMMCountsRetime =  retime(rmmissing(grimmCountsTT),'regular',@nanmean,'TimeStep',dt);

mintsGrimm =  rmmissing(synchronize(GRIMMRetime,GRIMMCountsRetime,'intersection'));

% eval(strcat("save ",deliverablesFolder,"mintsFW_1_1_from_",string(startDate),"_to_",string(endDate),"_in_",strrep(string(dt)," ","_"),"_Slices_Node_",nodeID))

fileNameIn  = strcat("mintsFW_1_1_from_",string(startDate),"_to_",string(endDate),"_in_",strrep(string(dt)," ","_"),"_Slices_Node_",nodeID)

saveAllData(deliverablesFolder,fileNameIn)


eval(strcat("save('",deliverablesFolder,"/mints_FW_node_1_2_data_from_",string(startDate),"_to_",string(endDate),"_in_",...
       strrep(string(dt)," ","_"),"_averaged_slices_for_Node_",nodeID,"',",...
       "'mintsGrimm','dt','startDate','endDate','nodeID')"))


