clc
clear all 
close all


%% Plotting Graphs 

load('mintsDataFinal3.mat') 

Labels = "PM 2.5"

Estimators_ind = 1


%% Individual Figure for Training and Validation Data 

    % Initially draw y=t plot

     trainingDataX = trainWithPrediction.pm2_5_grimm;
     trainingDataY = trainWithPrediction.pm2_5TrainPrediction;
    
    
    figure_training_and_validation = figure('Tag','TRAINING_VALIDATION_SCATTER_PLOT',...
        'NumberTitle','off',...
        'units','pixels','OuterPosition',[0 0 900 675],...
        'Name','Training Regression',...
    'Visible','off'...
    )%,'Visible

    plot1=plot([1:30],[1:30])
    set(plot1,'DisplayName','Y = T','LineStyle',':','Color',[0 0 0]);

    hold on 

    % Fit model to data.
    % Set up fittype and options. 
    ft = fittype( 'poly1' ); 
    opts = fitoptions( 'Method', 'LinearLeastSquares' ); 
    opts.Lower = [0.6 -Inf];
    opts.Upper = [1.4 Inf];

    

     
    [fitresult, gof] = fit(...
       trainingDataX,...
       trainingDataY,...
       ft);
   
    rmsTraining    = gof.rmse
    rValueTraining = sqrt(gof.rsquare)

    % %The_Fit_Equation_Training(runs,ts)=fitresult
    % p1_Training_and_Validation_f=fitresult.p1;
    % p2_Training_and_Validation_f=fitresult.p2;

    plot2 = plot(fitresult)
    set(plot2,'DisplayName','Fit','LineWidth',2,'Color',[0 0 1]);

    
    
    
    % Create plot
plot3 = plot(...
         trainingDataX,...
         trainingDataY)
    set(plot3,'DisplayName','Data','Marker','o',...
        'LineStyle','none','Color',[0 0 0]);
    
    
    
    
    yl=strcat('Mints Node ~=',string(fitresult.p1),'*Grimm Spectrometor','+',string(fitresult.p2)," (\mug/m^{3})")
    ylabel(yl,'FontWeight','bold','FontSize',10);

    % Create xlabel
    xlabel('Grimm Spectrometor (\mug/m^{3})','FontWeight','bold','FontSize',12);

    % Create title
    Top_Title=strcat(Labels(Estimators_ind)," - Training and Validation")

    Middle_Title = strcat("Node " +string(nodeID))

    Bottom_Title= strcat("R = ",string(sqrt(gof.rsquare)),...
    ", RMSE = ",string(rmsTraining))

    title({Top_Title;Middle_Title;Bottom_Title},'FontWeight','bold');

    % Uncomment the following line to preserve the X-limits of the axes
    xlim([0 30]);
    % Uncomment the following line to preserve the Y-limits of the axes
    ylim([0 30]);
    box('on');
    axis('square');
    % Create legend
    legend1 = legend('show');
    set(legend1,'Location','northwest');


    Fig_name = strcat("pm2_5","_Node_",string(nodeID),...
        '_Training_and_Validation','.png')
    saveas(figure_training_and_validation,char(Fig_name));

    Fig_name = strcat("pm2_5","_Node_",string(nodeID),...
        '_Training_and_Validation','.fig')
    saveas(figure_training_and_validation,char(Fig_name));


