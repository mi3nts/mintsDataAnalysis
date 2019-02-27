% clc
% clear all
% close all



%% Plotting Graphs 


load('mintsDataFinal3.mat') 
% 
% %% As Is Graphs 
% 
%     estimator = "pm2.5"
%     summary   = "Uncalibrated Data" 
%     dataX = mints.pm2_5_grimm;
%     dataY = mints.pm2_5_OPCN3;
%     limit= 30;
%     drawScatterPlot(dataX,dataY,limit,nodeID,estimator, summary)
% 
%     % Initially draw y=t plot
% 
%    
%     estimator = "pm2.5"
%     summary   = "Training and Validation Data" 
%     dataX = trainWithPrediction.pm2_5_grimm;
%     dataY = trainWithPrediction.pm2_5TrainPrediction;
%     limit= 20;
%     drawScatterPlot(dataX,dataY,limit,nodeID,estimator, summary)
%     
%     
%        
%     estimator = "pm2.5"
%     summary   = "Testing Data" 
%     dataX = testWithPrediction.pm2_5_grimm;
%     dataY = testWithPrediction.pm2_5TestPrediction;
%     limit= 20;
%     drawScatterPlot(dataX,dataY,limit,nodeID,estimator, summary)
%     
    
%% Plotting Predictor Importaince 

drawPredictorImportaince(regressionTreePm2_5,15,"PM2.5",nodeID)

