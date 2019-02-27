
%% Doing Graphs After NN2 
% Modification of the code for Aug 8th 

% Date -  

% --- Plots for the NN Regular Data --- 

% clear all 
close all 
clc


Node_Num="6";

load('Final_Study_Mixed_Data_Node_6_2018_4_28_to_2018_5_5.mat');



Alpha_Sensor_Originals_All(:,1) = ...
        Final_Study_Mixed_Data.Alpha_Sensor_pm_1_Measered;
Alpha_Sensor_Originals_All(:,2) = ...
        Final_Study_Mixed_Data.Alpha_Sensor_pm_2_5_Measered;
Alpha_Sensor_Originals_All(:,3) = ...
        Final_Study_Mixed_Data.Alpha_Sensor_pm_10_Measered;


Spectrometor_Originals_All(:,1) = ...
        Final_Study_Mixed_Data.pm1_Spectrometor;
Spectrometor_Originals_All(:,2) = ...
        Final_Study_Mixed_Data.pm2_5_Spectrometor;
Spectrometor_Originals_All(:,3) = ...
        Final_Study_Mixed_Data.pm10_Spectrometor;
    
  
    

    
clearvars -except Spectrometor_Originals_All Alpha_Sensor_Originals_All Node_Num ;

Estimators =["PM1","PM2_5","PM10","Alveolic","Thoracic","Inhalable"];
Labels =["PM1","PM2.5","PM10","Alveolic","Thoracic","Inhalable"];    

for Estimators_ind=1:6 

clearvars -except ...
    Spectrometor_Originals_All ...
    Alpha_Sensor_Originals_All ...
    Node_Num ...
    Estimators ...
    Labels...
    Estimators_ind...
    ;
    
    
%% loading the Data 
eval(strcat("load('",...
    Estimators(Estimators_ind),...
    "_For_Node_",Node_Num,"_NN_2_Best.mat')"));

%% Here The Performance Curves for NN 2 are drawn 
figure('units','pixels','OuterPosition',[0 0 900 675])

fig = plotperform(tr_2)
fig.Visible='off';


% Create title
Top_Title=strcat(Labels(Estimators_ind)," - Error Predicting NN - Validation Performance")
Middle_Title = strcat("Node ",string(Node_Num),", RMSE for Validation = ",string(NN2_Rmse_Validation_f))

title({Top_Title;Middle_Title},'FontWeight','bold');


% ttl=strcat("Error Predicting Neural Network - Performance Curve (",Labels(Estimators_ind),") for Node ",...
%      string(Node_Num),", ","RMS Error for Validation = ",string(NN2_Rmse_Validation_f))
% title(ttl)

Fig_name = strcat(Pm,"_Node_",Node_Num,'_Performance_NN_2_Aug_10','.png')
saveas(fig,char(Fig_name));
Fig_name = strcat(Pm,"_Node_",Node_Num,'_Performance_NN_2_Aug_10','.fig')
saveas(fig,char(Fig_name));

%% Plotting Training State

figure('units','pixels','OuterPosition',[0 0 900 675])
fig=plottrainstate(tr_2) 
fig.Visible='off';

% Create title
% Create title
Top_Title=strcat(Labels(Estimators_ind)," - Error Predicting NN - Training State"," - Node ",string(Node_Num)," - RMSE for Validation = ",string(NN2_Rmse_Validation_f))


% title({char(Top_Title);char(Middle_Title);char(Bottom_Title)},'FontWeight','bold');


% st=strcat("Error Predicting Neural Network - Training State (",Labels(Estimators_ind),") for Node ",...
%      string(Node_Num))
% % title(ttl)
% SL='lkm'
[ax4,h3]=suplabel({char(Top_Title)},'t');
set(h3,'FontSize',12)


Fig_name = strcat(Pm,"_Node_",Node_Num,'_Training_State_NN2_Aug_10','.png')
saveas(fig,char(Fig_name));
Fig_name = strcat(Pm,"_Node_",Node_Num,'_Training_State_NN2_Aug_10','.fig')
saveas(fig,char(Fig_name));



%% Error Histogram 
figure('units','pixels','OuterPosition',[0 0 900 675])
fig=ploterrhist(e)
fig.Visible='off';


% Create title
Top_Title=strcat(Labels(Estimators_ind)," - Error Predicting NN - Error Histogram")
Middle_Title = strcat("Node ",string(Node_Num))

title({Top_Title;Middle_Title},'FontWeight','bold');


