
clc
clear all
close all 

%% Defining Parametors 

dataFolder      = "/media/teamlary/Team_Lary_1/gitGubRepos/data/mintsData";
dotMatsFolder   = dataFolder    +  "/dotMats";
grimmDataFolder = dataFolder    +  "/Spectrometor";
grimmDotMats    = dotMatsFolder +  "/Spectrometor";
nodeID          = "001e06323a06";
version         = "Version_RE_2019_05_05"
nodeFolder  =  strcat(dataFolder,"/dotMats/");

startDate  = datetime(2019,02,12) ;
endDate    = datetime(2019,04,29);

dt = seconds(60);



%% Loading data 


eval(strcat("load('",dataFolder,"/",nodeID,"/mints_FW_node_1_2_data_from_",string(startDate),"_to_",string(endDate),"_in_",...
       strrep(string(dt)," ","_"),"_averaged_slices_for_Node_",nodeID,"')"))


ioverwrite=1;

%--------------------------------------------------------------------------
nodeList={...
    nodeID ...
    };

WantedVariables={...
    'pm10_grimm',...
    'pm2_5_grimm',...
    'pm1_grimm',...
    'inhalable_grimm',...
    'thoracic_grimm',...
    'alveolic_grimm'...
    };

WantedVariablesNames={...
    'PM_{10}',...
    'PM_{2.5}',...
    'PM_{1}',...
    'Inhalable',...
    'Thoracic',...
    'Alveolic'...
    };


AllVariables={...
    'valid_OPCN3',...
    'binCount0_OPCN3',...
    'binCount1_OPCN3',...
    'binCount2_OPCN3',...
    'binCount3_OPCN3',...
    'binCount4_OPCN3',...
    'binCount5_OPCN3',...
    'binCount6_OPCN3',...
    'binCount7_OPCN3',...
    'binCount8_OPCN3',...
    'binCount9_OPCN3',...
    'binCount10_OPCN3',...
    'binCount11_OPCN3',...
    'binCount12_OPCN3',...
    'binCount13_OPCN3',...
    'binCount14_OPCN3',...
    'binCount15_OPCN3',...
    'binCount16_OPCN3',...
    'binCount17_OPCN3',...
    'binCount18_OPCN3',...
    'binCount19_OPCN3',...
    'binCount20_OPCN3',...
    'binCount21_OPCN3',...
    'binCount22_OPCN3',...
    'binCount23_OPCN3',...
    'bin1TimeToCross_OPCN3',...
    'bin3TimeToCross_OPCN3',...
    'bin5TimeToCross_OPCN3',...
    'bin7TimeToCross_OPCN3',...
    'samplingPeriod_OPCN3',...
    'sampleFlowRate_OPCN3',...
    'temperature_OPCN3',...
    'humidity_OPCN3',...
    'pm1_OPCN3',...
    'pm2_5_OPCN3',...
    'pm10_OPCN3',...
    'rejectCountGlitch_OPCN3',...
    'rejectCountLongTOF_OPCN3',...
    'rejectCountRatio_OPCN3',...
    'rejectCountOutOfRange_OPCN3',...
    'fanRevCount_OPCN3',...
    'laserStatus_OPCN3',...
    'checkSum_OPCN3',...
    'temperature_BME280',...
    'pressure_BME280',...
    'humidity_BME280',...
    'alititude_BME280',...
    'countPerMinute_LIBRAD',...
    'radiationValue_LIBRAD',...
    'timeSpent_LIBRAD',...
    'LIBRADCount_LIBRAD',...
    'nh3_MGS001',...
    'co_MGS001',...
    'no2_MGS001',...
    'c3h8_MGS001',...
    'c4h10_MGS001',...
    'ch4_MGS001',...
    'h2_MGS001',...
    'c2h5oh_MGS001',...
    'c02_SCD30',...
    'temperature_SCD30',...
    'humidity_SCD30',...
    'luminosity_TSL2591',...
    'ir_TSL2591',...
    'full_TSL2591',...
    'visible_TSL2591',...
    'lux_TSL2591',...
    'UVLightLevel_VEML6070',...
    };

