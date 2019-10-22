
for timeIntervals = 1:length(dtSteps)

    
    %% Loading data  % Putting it over a loop 
    dt = dtSteps(timeIntervals)
    eval(strcat("load('",deliverablesFolder,"/mints_DCCD_node_3_2_data_from_",string(startDate),"_to_",string(endDate),"_in_",...
       strrep(string(dt)," ","_"),"_averaged_slices_for_Node_",nodeID,"')"));
    
    modelsFolder = modelsFolderPre +"/"+strrep(string(dt)," ","")+"/"
   mints=mintsRetimed;
    %--------------------------------------------------------------------------

    %% Take a copy of the data
    Data = mints;

    ioverwrite=1;
   
    whos

    %--------------------------------------------------------------------------
    % Training Version
    VersionSt = ['Version_RE_' datestr(today,'yyyy_mm_dd')];
    disp(VersionSt)

    % Loop over nodes
    for inode=1:length(nodeList)

        %--------------------------------------------------------------------------
        % Loop over Wanted Variables
%          for ivar=1:1
        for ivar=1:length(WantedVariables)

            Mdl_Dir=strcat(modelsFolder,nodeList{inode},"/",WantedVariables{ivar}, "/");
            Mdl_Dir_Ver=strcat(Mdl_Dir,VersionSt,"/");

            disp(Mdl_Dir_Ver)
            if ~exist(Mdl_Dir_Ver,'dir')
                mkdir(Mdl_Dir_Ver);
            end

            fn_mat=strcat(Mdl_Dir,WantedVariables{ivar},'.mat');
            fn_mat_ver=strcat(Mdl_Dir_Ver,WantedVariables{ivar},'.mat');
            fn_data=strcat(Mdl_Dir_Ver,nodeList{inode},'_Data.mat');
            
            fn_scatter=strcat(Mdl_Dir_Ver,'_scatter.png');
            fn_importance=strcat(Mdl_Dir_Ver,'_importance.png');
            fn_timeseries=strcat(Mdl_Dir_Ver,'_timeseries.png');

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

            nbins_per_column=20;
% %             n_per_bin=200;
%             n_per_bin=100;
            n_per_bin=400;
    
    %       [In_Train,Out_Train,In_Validation,Out_Validation]=representative_sample(In,Out,pvalid,nbins_per_column,n_per_bin);
           [In_Train,Out_Train,In_Validation,Out_Validation]=representativeSampleModified(In,Out,pvalid,nbins_per_column,n_per_bin);
            
%             [In_Train,Out_Train,In_Validation,Out_Validation]=representativeSampleSimple(In,Out,pvalid);

            n_Train=length(Out_Train)
            n_Validation=length(Out_Validation)

            %--------------------------------------------------------------------------        
            % See if we have already trained a model for this location & variable
            tic
            if ~exist(fn_mat_ver,'file') | ioverwrite
                %--------------------------------------------------------------------------
                % Create an optimized ensemble model called Mdl using BayesianOptimization
                % in parallel.
              
%                 Mdl = fitrensemble(In_Train,Out_Train,...
%                     'PredictorNames',Names,...
%                     'ResponseName',WantedVariables{ivar},...
%                     'OptimizeHyperparameters','all'...
%                     );
%     
    %             

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
            %strrep(Mdl.PredictorNames{isorted_imp(i)},'_',''),...
            end
            print('-dpng',fn_importance);% save to a png file            

        %--------------------------------------------------------------------------
        % Loop over Wanted Variables
        
        end

    end
    % Loop over nodes
    %--------------------------------------------------------------------------

    clear mints Data
end
% Loop over time Intevals 
%--------------------------------------------------------------------------