% ttl=strcat("Error Predicting Neural Network - Error Histogram (",Labels(Estimators_ind),") for Node ",...
%      string(Node_Num))
% title(ttl) 
Fig_name = strcat(Pm,"_Node_",Node_Num,'_Error_Histogram_NN2_Aug_10','.png')
saveas(fig,char(Fig_name));
Fig_name = strcat(Pm,"_Node_",Node_Num,'_Error_Histogram_NN2_Aug_10','.fig')
saveas(fig,char(Fig_name));


%%  After this point we need to genrate 3 graphs 
%  1) Training and Validation + Testing in Subplot 
%  2) Scatter diagram for Training and Validation with the error values 
%  3) Testing Scatter Diagram with the Error Values 
%  4) Scatter Diagram for all the data 
%  5) Time Line with the error  

%% Corrections 

NN1_with_NN2_Updated_Prediction_Training_and_Validation=...
    NN1_Prediction_Training_and_Validation +...
    NN2_Prediction_Training_and_Validation;

NN1_with_NN2_Updated_Prediction_Testing =...
    NN1_Prediction_Testing +...
    NN2_Prediction_Testing;

NN1_with_NN2_Updated_Prediction_All_New_Order = ...
    [...
    NN1_with_NN2_Updated_Prediction_Training_and_Validation;
    NN1_with_NN2_Updated_Prediction_Testing...
    ];



% Graph 1 - Subplot 

%% The Regression Pic should be 1*2 


% Create figure
figure_Subplot = figure('Tag','TRAINING_VALIDATION__TESTING_SUBPLOT',...
    'NumberTitle','off',...
    'units','pixels','OuterPosition',[0 0 900 675],...
    'Name','Neural Network Training Regression'...
   ,'Visible','off');


%% Training Plot 
% Create subplot

subplot1 = subplot(1,2,1,'Parent',figure_Subplot);
hold(subplot1,'on');


% Initially draw y=t plot
plot1=plot([1:1000],[1:1000],'Parent',subplot1)
set(plot1,'DisplayName','Y = T','LineStyle',':','Color',[0 0 0]);

%% Training and Validation Results 

% Fit model to data.
% Set up fittype and options. 
ft = fittype( 'poly1' ); 
opts = fitoptions( 'Method', 'LinearLeastSquares' ); 
opts.Lower = [0.6 -Inf];
opts.Upper = [1.4 Inf];

[fitresult, gof] = fit(...
    Spectrometor_Training_and_Validation,...
    NN1_with_NN2_Updated_Prediction_Training_and_Validation,...
    ft);
% 
%RMS_Training_and_Validation_fit_NN1_with_NN2_f = gof.rmse
RMS_Training_and_Validation_NN1_with_NN2_vs_f  = rms(...
    Spectrometor_Training_and_Validation-...
    NN1_with_NN2_Updated_Prediction_Training_and_Validation)

% R_Value_Training_and_Validation_NN1_with_NN2_f = sqrt(gof.rsquare)

% %The_Fit_Equation_Training(runs,ts)=fitresult
% p1_Training_and_Validation_f=fitresult.p1;
% p2_Training_and_Validation_f=fitresult.p2;

plot2 = plot(fitresult)
set(plot2,'DisplayName','Fit','LineWidth',2,'Color',[0 0 1]);

% Create plot
plot3 = errorbar(...
    Spectrometor_Training_and_Validation,...
    NN1_with_NN2_Updated_Prediction_Training_and_Validation,...
    NN2_Prediction_Training_and_Validation,...
   'Parent',subplot1)
set(plot3,'DisplayName','Data','Marker','o',...
    'LineStyle','none','Color',[0 0 0]);
% Create ylabel

yl=strcat('Alpha Sensor~=',string(fitresult.p1),'*Spectrometor','+',string(fitresult.p2)," (\mug/m^{3})")
ylabel(yl,'FontWeight','bold','FontSize',10);

% Create xlabel
xlabel('Grimm Spectrometor (\mug/m^{3})','FontWeight','bold','FontSize',12);

% Create title
Top_Title= strcat("Training and Validation Data Set")

Bottom_Title = strcat("R = ",string(sqrt(gof.rsquare)),...
" & RMSE = ",string(RMS_Training_and_Validation_NN1_with_NN2_vs_f));

title({Top_Title;Bottom_Title},'FontWeight','bold','FontSize',12);

