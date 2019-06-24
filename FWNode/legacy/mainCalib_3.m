clc
clear all 
close all 

%% Specifying Parametors  

% Put all data in one time table with the following headers - dateTime, pm1
%, pm2.5 pm10 

dataFolder           = "/media/teamlary/Team_Lary_1/gitGubRepos/data/mintsData";
rawDataFolder        = dataFolder + "/raw"
dotMatsFolder        = dataFolder    +  "/dotMats";
rawDotMatsFolder     = dataFolder    +  "/rawDotMats";

versionID = "Version_RE_2019_05_05";

nodeID             = "001e06323a06";

dtSteps = [seconds(10), seconds(20), seconds(30), minutes(1), minutes(2) , minutes(5) , minutes(10), hours(1)]  ; 
dt = seconds(60)


startDate  = datetime(2019,02,12) ;
endDate    = datetime(2019,05,05);

%% Loading Data 
eval(strcat("load('",dataFolder,"/",nodeID,"/mints_FW_node_Calib_2_1_data_from_",string(startDate),"_to_",string(endDate),"_in_",...
       strrep(string(dt)," ","_"),"_averaged_slices_for_Node_",nodeID,"')"))

 
   
 %% Loading Models
 
 
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



Data  = mints; 
predictionMints = mints(:,1);


%% Loading Models 
for n=1:length(WantedVariables)

    target= WantedVariables{n};
    eval(strcat("load('",dotMatsFolder,"/",nodeID,"/",...
        target,"/",versionID,"/",...
        target,".mat')"))

    
   %--------------------------------------------------------------------------
   disp('set up the machine learning inputs and outputs')
   Names=RegressionVariables;
   
   command=strcat('In=['); 
   for iname=1:length(RegressionVariables)
       command=strcat(command,'Data.',RegressionVariables{iname}," ");
   end
   command=strcat(command,'];whos In Out');
   
   disp(command);
   eval(command);

   eval(strcat("predictionMints.",strrep(target,"_grimm","_Predicted")," =   predict(Mdl,In);"));
   
   clear Mdl In
   
end

predictionMints.valid_OPCN3 = [];
  

eval(strcat("save('",dataFolder,"/",nodeID,"/mints_FW_node_Calib_3_1_data_from_",string(startDate),"_to_",string(endDate),"_in_",...
       strrep(string(dt)," ","_"),"_averaged_slices_for_Node_",nodeID,"',",...
       "'predictionMints','dt','startDate','endDate','nodeID')"))

   
   
   
   % string(endDate),"_in_",...
%        strrep(string(dt)," ","_"),"_averaged_slices_for_Node_",nodeID,"')"))











