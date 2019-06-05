
%% MAIN 1:  Gaining and saving all GRIMM data 

clc 
clear all
close all 

addpath("../functions/")

%% P1 - Specifying Parametors  

% Put all data in one time table with the following headers - dateTime, pm1
%, pm2.5 pm10 

dataFolder      = "/media/teamlary/Team_Lary_1/gitGubRepos/data/mintsData/reference";
dotMatsFolder   = dataFolder    +  "/dotMats";

nodeID          = "GRIMM";

grimmDataFolder = dataFolder    +  "/" + nodeID;
grimmDotMats    = dotMatsFolder +  "/" + nodeID;

deliverablesFolder = dataFolder + "/deliverables/" + nodeID

dtSteps = [seconds(10)]  ; 
dt = dtSteps(1)
dmSteps = [minutes(5), minutes(10)]  ; 

startDate  = datetime(2019,02,12) ;
endDate    = datetime(2019,04,29);

%% Collecting Time Tables 

saveAllGrimm(dataFolder);
saveAllGrimmCounts(dataFolder);

grimmTT          =  table2timetable(concatDotMatsGrimm(grimmDotMats,startDate,endDate));
grimmCountsTT    =  table2timetable(concatDotMatsGrimmCounts(grimmDotMats,startDate,endDate));

mintsGRIMM    =  retime(rmmissing(grimmTT)   ,'regular',@nanmean,'TimeStep',dt);

eval(strcat("save ",deliverablesFolder,"mintsFW_1_1_from_",string(startDate),"_to_",string(endDate),"_in_",strrep(string(dt)," ","_"),"_Slices_Node_",nodeID))
% 