% Uncomment the following line to preserve the X-limits of the axes
xlim(subplot1,[0 1000]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim(subplot1,[0 1000]);
box(subplot1,'on');
axis(subplot1,'square');
% Create legend
legend1 = legend(subplot1,'show');
set(legend1,'Location','northwest');


%% For the Testing data set 


subplot2 = subplot(1,2,2,'Parent',figure_Subplot);
hold(subplot2,'on');

% Initially draw y=t plot
plot1=plot([1:1000],[1:1000],'Parent',subplot2)
set(plot1,'DisplayName','Y = T','LineStyle',':','Color',[0 0 0]);


% Fit model to data.
% Set up fittype and options. 
ft = fittype( 'poly1' ); 
opts = fitoptions( 'Method', 'LinearLeastSquares' ); 
opts.Lower = [0.6 -Inf];
opts.Upper = [1.4 Inf];

[fitresult, gof] = fit(...
    Spectrometor_Testing,...
   NN1_with_NN2_Updated_Prediction_Testing,...
    ft);

% RMS_Testing_fit_NN1_f = gof.rmse
RMS_Testing_NN1_with_NN2_vs_f  = rms(...
    Spectrometor_Testing-...
   NN1_with_NN2_Updated_Prediction_Testing)

% R_Value_Testing_NN1_f = sqrt(gof.rsquare)

%The_Fit_Equation_Training(runs,ts)=fitresult
% p1_Testing_f=fitresult.p1;
% p2_Testing_f=fitresult.p2;

plot2 = plot(fitresult)
set(plot2,'DisplayName','Fit','LineWidth',2,'Color',[0 0 1]);

% Create plot
plot3 = errorbar(...
    Spectrometor_Testing,...
   NN1_with_NN2_Updated_Prediction_Testing,...
    NN2_Prediction_Testing,...
   'Parent',subplot2)
set(plot3,'DisplayName','Data','Marker','o',...
    'LineStyle','none','Color',[0 0 0]);
% Create ylabel

yl=strcat('Alpha Sensor~=',string(fitresult.p1),'*Spectrometor','+',string(fitresult.p2)," (\mug/m^{3})")
ylabel(yl,'FontWeight','bold','FontSize',10);

% Create xlabel
xlabel('Grimm Spectrometor (\mug/m^{3})','FontWeight','bold','FontSize',12);

% Create title
% Create title
Top_Title= strcat("Testing Data Set")

Bottom_Title = strcat("R = ",string(sqrt(gof.rsquare)),...
" & RMSE = ",string(RMS_Testing_NN1_with_NN2_vs_f));

% 
% tl= strcat("Testing Data Set for Node ",...
% string(Node_Num),...
% " (",...
% Labels(Estimators_ind),...
% "), R = ",string(sqrt(gof.rsquare)),...
% " & RMSE = ",string(RMS_Testing_NN1_vs_f))
title({Top_Title,Bottom_Title},'FontWeight','bold','FontSize',12);

% Uncomment the following line to preserve the X-limits of the axes
xlim(subplot2,[0 1000]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim(subplot2,[0 1000]);
box(subplot2,'on');
axis(subplot2,'square');
% Create legend
legend1 = legend(subplot1,'show');
set(legend1,'Location','northwest');


Top_Title    =    strcat(Labels(Estimators_ind),' Regression Analysis with the Predicted Errors');
Bottom_Title =strcat("             Node ",string(Node_Num)," (Updated)")
st = {' ';char(Top_Title);char(Bottom_Title)};
[ax4,h3]=suplabel(char(st),'t');
set(h3,'FontSize',14)


Fig_name = strcat(Pm,"_Node_",string(Node_Num),'_Subplot_with_the_Predicted_Errors(Updated)_Aug_10','.png')
saveas(figure_Subplot,char(Fig_name));

Fig_name = strcat(Pm,"_Node_",string(Node_Num),'_Subplot_with_the_Predicted_Errors(Updated)_Aug_10','.fig')
saveas(figure_Subplot,char(Fig_name));


%% Individual Figure for Training and Validation Data 

% Initially draw y=t plot

figure_training_and_validation = figure('Tag','TRAINING_VALIDATION_SCATTER_PLOI',...
    'NumberTitle','off',...
    'units','pixels','OuterPosition',[0 0 900 675],...
    'Name','Neural Network Training Regression',...
'Visible','off'...
)%,'Visible

plot1=plot([1:1000],[1:1000])
set(plot1,'DisplayName','Y = T','LineStyle',':','Color',[0 0 0]);

hold on 

% Fit model to data.
% Set up fittype and options. 
ft = fittype( 'poly1' ); 
opts = fitoptions( 'Method', 'LinearLeastSquares' ); 
opts.Lower = [0.6 -Inf];
opts.Upper = [1.4 Inf];

[fitresult, gof] = fit(...
    Spectrometor_Training_and_Validation,...
   NN1_with_NN2_Updated_Prediction_Training_and_Validation,...
    ft);

RMS_Training_and_Validation_fit_NN1_with_NN2_f = gof.rmse
RMS_Training_and_Validation_NN1_with_NN2_vs_f  = rms(...
    Spectrometor_Training_and_Validation-...
   NN1_with_NN2_Updated_Prediction_Training_and_Validation)

R_Value_Training_and_Validation_NN1_with_NN2_f = sqrt(gof.rsquare)

% %The_Fit_Equation_Training(runs,ts)=fitresult
% p1_Training_and_Validation_f=fitresult.p1;
% p2_Training_and_Validation_f=fitresult.p2;

plot2 = plot(fitresult)
set(plot2,'DisplayName','Fit','LineWidth',2,'Color',[0 0 1]);

% Create plot
plot3 = errorbar(...
    Spectrometor_Training_and_Validation,...
    NN1_with_NN2_Updated_Prediction_Training_and_Validation,...
    NN2_Prediction_Training_and_Validation)
set(plot3,'DisplayName','Data','Marker','o',...
    'LineStyle','none','Color',[0 0 0]);
% Create ylabel

yl=strcat('Alpha Sensor~=',string(fitresult.p1),'*Spectrometor','+',string(fitresult.p2)," (\mug/m^{3})")
ylabel(yl,'FontWeight','bold','FontSize',10);

% Create xlabel
xlabel('Grimm Spectrometor (\mug/m^{3})','FontWeight','bold','FontSize',12);

% Create title
Top_Title=strcat(Labels(Estimators_ind)," - Training and Validation Data with Predicted Errors  ")

Middle_Title = strcat("Node ",...
string(Node_Num)," (Updated)")

Bottom_Title= strcat("R = ",string(sqrt(gof.rsquare)),...
", RMSE = ",string(RMS_Training_and_Validation_NN1_with_NN2_vs_f))

title({Top_Title;Middle_Title;Bottom_Title},'FontWeight','bold');

% Uncomment the following line to preserve the X-limits of the axes
xlim([0 1000]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim([0 1000]);
box('on');
axis('square');
% Create legend
legend1 = legend('show');
set(legend1,'Location','northwest');


Fig_name = strcat(Pm,"_Node_",string(Node_Num),...
    '_Training_and_Validation_with_the_Predicted_Errors(Updated)_Aug_10','.png')
saveas(figure_training_and_validation,char(Fig_name));

Fig_name = strcat(Pm,"_Node_",string(Node_Num),...
    '_Training_and_Validation_with_the_Predicted_Errors(Updated)_Aug_10','.fig')
saveas(figure_training_and_validation,char(Fig_name));


%% Individual Figure for Testing Data 

% Initially draw y=t plot

figure_Testing = figure(...
    'Tag','TESTING_SCATTER_PLOI',...
    'NumberTitle','off',...
    'units','pixels','OuterPosition',[0 0 900 675],...
    'Name','Neural Network Training Regression'...
   ,'Visible','off');


plot1=plot([1:1000],[1:1000])
set(plot1,'DisplayName','Y = T','LineStyle',':','Color',[0 0 0]);

hold on 

% Fit model to data.
% Set up fittype and options. 
ft = fittype( 'poly1' ); 
opts = fitoptions( 'Method', 'LinearLeastSquares' ); 
opts.Lower = [0.6 -Inf];
opts.Upper = [1.4 Inf];

[fitresult, gof] = fit(...
    Spectrometor_Testing,...
   NN1_with_NN2_Updated_Prediction_Testing,...
    ft);

RMS_Testing_fit_NN1_f = gof.rmse
RMS_Testing_NN1_with_NN2_vs_f  = rms(...
    Spectrometor_Testing-...
   NN1_with_NN2_Updated_Prediction_Testing)

R_Value_Testing_NN1_f = sqrt(gof.rsquare)

%The_Fit_Equation_Training(runs,ts)=fitresult
p1_Testing_f=fitresult.p1;
p2_Testing_f=fitresult.p2;

plot2 = plot(fitresult)
set(plot2,'DisplayName','Fit','LineWidth',2,'Color',[0 0 1]);

% Create plot
plot3 = errorbar(...
    Spectrometor_Testing,...
    NN1_with_NN2_Updated_Prediction_Testing,...
    NN2_Prediction_Testing)

set(plot3,'DisplayName','Data','Marker','o',...
    'LineStyle','none','Color',[0 0 0]);
% Create ylabel

yl=strcat('Alpha Sensor~=',string(fitresult.p1),'*Spectrometor','+',string(fitresult.p2),' (\mug/m^{3})')
ylabel(yl,'FontWeight','bold','FontSize',10);

% Create xlabel
xlabel('Grimm Spectrometor (\mug/m^{3})','FontWeight','bold','FontSize',12);

% Create title

% Create title
Top_Title=strcat(Labels(Estimators_ind)," - Testing Data with Predicted Errors  ")

Middle_Title = strcat("Node ",...
string(Node_Num)," (Updated)")

Bottom_Title= strcat("R = ",string(sqrt(gof.rsquare)),...
", RMSE = ",string(RMS_Testing_NN1_with_NN2_vs_f))

title({Top_Title;Middle_Title;Bottom_Title},'FontWeight','bold');

% tl= strcat("Testing Data Set with the Predicted Errors for Node ",...
% string(Node_Num),...
% " (",...
% Labels(Estimators_ind),...
% "), R = ",string(sqrt(gof.rsquare)),...
% " & RMSE = ",string(RMS_Testing_NN1_vs_f)," (Updated)")

%title(tl,'FontWeight','bold','FontSize',12);

% Uncomment the following line to preserve the X-limits of the axes
xlim([0 1000]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim([0 1000]);
box('on');
axis('square');
% Create legend
legend1 = legend('show');
set(legend1,'Location','northwest');


Fig_name = strcat(Pm,"_Node_",string(Node_Num),...
    '_Testing_with_the_Predicted_Errors(Updated)_Aug_10','.png')
saveas(figure_Testing,char(Fig_name));

Fig_name = strcat(Pm,"_Node_",string(Node_Num),...
    '_Testing_with_the_Predicted_Errors(Updated)_Aug_10','.fig')
saveas(figure_Testing,char(Fig_name));


%% Individual Figure for All the Data 

% Initially draw y=t plot

figure_All_Data = figure(...
    'Tag','All_Data_SCATTER_PLOI',...
    'NumberTitle','off',...
    'units','pixels','OuterPosition',[0 0 900 675],...
    'Name','Neural Network Training Regression'...
    ,'Visible','off');


plot1=plot([1:1000],[1:1000])
set(plot1,'DisplayName','Y = T','LineStyle',':','Color',[0 0 0]);

hold on 

% Fit model to data.
% Set up fittype and options. 


%% We make a fit for all data 

ft = fittype( 'poly1' ); 
opts = fitoptions( 'Method', 'LinearLeastSquares' ); 
opts.Lower = [0.6 -Inf];
opts.Upper = [1.4 Inf];

[fitresult, gof] = fit(...
    Spectrometor_All_New_Order,...
   NN1_with_NN2_Updated_Prediction_All_New_Order,...
    ft);


%% We draw for both data sets 
% RMS_All_fit_f = gof.rmse
RMS_All_NN1_with_NN2_vs_f  = rms(...
    Spectrometor_All_New_Order-...
    NN1_with_NN2_Updated_Prediction_All_New_Order)

% R_Value_All_f = sqrt(gof.rsquare)

% p1_All_Data_f=fitresult.p1;
% p2_All_Data_f=fitresult.p2;

plot2 = plot(fitresult)
set(plot2,'DisplayName','Fit','LineWidth',2,'Color',[0 1 1]);

% Create plot
plot3 = errorbar(...
    Spectrometor_Training_and_Validation,...
    NN1_with_NN2_Updated_Prediction_Training_and_Validation,...
    NN2_Prediction_Training_and_Validation)
set(plot3,'DisplayName','Training and Validation Data','Marker','o',...
    'LineStyle','none','Color',[0 0 1]);


% Create plot
plot4 = errorbar(...
    Spectrometor_Testing,...
   NN1_with_NN2_Updated_Prediction_Testing,...
    NN2_Prediction_Testing)
set(plot4,'DisplayName','Testing Data','Marker','o',...
    'LineStyle','none','Color',[1 0 0]);
% Create ylabel

yl=strcat('Alpha Sensor~=',string(fitresult.p1),'*Spectrometor','+',string(fitresult.p2),' (\mug/m^{3})')
ylabel(yl,'FontWeight','bold','FontSize',10);

% Create xlabel
xlabel('Grimm Spectrometor (\mug/m^{3})','FontWeight','bold','FontSize',12);

% Create title
% Create title
Top_Title=strcat(Labels(Estimators_ind)," - Complete Data Set with Predicted Errors  ")

Middle_Title = strcat("Node ",...
string(Node_Num)," (Updated)")

Bottom_Title= strcat("R = ",string(sqrt(gof.rsquare)),...
", RMSE = ",string(RMS_All_NN1_with_NN2_vs_f))

title({Top_Title;Middle_Title;Bottom_Title},'FontWeight','bold');

% tl= strcat("Complete Data Set with the Predicted Errors for Node ",...
% string(Node_Num),...
% " (",...
% Labels(Estimators_ind),...
% "), R = ",string(sqrt(gof.rsquare)),...
% " & RMSE = ",string(RMS_All_NN1_with_NN2_vs_f)," (Updated)")
% 
% title(tl,'FontWeight','bold','FontSize',12);

% Uncomment the following line to preserve the X-limits of the axes
xlim([0 1000]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim([0 1000]);
box('on');
axis('square');
% Create legend
legend1 = legend('show');
set(legend1,'Location','northwest');


Fig_name = strcat(Pm,"_Node_",string(Node_Num),...
    '_Complete_Data_Set_with_the_Predicted_Errors(Updated)_Aug_10','.png')
saveas(figure_All_Data,char(Fig_name));

Fig_name = strcat(Pm,"_Node_",string(Node_Num),...
    '_Complete_Data_Set_with_the_Predicted_Errors(Updated)_Aug_10','.fig')
saveas(figure_All_Data,char(Fig_name));



%% we try to  do the timed Data plot for all the data 
figure('units','pixels','OuterPosition',[0 0 900 675],...
   'Visible','off');
ylb=strcat({"Final Prediction Derived via the Alpha Sensor (\mug/m^{3})";"&";"Grimm Spectrometor Reading (\mug/m^{3})"})

% Create title
Top_Title=strcat(Labels(Estimators_ind)," - Complete Data Set with Predicted Errors  ")
Middle_Title = strcat("Node ",...
string(Node_Num)," (Updated)")

Bottom_Title= strcat("R = ",string(sqrt(gof.rsquare)),...
", RMSE = ",string(RMS_All_NN1_with_NN2_vs_f))




% tl= strcat("Complete Data Set with Predicted Errors for Node ",...
% string(Node_Num),...
% " (",...
% Labels(Estimators_ind),...
% "), R = ",string(sqrt(gof.rsquare)),...
% " & RMSE = ",string(RMS_All_NN1_with_NN2_vs_f)," (Updated)")
% 
% 

fig =errorbar(...
    datenum(Date_Time_Training_and_Validation),...
    NN1_with_NN2_Updated_Prediction_Training_and_Validation,...
    NN2_Prediction_Training_and_Validation,'b.')

xlabel('Time (Date Number)')
ylabel(ylb)
title({Top_Title;Middle_Title;Bottom_Title},'FontWeight','bold');
hold on 

errorbar(...
    datenum(Date_Time_Testing),...
    NN1_with_NN2_Updated_Prediction_Testing,...
    NN2_Prediction_Testing...
    ,'r.')


plot(...
    datenum(Date_Time_All_New_Order),...
    Spectrometor_All_New_Order,...
    'ko')

legend('Training and Valiation (Alpha)','Testing (Alpha)','True Values (Grimm)')


Fig_name = strcat(...
    Pm,...
    "_Node_",...
    string(Node_Num),...
    '_Alpha_Sensor_Values_with_the_Predicted_Errors(Updated)_Aug_10','.fig')
saveas(fig,char(Fig_name));


Fig_name = strcat(...
    Pm,...
    "_Node_",...
    string(Node_Num),...
    '_Alpha_Sensor_Values_with_the_Predicted_Errors(Updated)_Aug_10','.png')
saveas(fig,char(Fig_name));

%%  Making the Quantile Quantile Plot




ft = fittype( 'poly1' ); 
opts = fitoptions( 'Method', 'LinearLeastSquares' ); 
opts.Lower = [0.6 -Inf];
opts.Upper = [1.4 Inf];

[fitresult, gof] = fit(...
    Spectrometor_All_New_Order,...
   NN1_with_NN2_Updated_Prediction_All_New_Order,...
    ft);



QQPlot= figure('units','pixels','OuterPosition',[0 0 900 675],...
   'Visible','off');
fig=qqplot( Spectrometor_All_New_Order,...
    NN1_with_NN2_Updated_Prediction_All_New_Order)
xlabel('Spectrometor (\mug/m^{3})')
ylabel('Alpha Sensor (\mug/m^{3})')

% Create title
% Create title
% Create title
Top_Title= strcat("  ",Labels(Estimators_ind)," - QQ Plot");
Middle_Title = strcat("Node ",...
string(Node_Num)," (Updated)");
Bottom_Title=strcat("Complete Data Set(between 0th and 5th Quantile)");





title({Top_Title;Middle_Title;Bottom_Title},'FontWeight','bold');

% tl= strcat("QQ Plot - Complete Data Set with the Predicted Errors for Node ",...
% string(Node_Num),...
% " (",...
% Labels(Estimators_ind),...
% "), R = ",string(sqrt(gof.rsquare)),...
% " & RMSE = ",string(RMS_All_NN1_with_NN2_vs_f)," (Updated)")
% 
% title(tl,'FontWeight','bold','FontSize',12);
% title(tl)

% find the 0, 25, 50, 75, 100 percentiles
cp=[0 25 50 75 100];
p=prctile(Spectrometor_All_New_Order,cp);
p1=prctile( NN1_with_NN2_Updated_Prediction_All_New_Order,cp);

hold on
scatter(p,p1,'dr','filled')
for i=1:length(p)
   text(...
       p(i),.2+p1(i),...
       num2str(cp(i)),...
       'Color','red',...
       'FontSize',10,...
       'HorizontalAlignment','center'...
       )
end
% Uncomment the following line to preserve the X-limits of the axes
axis([0 (max(Spectrometor_All_New_Order)-2) 0 (max(Spectrometor_All_New_Order)+2)])
% Uncomment the following line to preserve the Y-limits of the axes

box on;
axis square;

Figure_Name=strcat(Pm,"_Node_",Node_Num,'_QQ_Plot_Regular_Data(Updated)_Aug_10','.fig');
savefig(QQPlot,char(Figure_Name));
Figure_Name=strcat(Pm,"_Node_",Node_Num,'_QQ_Plot_Regular_Data(Updated)_Aug_10','.png');
saveas(QQPlot,char(Figure_Name));



close all 

%%  Making the 2nd Quantile Quantile Plot

ft = fittype( 'poly1' ); 
opts = fitoptions( 'Method', 'LinearLeastSquares' ); 
opts.Lower = [0.6 -Inf];
opts.Upper = [1.4 Inf];

[fitresult, gof] = fit(...
    Spectrometor_All_New_Order,...
   NN1_with_NN2_Updated_Prediction_All_New_Order,...
    ft);


QQPlot= figure('units','pixels','OuterPosition',[0 0 900 675],...
   'Visible','off');
fig=qqplot( Spectrometor_All_New_Order,...
    NN1_with_NN2_Updated_Prediction_All_New_Order)
xlabel('Spectrometor (\mug/m^{3})')
ylabel('Alpha Sensor (\mug/m^{3})')

% Create title
% Create title
Top_Title= strcat(Labels(Estimators_ind)," - QQ Plot");
Middle_Title = strcat("Node ",...
string(Node_Num)," (Updated)");
Bottom_Title=strcat("Complete Data Set(between 1st and 3rd Quantile)");

title({Top_Title;Middle_Title;Bottom_Title},'FontWeight','bold');



% tl= strcat("QQ Plot - Complete Data Set with the Predicted Errors for Node ",...
% string(Node_Num),...
% " (",...
% Labels(Estimators_ind),...
% "), R = ",string(sqrt(gof.rsquare)),...
% " & RMSE = ",string(RMS_All_NN1_with_NN2_vs_f)," (Updated)")
% 
% title(tl,'FontWeight','bold','FontSize',12);
% title(tl)

% find the 0, 25, 50, 75, 100 percentiles
cp=[0 25 50 75 100];
p=prctile(Spectrometor_All_New_Order,cp);
p1=prctile( NN1_with_NN2_Updated_Prediction_All_New_Order,cp);

hold on
scatter(p,p1,'dr','filled')
for i=2:length(p)-1
   text(...
       p(i),.2+p1(i),...
       num2str(cp(i)),...
       'Color','red',...
       'FontSize',10,...
       'HorizontalAlignment','center'...
       )
end
% Uncomment the following line to preserve the X-limits of the axes
axis([(quantile(Spectrometor_All_New_Order,.25)) (quantile(Spectrometor_All_New_Order,.75)) (quantile(Spectrometor_All_New_Order,.24)) (quantile(Spectrometor_All_New_Order,.76))])
% Uncomment the following line to preserve the Y-limits of the axes
box on;
axis square;

Figure_Name=strcat(Pm,"_Node_",Node_Num,'_QQ_Plot_btwn_2nd_and_3rd_Quantile_Data(Updated)_Aug_10','.fig');
savefig(QQPlot,char(Figure_Name));
Figure_Name=strcat(Pm,"_Node_",Node_Num,'_QQ_Plot_btwn_2nd_and_3rd_Quantile_Data(Updated)_Aug_10','.png');
saveas(QQPlot,char(Figure_Name));




close all 




%% Uncallibrated Scatter Plot 
%% Individual Figure for All the Data Uncalibrated  
if (Estimators_ind<=3)
% Initially draw y=t plot

figure_All_Data = figure(...
    'Tag','All_Data_SCATTER_PLOT_Uncalibrated',...
    'NumberTitle','off',...
    'units','pixels','OuterPosition',[0 0 900 675],...
    'Name','Uncalibrated Data'...
    ,'Visible','off');


plot1=plot([1:1000],[1:1000])
set(plot1,'DisplayName','Y = T','LineStyle',':','Color',[0 0 0]);

hold on 

% Fit model to data.
% Set up fittype and options. 


% We make a fit for all data

ft = fittype( 'poly1' ); 
opts = fitoptions( 'Method', 'LinearLeastSquares' ); 
opts.Lower = [0.6 -Inf];
opts.Upper = [1.4 Inf];

[fitresult, gof] = fit(...
    Spectrometor_Originals_All(:,Estimators_ind),...
    Alpha_Sensor_Originals_All(:,Estimators_ind),...
    ft);


% We draw for both data sets 
% RMS_All_fit_f = gof.rmse
RMS_All_Uncalibrated_vs_f  = rms(...
        Spectrometor_Originals_All(:,Estimators_ind) - ...
    Alpha_Sensor_Originals_All(:,Estimators_ind)...
    )

% R_Value_All_f = sqrt(gof.rsquare)

% p1_All_Data_f=fitresult.p1;
% p2_All_Data_f=fitresult.p2;

plot2 = plot(fitresult)
set(plot2,'DisplayName','Fit','LineWidth',2,'Color',[0 1 1]);

%Create plot
plot3 = plot(...
        Spectrometor_Originals_All(:,Estimators_ind), ...
        Alpha_Sensor_Originals_All(:,Estimators_ind));
    
set(plot3,'DisplayName','Uncalibrated Data','Marker','o',...
    'LineStyle','none','Color',[0 0 1]);


% % Create plot
% plot4 = errorbar(...
%     Spectrometor_Testing,...
%    NN1_with_NN2_Updated_Prediction_Testing,...
%     NN2_Prediction_Testing)
% set(plot4,'DisplayName','Testing Data','Marker','o',...
%     'LineStyle','none','Color',[1 0 0]);
% % Create ylabel

yl=strcat('Alpha Sensor~=',string(fitresult.p1),'*Spectrometor','+',string(fitresult.p2)," (\mug/m^{3})")
ylabel(yl,'FontWeight','bold','FontSize',10);

% Create xlabel
xlabel('Grimm Spectrometor (\mug/m^{3})','FontWeight','bold','FontSize',12);

% Create title
Top_Title=strcat(Labels(Estimators_ind)," - Uncalibrated Data")

Middle_Title = strcat("Node ",string(Node_Num))

Bottom_Title= strcat("R = ",string(sqrt(gof.rsquare)),...
", RMSE = ",string(RMS_All_Uncalibrated_vs_f))

title({Top_Title;Middle_Title;Bottom_Title},'FontWeight','bold');


% tl= strcat("Complete Data Set for Uncalibrated Data ",...
% string(Node_Num),...
% " (",...
% Labels(Estimators_ind),...
% "), R = ",string(sqrt(gof.rsquare)),...
% " & RMSE = ",string(RMS_All_vs_f))

% title(tl,'FontWeight','bold','FontSize',12);

% Uncomment the following line to preserve the X-limits of the axes
xlim([0 1000]);
% Uncomment the following line to preserve the Y-limits of the axes
ylim([0 1000]);
box('on');
axis('square');
% Create legend
legend1 = legend('show');
set(legend1,'Location','northwest');


Fig_name = strcat(Pm,"_Node_",string(Node_Num),...
    '_Complete_Data_Set_with_Uncalibrated_Data_Aug_10','.png')
saveas(figure_All_Data,char(Fig_name));

Fig_name = strcat(Pm,"_Node_",string(Node_Num),...
    '_Complete_Data_Set_with_Uncalibrated_Data_Aug_10','.fig')
saveas(figure_All_Data,char(Fig_name));
end
end

% 
