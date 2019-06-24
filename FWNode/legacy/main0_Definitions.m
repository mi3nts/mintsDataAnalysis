
%% MAIN 0:  Definitions 

clc 
clear all
close all 

addpath("../functions/")

%% P1 - Specifying Parametors  

% Put all data in one time table with the following headers -
% dateTime, pm1, pm2.5 pm10 

% dataFolderPre      = "/home/lhw150030/mintsData";
dataFolderPre   = "/media/teamlary/Team_Lary_2/air930/mintsData"

dataFolder      =dataFolderPre + "/raw";

dotMatsFolder   = dataFolderPre + "/dotMats/raw" ;

nodeID          = "001e06323a06";

deliverablesFolder = dataFolderPre + "/deliverables/"

dtSteps = [seconds(10)]  ; 
dt = dtSteps(1)
dmSteps = [minutes(5), minutes(10)]  ; 

startDate  = datetime(2019,04,28) ;
endDate    = datetime(2019,04,29);



