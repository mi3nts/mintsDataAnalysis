clc
clear all
close all



%% Plotting Graphs 


load('mintsDataFinal3.mat') 

%% As Is Graphs 

    estimator = "pm2.5"
    summary   = "Uncalibrated Data" 
    dataX = mints.pm2_5_grimm;
    dataY = mints.pm2_5_OPCN3;
    limit= 30;
    drawScatterPlot(dataX,dataY,limit,nodeID,estimator, summary)

    % Initially draw y=t plot

   
    estimator = "pm2.5"
    summary   = "Training and Validation Data" 
    dataX = trainWithPrediction.pm2_5_grimm;
    dataY = trainWithPrediction.pm2_5TrainPrediction;
    limit= 20;
    drawScatterPlot(dataX,dataY,limit,nodeID,estimator, summary)
    
    
       
    estimator = "pm2.5"
    summary   = "Testing Data" 
    dataX = testWithPrediction.pm2_5_grimm;
    dataY = testWithPrediction.pm2_5TestPrediction;
    limit= 20;
    drawScatterPlot(dataX,dataY,limit,nodeID,estimator, summary)
    
    
%% Plotting Predictor Importaince 

drawPredictorImportaince(regressionTreePm2_5,15,"PM2.5",nodeID)

% imp = 100*(regressionTreePm2_5.predictorImportance/sum(regressionTreePm2_5.predictorImportance));
% limit = 20
% [sortedImp,isortedImp] = sort(imp,'descend');
% barh(imp(isortedImp));hold on ; grid on ;
% set(gca,'ydir','reverse');
% xlabel('Estimates');ylabel('Predictors');
% title('Predictor Importaince Estimates')
% ylim([.5 (limit+.5)]);
% yticks([1:1:limit])
% sortedPredictorLabels= regressionTreePm2_5.PredictorNames(isortedImp);
% 
% 
% for n = 1:limit
%     
%     
%     text(...
%         imp(isortedImp(n))+ 0.05,n,...
%         strrep(sortedPredictorLabels(n),"_"," ")...
%         )  
%     
% end 
% 
% 
% 
% 
%     
% %      limit = 60
% %     
% %     figure_training_and_validation = figure('Tag','TRAINING_VALIDATION_SCATTER_PLOT',...
% %         'NumberTitle','off',...
% %         'units','pixels','OuterPosition',[0 0 900 675],...
% %         'Name','Training Regression',...
% %     'Visible','off'...
% %     )%,'Visible
% % 
% %     plot1=plot([1: limit],[1: limit])
% %     set(plot1,'DisplayName','Y = T','LineStyle',':','Color',[0 0 0]);
% % 
% %     hold on 
% % 
% %     % Fit model to data.
% %     % Set up fittype and options. 
% %     ft = fittype( 'poly1' ); 
% %     opts = fitoptions( 'Method', 'LinearLeastSquares' ); 
% %     opts.Lower = [0.6 -Inf];
% %     opts.Upper = [1.4 Inf];
% % 
% %     
% % 
% %      
% %     [fitresult, gof] = fit(...
% %        trainingDataX,...
% %        trainingDataY,...
% %        ft);
% %    
% %     rmsTraining    = gof.rmse
% %     rValueTraining = gof.rsquare
% % 
% %     % %The_Fit_Equation_Training(runs,ts)=fitresult
% %     % p1_Training_and_Validation_f=fitresult.p1;
% %     % p2_Training_and_Validation_f=fitresult.p2;
% % 
% %     plot2 = plot(fitresult)
% %     set(plot2,'DisplayName','Fit','LineWidth',2,'Color',[0 0 1]);
% % 
% %     
% %     
% %     
% %     % Create plot
% % plot3 = plot(...
% %          trainingDataX,...
% %          trainingDataY)
% %     set(plot3,'DisplayName','Data','Marker','o',...
% %         'LineStyle','none','Color',[0 0 0]);
% %     
% %     
% %     
% %     
% %     yl=strcat('Mints Node ~=',string(fitresult.p1),'*Grimm Spectrometor','+',string(fitresult.p2)," (\mug/m^{3})")
% %     ylabel(yl,'FontWeight','bold','FontSize',10);
% % 
% %     % Create xlabel
% %     xlabel('Grimm Spectrometor (\mug/m^{3})','FontWeight','bold','FontSize',12);
% % 
% %     % Create title
% %     Top_Title=strcat(Labels(Estimators_ind)," - Training and Validation")
% % 
% %     Middle_Title = strcat("Node " +string(nodeID))
% % 
% %     Bottom_Title= strcat("R^2 = ",string(sqrt(gof.rsquare)),...
% %     ", RMSE = ",string(rmsTraining))
% % 
% %     title({Top_Title;Middle_Title;Bottom_Title},'FontWeight','bold');
% % 
% %     % Uncomment the following line to preserve the X-limits of the axes
% %     xlim([0  limit]);
% %     % Uncomment the following line to preserve the Y-limits of the axes
% %     ylim([0  limit]);
% %     box('on');
% %     axis('square');
% %     % Create legend
% %     legend1 = legend('show');
% %     set(legend1,'Location','northwest');
% % 
% % 
% %     Fig_name = strcat("pm2_5","_Node_",string(nodeID),...
% %         '_Training_and_Validation','.png')
% %     saveas(figure_training_and_validation,char(Fig_name));
% % 
% %     Fig_name = strcat("pm2_5","_Node_",string(nodeID),...
% %         '_Training_and_Validation','.fig')
% %     saveas(figure_training_and_validation,char(Fig_name));
% % 
% % 
