
clc
close all
clearvars -except startDate endDate nodeID dtSteps


% Training and Testing a random Forest Classifier

%% Loading the Data 

for n = 1: length(dtSteps)

    for m=1:2
  
       dt = dtSteps(n)
       
         if(m==1)
            load(strcat("mints_2_1_from_",string(startDate),"_to_",string(endDate),"_in_",strrep(string(dt)," ","_"),"_Chuncks_Node_",nodeID))
         end 
         
         if(m==2)
            load(strcat("mints_2_2_from_",string(startDate),"_to_",string(endDate),"_in_",strrep(string(dt)," ","_"),"_Moving_Average_Node_",nodeID))
         end 
        
        dt = dtSteps(n)
        
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
       
        if(m==1)
            eval(strcat("save mints_3_1_from_",string(startDate),"_to_",string(endDate),"_in_",strrep(string(dt)," ","_"),"_Chuncks_Node_",nodeID))
        end
        
        if(m==2)
           eval(strcat("save mints_3_2_from_",string(startDate),"_to_",string(endDate),"_in_",strrep(string(dt)," ","_"),"_Moving_Average_Node_",nodeID))
        end 
    
        clc
        clearvars -except startDate endDate nodeID dtSteps n m
    end
    
end 

