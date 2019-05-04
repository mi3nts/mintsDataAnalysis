clc
close all
clearvars -except startDate endDate nodeID dtSteps



%% Plotting Graphs 


%% Gaining the time Step 

estimators = ["pm1", "pm2.5", "pm10"]


% 
% for interval= 1: length(dtSteps)
for interval= 2:length(dtSteps)
    
  
       for moving =1:2

        for predictor = 1:length(estimators)     
            dt =  dtSteps(interval)  
            if(moving==1)
                 load(strcat("mints_3_1_from_",string(startDate),"_to_",string(endDate),"_in_",strrep(string(dt)," ","_"),"_Chuncks_Node_",nodeID))
            end

            if(moving==2)
                 load(strcat("mints_3_2_from_",string(startDate),"_to_",string(endDate),"_in_",strrep(string(dt)," ","_"),"_Moving_Average_Node_",nodeID))
            end 
            dt =  dtSteps(interval)  
            
            %% For PM   

                estimator =estimators(predictor)
                movinsStatus = [" Average"," Moving Average"]

                summary   = strcat("Uncalibrated Data - ",string(dt),movinsStatus(moving)) ;
                eval(strcat("dataX = mints.",strrep(estimator,".","_"),"_grimm;"));
                eval(strcat("dataY = mints.",strrep(estimator,".","_"),"_OPCN3;"));
                eval(strcat("limit=max(mints.",strrep(estimator,".","_"),"_OPCN3);"));
                drawScatterPlot(dataX,dataY,limit,nodeID,estimator,summary);

                summary   = strcat("Training and Validation Data - ",string(dt),movinsStatus(moving)) ;
                eval(strcat("dataX = trainWithPrediction.",strrep(estimator,".","_"),"_grimm;"));
                eval(strcat("dataY = trainWithPrediction.",strrep(estimator,".","_"),"TrainPrediction;"));
                eval(strcat("limit=max(mints.",strrep(estimator,".","_"),"_grimm);"));
                drawScatterPlot(dataX,dataY,limit,nodeID,estimator,summary);


                summary   = strcat("Testing Data - ",string(dt),movinsStatus(moving)) ;
                eval(strcat("dataX = testWithPrediction.",strrep(estimator,".","_"),"_grimm;"));
                eval(strcat("dataY = testWithPrediction.",strrep(estimator,".","_"),"TestPrediction;"));
                eval(strcat("limit=max(mints.",strrep(estimator,".","_"),"_grimm);"));
                drawScatterPlot(dataX,dataY,limit,nodeID,estimator,summary);
% 
%                 eval(strcat("drawPredictorImportaince(regressionTree",strrep(strrep(estimator,".","_"),"p","P"),",20,estimator,nodeID)"));

%                 %% For PM 2.5  
% 
%                 estimator = "pm2.5"
%                 summary   = strcat("Uncalibrated Data - ",string(dt)," Average") ;
%                 eval(strcat("dataX = mints.",strrep(estimator,".","_"),"_grimm"));
%                 eval(strcat("dataY = mints.",strrep(estimator,".","_"),"_OPCN3"));
%                 eval(strcat("limit=max(mints.",strrep(estimator,".","_"),"_OPCN3)"));
%                 drawScatterPlot(dataX,dataY,limit,nodeID,estimator,summary);
% 
%                 summary   = strcat("Training and Validation Data - ",string(dt)," Average") ;
%                 eval(strcat("dataX = trainWithPrediction.",strrep(estimator,".","_"),"_grimm"));
%                 eval(strcat("dataY = trainWithPrediction.",strrep(estimator,".","_"),"TrainPrediction"));
%                 eval(strcat("limit=max(mints.",strrep(estimator,".","_"),"_grimm)"));
%                 drawScatterPlot(dataX,dataY,limit,nodeID,estimator,summary)
% 
% 
%                 summary   = strcat("Testing Data - ",string(dt)," Average") ;
%                 eval(strcat("dataX = testWithPrediction.",strrep(estimator,".","_"),"_grimm"));
%                 eval(strcat("dataY = testWithPrediction.",strrep(estimator,".","_"),"TestPrediction"));
%                 eval(strcat("limit=max(mints.",strrep(estimator,".","_"),"_grimm)"));
%                 drawScatterPlot(dataX,dataY,limit,nodeID,estimator,summary);
% 
%                 eval(strcat("drawPredictorImportaince(regressionTree",strrep(strrep(estimator,".","_"),"p","P"),",20,estimator,nodeID)"))
% 
%                 %% For PM 10  
%                 estimator = "pm10"
%                 summary   = strcat("Uncalibrated Data - ",string(dt)," Average") ;
%                 eval(strcat("dataX = mints.",strrep(estimator,".","_"),"_grimm"));
%                 eval(strcat("dataY = mints.",strrep(estimator,".","_"),"_OPCN3"));
%                 eval(strcat("limit=max(mints.",strrep(estimator,".","_"),"_OPCN3)"));
%                 drawScatterPlot(dataX,dataY,limit,nodeID,estimator,summary)
% 
%                 summary   = strcat("Training and Validation Data - ",string(dt)," Average") ;
%                 eval(strcat("dataX = trainWithPrediction.",strrep(estimator,".","_"),"_grimm"));
%                 eval(strcat("dataY = trainWithPrediction.",strrep(estimator,".","_"),"TrainPrediction"));
%                 limit=50
%                 drawScatterPlot(dataX,dataY,limit,nodeID,estimator,summary)
% 
%                 summary   = strcat("Testing Data - ",string(dt)," Average") ;
%                 eval(strcat("dataX = testWithPrediction.",strrep(estimator,".","_"),"_grimm"));
%                 eval(strcat("dataY = testWithPrediction.",strrep(estimator,".","_"),"TestPrediction"));
%                 eval(strcat("limit=max(mints.",strrep(estimator,".","_"),"_grimm)"));
%                 limit=50
%                 drawScatterPlot(dataX,dataY,limit,nodeID,estimator,summary);
%                 eval(strcat("drawPredictorImportaince(regressionTree",strrep(strrep(estimator,".","_"),"p","P"),",20,estimator,nodeID)"))    


                %% Plotting Predictor Importaince 
% 
%                 eval(strcat("save mints_4_",strrep(string(dt)," ","_"),"_Chuncks"))

        end
    end
end   
   
   