RegressionVariables={...
    'valid_OPCN3',...
    'binCount0_OPCN3',...
    'binCount1_OPCN3',...
    'binCount2_OPCN3',...
    'binCount3_OPCN3',...
    'binCount4_OPCN3',...
    'binCount5_OPCN3',...
    'binCount6_OPCN3',...
    'binCount7_OPCN3',...
    'binCount8_OPCN3',...
    'binCount9_OPCN3',...
    'binCount10_OPCN3',...
    'binCount11_OPCN3',...
    'binCount12_OPCN3',...
    'binCount13_OPCN3',...
    'binCount14_OPCN3',...
    'binCount15_OPCN3',...
    'binCount16_OPCN3',...
    'binCount17_OPCN3',...
    'binCount18_OPCN3',...
    'binCount19_OPCN3',...
    'binCount20_OPCN3',...
    'binCount21_OPCN3',...
    'binCount22_OPCN3',...
    'binCount23_OPCN3',...
    'temperature_OPCN3',...
    'humidity_OPCN3',...
    'pm1_OPCN3',...
    'pm2_5_OPCN3',...
    'pm10_OPCN3',...
    'temperature_BME280',...
    'pressure_BME280',...
    'humidity_BME280',...
    'altitude_BME280',...
    'nh3_MGS001',...
    'co_MGS001',...
    'no2_MGS001',...
    'c3h8_MGS001',...
    'c4h10_MGS001',...
    'ch4_MGS001',...
    'h2_MGS001',...
    'c2h5oh_MGS001',...
    'c02_SCD30',...
    'temperature_SCD30',...
    'humidity_SCD30',...
    'luminosity_TSL2591',...
    'ir_TSL2591',...
    'full_TSL2591',...
    'visible_TSL2591',...
    'lux_TSL2591',...
    'UVLightLevel_VEML6070',...
    };


RegressionVariablesLabels={...
    'Valid',...
    'Bin 0',...
    'Bin 1',...
    'Bin 2',...
    'Bin 3',...
    'Bin 4',...
    'Bin 5',...
    'Bin 6',...
    'Bin 7',...
    'Bin 8',...
    'Bin 9',...
    'Bin 10',...
    'Bin 11',...
    'Bin 12',...
    'Bin 13',...
    'Bin 14',...
    'Bin 15',...
    'Bin 16',...
    'Bin 17',...
    'Bin 18',...
    'Bin 19',...
    'Bin 20',...
    'Bin 21',...
    'Bin 22',...
    'Bin 23',...
    'Temperature OPC',...
    'Humidity  OPC',...
    'PM_1',...
    'PM_{2.5}',...
    'PM_{10}',...
    'Temperature BME280',...
    'Pressure BME280',...
    'Humidity BME280',...
    'Altitude BME280',...
    'NH_3',...
    'CO',...
    'NO_2',...
    'C_3H_8',...
    'C_4H_10',...
    'CH_4',...
    'H_2',...
    'C_2H_5OH',...
    'CO_2 SCD30',...
    'Temperature SCD30',...
    'Humidity SCD30',...
    'Luminosity TSL2591',...
    'IR TSL2591',...
    'Full TSL2591',...
    'Visible TSL2591',...
    'Lux TSL2591',...
    'UV Light Level VEML6070',...
    };


%--------------------------------------------------------------------------
% Calibration Base Directory
CalibrationBaseDir = '/Volumes/Disk/MINTS/CalibrationAir/';
CalibrationBaseDir = './';
CalibrationBaseDir = nodeFolder;
%--------------------------------------------------------------------------
% % Load the data
% fn='../centralNode/mints_central_node_data_from_12-Feb-2019_to_11-Apr-2019_in_30_sec_moving_averages_for_Node_001e06323a06.mat';
% load(fn);

