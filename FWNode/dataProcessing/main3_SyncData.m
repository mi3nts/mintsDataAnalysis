close all 
clearvars -except dataFolderPre dataFolder nodeIDGrimm dataFolderGrimm mintsDotMats nodeID deliverablesFolder dtSteps dt dmSteps startDate endDate grimmDotMats mintsDotMats

%% Syncing GRIMM Data With Mints Data


%% Loading Grimm Data 
% nodeIDGRIMM          = "GRIMM";
eval(strcat("load('",deliverablesFolder,"/mints_node_1_2_data_from_",string(startDate),"_to_",string(endDate),"_in_",...
        strrep(string(dt)," ","_"),"_averaged_slices_for_Node_",nodeIDGrimm,"')"))

%% Loading Node Data 

eval(strcat("load('",deliverablesFolder,"/mints_node_2_2_data_from_",string(startDate),"_to_",string(endDate),"_in_",...
        strrep(string(dt)," ","_"),"_averaged_slices_for_Node_",nodeID,"')"))
    
%% Syncronizing Data  

mintsAll =  rmmissing(synchronize(mints,mintsGrimm,'intersection'));
    
fileNameIn  = strcat("mints_FW_3_1_from_",string(startDate),"_to_",string(endDate),"_in_",strrep(string(dt)," ","_"),"_Slices_Node_",nodeID)
saveAllData(deliverablesFolder,fileNameIn)

%% 

eval(strcat("save('",deliverablesFolder,"/mints_node_3_2_data_from_",string(startDate),"_to_",string(endDate),"_in_",...
       strrep(string(dt)," ","_"),"_averaged_slices_for_Node_",nodeID,"',",...
       "'mints','dt','startDate','endDate','nodeID')"))


for n=2:length(dtSteps)
    tic
        dt = dtSteps(n)

        %% Time Averaging Data
        mints     =  retime(rmmissing(mintsAll)   ,'regular',@nanmean,'TimeStep',dt);
        eval(strcat("save('",deliverablesFolder,"/mints_node_3_2_data_from_",string(startDate),"_to_",string(endDate),"_in_",...
        strrep(string(dt)," ","_"),"_averaged_slices_for_Node_",nodeID,"',",...
        "'mints','dt','startDate','endDate','nodeID')"))

        clear mints
    toc
    
end
