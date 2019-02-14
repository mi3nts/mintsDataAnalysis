clc
clear all 
close all
% 


% Training and Testing a random Forest Classifier

%% Loading the Data 
load('mintsDataFinal2.mat');

%% Dividing to Training and Testing for PM1 PM2.5 and PM10 
trainingPercentage = 0.7;

[trainInd , testInd] = dividerand(height(mints),trainingPercentage,1-trainingPercentage);


[trainInputsMints,testInputsMints]   = getTrainingAndTestingTables(inputs,trainInd , testInd);

[trainPm1Mints   ,testPm1Mints]   = getTrainingAndTestingTables(pm1Mints,trainInd , testInd);

[trainPm2_5Mints ,testPm2_5Mints] = getTrainingAndTestingTables(pm2_5Mints,trainInd , testInd);

[trainPm10Mints  ,testPm10Mints]  = getTrainingAndTestingTables(pm10Mints,trainInd , testInd);

regressionTreePm1   = trainBaggedTree(trainPm1Mints,'pm1_grimm');
regressionTreePm2_5 = trainBaggedTree(trainPm2_5Mints,'pm2_5_grimm');
regressionTreePm10  = trainBaggedTree(trainPm10Mints,'pm10_grimm');
 
pm1TrainPrediction   = regressionTreePm1.predict(table2array(trainInputsMints)); 
pm2_5TrainPrediction = regressionTreePm2_5.predict(table2array(trainInputsMints));
pm10TrainPrediction  = regressionTreePm10.predict(table2array(trainInputsMints));

pm1TestPrediction   = regressionTreePm1.predict(table2array(testInputsMints)); 
pm2_5TestPrediction = regressionTreePm2_5.predict(table2array(testInputsMints));
pm10TestPrediction  = regressionTreePm10.predict(table2array(testInputsMints));


[trainMints,testMints]   = getTrainingAndTestingTables(mints,trainInd , testInd);

trainWithPrediction = addvars(trainMints,pm1TrainPrediction,pm2_5TrainPrediction,pm10TrainPrediction);
testWithPrediction  = addvars(testMints,pm1TestPrediction,pm2_5TestPrediction,pm10TestPrediction);


 save mintsDataFinal3