%--------------------------------------------------------------------------
% Take a copy of the data
Data = mints;

whos

%--------------------------------------------------------------------------
% Training Version
VersionSt=['Version_RE_' datestr(today,'yyyy_mm_dd')];
disp(VersionSt)


% Loop over nodes
for inode=1:length(nodeList)

    %--------------------------------------------------------------------------
    % Loop over Wanted Variables
%      for ivar=1:1
    for ivar=1:length(WantedVariables)

        Mdl_Dir=strcat(CalibrationBaseDir,nodeList{inode},"/",WantedVariables{ivar}, "/");
        Mdl_Dir_Ver=strcat(Mdl_Dir,VersionSt,"/");
        disp(Mdl_Dir_Ver)
        if ~exist(Mdl_Dir_Ver,'dir')
            mkdir(Mdl_Dir_Ver);
        end

        fn_mat=strcat(Mdl_Dir,WantedVariables{ivar},'.mat');
        fn_mat_ver=strcat(Mdl_Dir_Ver,WantedVariables{ivar},'.mat');
        fn_data=strcat(Mdl_Dir,nodeList{inode},'_Data.mat');
        fn_scatter=strcat(CalibrationBaseDir,nodeList{inode},'/',WantedVariables{ivar},'/',nodeList{inode},'_scatter.png');
        fn_importance=strcat(CalibrationBaseDir,nodeList{inode},'/',WantedVariables{ivar},'/',nodeList{inode},'_importance.png');
        fn_timeseries=strcat(CalibrationBaseDir,nodeList{inode},'/',WantedVariables{ivar},'/',nodeList{inode},'_timeseries.png');

        %--------------------------------------------------------------------------
        disp('set up the machine learning inputs and outputs')
        Names=RegressionVariables;
        command=strcat('Out=Data.',WantedVariables{ivar},';In=[');
        for iname=1:length(RegressionVariables)
            command=strcat(command,'Data.',RegressionVariables{iname}," ");
        end        
        command=strcat(command,'];whos In Out');
        disp(command);
        eval(command);

        %--------------------------------------------------------------------------
        % Make a random representative sample of the data
        pvalid=50/100;
        nbins_per_column=20;
        n_per_bin=200;
        n_per_bin=100;
        n_per_bin=400;
        [In_Train,Out_Train,In_Validation,Out_Validation]=representative_sample(In,Out,pvalid,nbins_per_column,n_per_bin);
        n_Train=length(Out_Train);
        n_Validation=length(Out_Validation);
        
        %--------------------------------------------------------------------------        
        % See if we have already trained a model for this location & variable
        tic
        if ~exist(fn_mat_ver,'file') | ioverwrite
            %--------------------------------------------------------------------------
            % Create an optimized ensemble model called Mdl using BayesianOptimization
            % in parallel.
            noptimizations=30;
            Mdl = fitrensemble(In_Train,Out_Train,...
                'PredictorNames',Names,...
                'ResponseName',WantedVariables{ivar},...
                'OptimizeHyperparameters','all',...
                'HyperparameterOptimizationOptions',...
                    struct(...
                    'AcquisitionFunctionName','expected-improvement-plus',...
                    'MaxObjectiveEvaluations',noptimizations,...
                    'UseParallel',true ...
                    )...
                );

            %--------------------------------------------------------------------------
            % Create a compact version of the Mdl then save it
            whos Mdl
            Mdl=compact(Mdl);
            whos Mdl

            command=strcat("save ",fn_mat,' Mdl RegressionVariables RegressionVariablesLabels');
            disp(command);
            eval(command);
            
            command=strcat("save ",fn_mat_ver,' Mdl RegressionVariables RegressionVariablesLabels');
            disp(command);
            eval(command);
            
            command=strcat("save ",fn_data,' In_Train Out_Train In_Validation Out_Validation In Out');
            disp(command);
            eval(command);
            
        else
            disp(strcat("Loading: ",fn_mat))
            load(fn_mat)
        end
        toc

        %--------------------------------------------------------------------------
        % Use the trained model, Mdl
        Out_estimate=predict(Mdl,In);
        Out_Train_estimate=predict(Mdl,In_Train);
        Out_Validation_estimate=predict(Mdl,In_Validation);

        %--------------------------------------------------------------------------
        % calculate the mean square error (MSE) of the test and training points
        mse_Train=sum((Out_Train_estimate-Out_Train).^2)/length(Out_Train)
        mse_Validation=sum((Out_Validation_estimate-Out_Validation).^2)/length(Out_Validation)

        %--------------------------------------------------------------------------
        % calculate the correlation coefficients for the training and test data 
        % sets with the associated linear fits hint: check out the function corrcoef
        R_Train = corrcoef(Out_Train_estimate,Out_Train);
        r_Train=R_Train(1,2);
        R_Validation = corrcoef(Out_Validation_estimate,Out_Validation);
        r_Validation=R_Validation(1,2);  
        
        %--------------------------------------------------------------------------
        % Estimate the predictor importance
        imp=predictorImportance(Mdl)
        [sorted_imp,isorted_imp] = sort(imp,'descend');    

        %--------------------------------------------------------------------------
        figure
        plot(Out,Out,'-b','LineWidth',2)
        hold on
        scatter(Out_Train,Out_Train_estimate,50,'og','filled')
        scatter(Out_Validation,Out_Validation_estimate,15,'+r')
        xl=xlim;
        xlim([0 xl(2)])
        ylim([0 xl(2)])
        grid on
        hold off
        xlabel(['True ' WantedVariablesNames{ivar}]);ylabel(['Estimated ' WantedVariablesNames{ivar}]);title([WantedVariablesNames{ivar}])
        legend(...
            '1:1',...
            strcat('Training (# ',separatethousands(n_Train,',',0),', R=',num2str(r_Train,3), ')'),...
            strcat('Validation (# ',separatethousands(n_Validation,',',0),', R=',num2str(r_Validation,3),')'),...
            'Location','northwest' ...
            )
        set(gca,'FontSize',16); set(gca,'TickDir','out'); set(gca,'LineWidth',2);
        print('-dpng',fn_scatter);% save to a png file

        %--------------------------------------------------------------------------
        % Draw a horizontal bar chart showing the variables in descending order of
        % importance. Variable names are held in Mdl.PredictorNames
        n_top_bars=15;
        figure;barh(imp(isorted_imp(1:n_top_bars)));hold on;grid on;
        if length(isorted_imp)>=5
            barh(imp(isorted_imp(1:5)),'y');
        else
            barh(imp(isorted_imp),'y');
        end
        if length(isorted_imp)>=3
            barh(imp(isorted_imp(1:3)),'r');
        else
            barh(imp(isorted_imp(1:n_top_bars)),'r');
        end
        title([WantedVariablesNames{ivar} ' Predictor Importance Estimates']);
        xlabel('Estimated Importance');ylabel('Predictors');
        set(gca,'FontSize',16); set(gca,'TickDir','out'); set(gca,'LineWidth',2);
        ax = gca;ax.YDir='reverse';ax.XScale = 'log';
        xl=xlim;
        xlim([xl(1) xl(2)*2.75]);
        ylim([.25 n_top_bars+.75])

        % label the bars
        for i=1:n_top_bars
            text(...
                1.05*imp(isorted_imp(i)),i,...
                strrep(RegressionVariablesLabels{isorted_imp(i)},'_',''),...
                'FontSize',12 ...
            )
%                strrep(Mdl.PredictorNames{isorted_imp(i)},'_',''),...
        end
        print('-dpng',fn_importance);% save to a png file
                

    %--------------------------------------------------------------------------
    % Loop over Wanted Variables
    end
    
end
% Loop over nodes
%--------------------------------------------------------------------------
