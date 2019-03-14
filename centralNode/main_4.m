% clc
% clear all
% close all



%% Plotting Graphs 

load(strcat("mints_3_",strrep(string(dt)," ","_"),"_Chuncks.mat"));
% %% As Is Graphs 

%% For PM 1  

    estimator = "pm1"
    summary   = strcat("Uncalibrated Data - ",string(dt)," Average") ;
    eval(strcat("dataX = mints.",strrep(estimator,".","_"),"_grimm"));
    eval(strcat("dataY = mints.",strrep(estimator,".","_"),"_OPCN3"));
    eval(strcat("limit=max(mints.",strrep(estimator,".","_"),"_OPCN3)"));
    drawScatterPlot(dataX,dataY,limit,nodeID,estimator,summary);

    summary   = strcat("Training and Validation Data - ",string(dt)," Average") ;
    eval(strcat("dataX = trainWithPrediction.",strrep(estimator,".","_"),"_grimm"));
    eval(strcat("dataY = trainWithPrediction.",strrep(estimator,".","_"),"TrainPrediction"));
    eval(strcat("limit=max(mints.",strrep(estimator,".","_"),"_grimm)"));
    drawScatterPlot(dataX,dataY,limit,nodeID,estimator,summary);


    summary   = strcat("Testing Data - ",string(dt)," Average") ;
    eval(strcat("dataX = testWithPrediction.",strrep(estimator,".","_"),"_grimm"));
    eval(strcat("dataY = testWithPrediction.",strrep(estimator,".","_"),"TestPrediction"));
    eval(strcat("limit=max(mints.",strrep(estimator,".","_"),"_grimm)"));
    drawScatterPlot(dataX,dataY,limit,nodeID,estimator,summary);
    
eval(strcat("drawPredictorImportaince(regressionTree",strrep(strrep(estimator,".","_"),"p","P"),",20,estimator,nodeID)"))

    %% For PM 2.5  

    estimator = "pm2.5"
    summary   = strcat("Uncalibrated Data - ",string(dt)," Average") ;
    eval(strcat("dataX = mints.",strrep(estimator,".","_"),"_grimm"));
    eval(strcat("dataY = mints.",strrep(estimator,".","_"),"_OPCN3"));
    eval(strcat("limit=max(mints.",strrep(estimator,".","_"),"_OPCN3)"));
    drawScatterPlot(dataX,dataY,limit,nodeID,estimator,summary);

    summary   = strcat("Training and Validation Data - ",string(dt)," Average") ;
    eval(strcat("dataX = trainWithPrediction.",strrep(estimator,".","_"),"_grimm"));
    eval(strcat("dataY = trainWithPrediction.",strrep(estimator,".","_"),"TrainPrediction"));
    eval(strcat("limit=max(mints.",strrep(estimator,".","_"),"_grimm)"));
    drawScatterPlot(dataX,dataY,limit,nodeID,estimator,summary)


    summary   = strcat("Testing Data - ",string(dt)," Average") ;
    eval(strcat("dataX = testWithPrediction.",strrep(estimator,".","_"),"_grimm"));
    eval(strcat("dataY = testWithPrediction.",strrep(estimator,".","_"),"TestPrediction"));
    eval(strcat("limit=max(mints.",strrep(estimator,".","_"),"_grimm)"));
    drawScatterPlot(dataX,dataY,limit,nodeID,estimator,summary);
   
eval(strcat("drawPredictorImportaince(regressionTree",strrep(strrep(estimator,".","_"),"p","P"),",20,estimator,nodeID)"))
 
%% For PM 10  
    estimator = "pm10"
    summary   = strcat("Uncalibrated Data - ",string(dt)," Average") ;
    eval(strcat("dataX = mints.",strrep(estimator,".","_"),"_grimm"));
    eval(strcat("dataY = mints.",strrep(estimator,".","_"),"_OPCN3"));
    eval(strcat("limit=max(mints.",strrep(estimator,".","_"),"_OPCN3)"));
    drawScatterPlot(dataX,dataY,limit,nodeID,estimator,summary)

    summary   = strcat("Training and Validation Data - ",string(dt)," Average") ;
    eval(strcat("dataX = trainWithPrediction.",strrep(estimator,".","_"),"_grimm"));
    eval(strcat("dataY = trainWithPrediction.",strrep(estimator,".","_"),"TrainPrediction"));
     limit=50
    drawScatterPlot(dataX,dataY,limit,nodeID,estimator,summary)

    summary   = strcat("Testing Data - ",string(dt)," Average") ;
    eval(strcat("dataX = testWithPrediction.",strrep(estimator,".","_"),"_grimm"));
    eval(strcat("dataY = testWithPrediction.",strrep(estimator,".","_"),"TestPrediction"));
    eval(strcat("limit=max(mints.",strrep(estimator,".","_"),"_grimm)"));
    limit=50
    drawScatterPlot(dataX,dataY,limit,nodeID,estimator,summary);
   
    eval(strcat("drawPredictorImportaince(regressionTree",strrep(strrep(estimator,".","_"),"p","P"),",20,estimator,nodeID)"))    
    

   %% Plotting Predictor Importaince 
   eval(strcat("save mints_4_",strrep(string(dt)," ","_"),"_Chuncks"))
   

   
   
   
   