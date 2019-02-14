clc
clear all 
close all
% 


%% Training and Testing a random Forest Classifier

%% Loading the Data 
load('mintsDataFinal2.mat');

%% Dividing to Training and Testing for PM1 PM2.5 and PM10 
trainingPercentage = 0.7;

[trainInd , testInd] = dividerand(height(mints),trainingPercentage,1-trainingPercentage);


[trainInputsMints,testinputsMints]   = getTrainingAndTestingTables(inputs,trainInd , testInd);

[trainPm1Mints   ,testPm1Mints]   = getTrainingAndTestingTables(pm1Mints,trainInd , testInd);

[trainPm2_5Mints ,testPm2_5Mints] = getTrainingAndTestingTables(pm2_5Mints,trainInd , testInd);

[trainPm10Mints  ,testPm10Mints]  = getTrainingAndTestingTables(pm10Mints,trainInd , testInd);

% % %% PM 2.5 
[regressionTreePm1,impPm1] = trainBaggedTree(trainPm1Mints,'pm1_grimm');
[regressionTreePm2_5,impPm2_5] = trainBaggedTree(trainPm2_5Mints,'pm2_5_grimm');
[regressionTreePm10,impPm10] = trainBaggedTree(trainPm2_5Mints,'pm10_grimm');
 
 
 