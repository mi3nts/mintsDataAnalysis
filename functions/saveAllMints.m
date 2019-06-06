function [] = saveAllMints(dataFolder,dotMatsFolder,nodeID,sensorName)
%SAVEALLGRIM Summary of this function goes here
%   Detailed explanation goes here
    mintsDataWanted   = getMintsSensorFiles(dataFolder,nodeID,sensorName);
    mintsDataWanted(contains(string(mintsDataWanted.folder),"mints@"),:)=[];
%     mintsDataWanted
    
    string(cell2mat(mintsDataWanted.folder));
    string(cell2mat(mintsDataWanted.name));
    mintsDataFiles    = string(cell2mat(mintsDataWanted.folder)) +"/"+ string(cell2mat(mintsDataWanted.name));
    saveNamesPre      = string(cell2mat(mintsDataWanted.folder)) +"/"+ strrep(string(cell2mat(mintsDataWanted.name)),"csv","mat");
    saveNamesDotMat   = strrep(saveNamesPre , dataFolder , dotMatsFolder);



%% Create Dot Mat Files  

    for n =1 :length(mintsDataFiles)
        saveNamesDotMat(n)
        if(sensorName =="GPSGPGGA")
            mintsData =  getMintsGPSGPGGA(mintsDataFiles(n));
        elseif(sensorName =="GPSGPRMC")
            mintsData =  getMintsGPSGPRMC(mintsDataFiles(n));
        else
            mintsData =  getMintsSensorData(mintsDataFiles(n),sensorName);
        end
        
            mkdir(fileparts(saveNamesDotMat(n)));
            save(char(saveNamesDotMat(n)),'mintsData');
            clear mintsData
    
        end
    
end


