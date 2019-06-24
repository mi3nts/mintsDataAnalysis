
%% MAIN 0:  Definitions 

clc 
clear all
close all 

addpath("../../functions/")

%% P0 - Specifying Parametors  

% Put all data in one time table with the following headers -
% dateTime, pm1, pm2.5 pm10 

% dataFolderPre      = "/home/lhw150030/mintsData";
dataFolderPre   = "/media/teamlary/Team_Lary_2/air930/mintsData"

dataFolder           = dataFolderPre + "/raw";
dataFolderGrimm      = dataFolderPre + "/reference";

dotMatsFolder   = dataFolderPre + "/dotMats" ;

nodeID          = "001e06323a06";
nodeIDGrimm     = "GRIMM";

deliverablesFolder = dataFolderPre + "/deliverables/"

grimmDotMats  = dotMatsFolder +  "/reference/GRIMM" ;
mintsDotMats  = dataFolderPre +  "/dotMats/raw" ;

dtSteps = [seconds(10), seconds(30)] 

dt = dtSteps(1)
dmSteps = [minutes(5), minutes(10)]  ; 

startDate  = datetime(2019,04,28) ;
endDate    = datetime(2019,04,29);

%% main1_SaveGrimmData  
main1_SaveGrimmData

%% main2_SaveMintsData  
main2_SaveMintsData

%% main3_SyncData  
main3_SyncData
