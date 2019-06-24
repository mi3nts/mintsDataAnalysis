
%% MAIN 1:  Gaining and saving all GRIMM data 

clc 
clear all
close all 

addpath("../functions/")

%% P1 - Specifying Parametors  

% Put all data in one time table with the following headers - dateTime, pm1
%, pm2.5 pm10 

% dataFolderPre      = "/home/lhw150030/mintsData"
dataFolderPre   = "/media/teamlary/Team_Lary_2/air930/mintsData"

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

saveGrimmDates(dataFolder,dataFolderPre,startDate,endDate);
saveGrimmCountsDates(dataFolder,dataFolderPre,startDate,endDate);


