
clc 
clear all
close all 

%% P1 - Specifying Parametors  

% Put all data in one time table with the following headers - dateTime, pm1
%, pm2.5 pm10 

dataFolder      = "/media/teamlary/Team_Lary_1/gitGubRepos/data/mintsData";
dotMatsFolder   = dataFolder    +  "/dotMats";
grimmDataFolder = dataFolder    +  "/Spectrometor";
grimmDotMats    = dotMatsFolder +  "/Spectrometor";
nodeID          = "001e06323a06";

dtSteps = [seconds(10), seconds(20), seconds(30), minutes(1), minutes(2) , minutes(5) , minutes(10), hours(1)]  ; 
 
startDate  = datetime(2019,02,12) ;
endDate    = datetime(2019,04,11);


% startDate  = datetime(2019,02,12) ;
% endDate    = datetime(2019,03,12);

%% Collecting Time Tables 

[palasPM,palasWeather]        =  savePalasFile('/media/teamlary/Team_Lary_1/gitGubRepos/Lakitha/mintsDataAnalysis/palasFrog/autostart_1_09900_2019-8-4.txt');

%% Conversion to dotMats  

% saveAllGrimm(dataFolder);

% saveAllPalas(dataFolder);

% saveAllMints(dataFolder,dotMatsFolder,nodeID,"OPCN3");
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"BME280");
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"LIBRAD");
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"MGS001");
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"SCD30");
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"TSL2591");
% saveAllMints(dataFolder,dotMatsFolder,nodeID,"VEML6070");


%% Concatinating dotMats  

frogPMTT         = concatDotMatsPalas(dotMatsFolder,"PALAS","PM",startDate,endDate);
frogWeatherTT    = concatDotMatsPalas(dotMatsFolder,"PALAS","Weather",startDate,endDate);

grimmTT    = table2timetable(concatDotMatsGrimm(grimmDotMats,startDate,endDate));

OPCN3TT    = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"OPCN3",startDate,endDate));
BME280TT   = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"BME280",startDate,endDate));
LIBRADTT   = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"LIBRAD",startDate,endDate));
MGS001TT   = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"MGS001",startDate,endDate));
SCD30TT    = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"SCD30",startDate,endDate));
TSL2591TT  = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"TSL2591",startDate,endDate));
VEML6070TT = table2timetable(concatDotMatsMints(dotMatsFolder,nodeID,"VEML6070",startDate,endDate));

eval(strcat("save('mints_1_1_central_node_data_from_",string(startDate),"_to_",string(endDate),"_for_Node_",nodeID,"')"));
 
%% Grimm
grimmRetime     =  retime(rmmissing(grimmTT)   ,'regular',@nanmean,'TimeStep',dtSteps(1));

%% Palas 

palasPMRetime         =  retime(rmmissing(frogPMTT)  ,'regular',@nanmean,'TimeStep',dtSteps(1));
palasWeatherRetime    =  retime(rmmissing(frogWeatherTT)  ,'regular',@nanmean,'TimeStep',dtSteps(1));
palasRetime           =  synchronize(palasPMRetime,palasWeatherRetime,'intersection');

%% Central Node 
OPCN3Retime     =  retime(rmmissing(OPCN3TT)   ,'regular',@nanmean,'TimeStep',dtSteps(1));
BME280Retime    =  retime(rmmissing(BME280TT)  ,'regular',@nanmean,'TimeStep',dtSteps(1));
LIBRADRetime    =  retime(rmmissing(LIBRADTT)  ,'regular',@nanmean,'TimeStep',dtSteps(1));
MGS001Retime    =  retime(rmmissing(MGS001TT)  ,'regular',@nanmean,'TimeStep',dtSteps(1));
SCD30Retime     =  retime(rmmissing(SCD30TT)   ,'regular',@nanmean,'TimeStep',dtSteps(1));
TSL2591Retime   =  retime(rmmissing(TSL2591TT) ,'regular',@nanmean,'TimeStep',dtSteps(1));
VEML6070Retime  =  retime(rmmissing(VEML6070TT),'regular',@nanmean,'TimeStep',dtSteps(1));

centralNodeRetime =  rmmissing(synchronize(OPCN3Retime,BME280Retime,'intersection'));
centralNodeRetime =  rmmissing(synchronize(centralNodeRetime,BME280Retime,'intersection'));
centralNodeRetime =  rmmissing(synchronize(centralNodeRetime,LIBRADRetime,'intersection'));
centralNodeRetime =  rmmissing(synchronize(centralNodeRetime,MGS001Retime,'intersection'));
centralNodeRetime =  rmmissing(synchronize(centralNodeRetime,SCD30Retime,'intersection'));
centralNodeRetime =  rmmissing(synchronize(centralNodeRetime,TSL2591Retime,'intersection'));
centralNodeRetime =  rmmissing(synchronize(centralNodeRetime,VEML6070Retime,'intersection'));


%% Corrections 

if( nodeID == "001e06323a06")
    deleteRangeBegin  =  datetime(2019,2,15,16,00,00,'timezone','utc');
    deleteRangeEnd    =  datetime(2019,2,16,2,00,00,'timezone','utc');
    centralNodeRetime(centralNodeRetime.dateTime>deleteRangeBegin&centralNodeRetime.dateTime<deleteRangeEnd,:) = []  ;
    deleteRangeEnd  =  datetime(2019,2,12,12,00,00,'timezone','utc');
    centralNodeRetime(centralNodeRetime.dateTime<deleteRangeEnd,:) = []  ;   
end

%% Originals 


mintsCentralNodeWithGrimmOriginal         = rmmissing(synchronize(grimmRetime,centralNodeRetime,'intersection'));
mintsCentralNodeWithPalasOriginal         = rmmissing(synchronize(palasRetime,centralNodeRetime,'intersection'));
mintsCentralNodeWithGrimmAndPalasOriginal = rmmissing(synchronize(mintsCentralNodeWithGrimmOriginal,palasRetime,'intersection'));


    eval(strcat("save('mints_central_node_data_from_",string(startDate),"_to_",string(endDate),"_in_",...
       strrep(string(dtSteps(1))," ","_"),"_pre_cut_for_Node_",nodeID,"',",...
       "'mintsCentralNodeWithGrimmOriginal','mintsCentralNodeWithPalasOriginal','mintsCentralNodeWithGrimmAndPalasOriginal','startDate','endDate','nodeID')"));




%% Gaining data sets for different time steps

for n=1:length(dtSteps)

    dt = dtSteps(n)

  % Time Averaging Data
    if(n==1)
        mintsCentralNodeWithGrimm         = mintsCentralNodeWithGrimmOriginal;
        mintsCentralNodeWithPalas         = mintsCentralNodeWithPalasOriginal;
        mintsCentralNodeWithGrimmAndPalas = mintsCentralNodeWithGrimmAndPalasOriginal;
    else
        mintsCentralNodeWithGrimm         = retime(mintsCentralNodeWithGrimmOriginal,'regular',@nanmean,'TimeStep',dt);
        mintsCentralNodeWithPalas         = retime(mintsCentralNodeWithPalasOriginal,'regular',@nanmean,'TimeStep',dt);
        mintsCentralNodeWithGrimmAndPalas = retime(mintsCentralNodeWithGrimmAndPalasOriginal,'regular',@nanmean,'TimeStep',dt);
    end
    
    eval(strcat("save('mints_central_node_data_from_",string(startDate),"_to_",string(endDate),"_in_",...
       strrep(string(dt)," ","_"),"_averaged_slices_for_Node_",nodeID,"',",...
       "'mintsCentralNodeWithGrimm','mintsCentralNodeWithPalas','mintsCentralNodeWithGrimmAndPalas','dt','startDate','endDate','nodeID')"));


    clear mintsCentralNodeWithGrimm mintsCentralNodeWithPalas mintsCentralNodeWithGrimmAndPalas 

end


%% Gaining data sets for different time steps


for n=1:length(dtSteps)
    maDt    = dtSteps(n)
    dt      = dtSteps(1);

    if(n==1)
        mintsCentralNodeWithGrimm         = mintsCentralNodeWithGrimmOriginal;
        mintsCentralNodeWithPalas         = mintsCentralNodeWithPalasOriginal;
        mintsCentralNodeWithGrimmAndPalas = mintsCentralNodeWithGrimmAndPalasOriginal;
    else    
        mintsCentralNodeWithGrimm         = getMovingAverage(mintsCentralNodeWithGrimmOriginal,maDt,dtSteps(1));
        mintsCentralNodeWithPalas         = getMovingAverage(mintsCentralNodeWithPalasOriginal,maDt,dtSteps(1));
        mintsCentralNodeWithGrimmAndPalas = getMovingAverage(mintsCentralNodeWithGrimmAndPalasOriginal,maDt,dtSteps(1));
    end

    eval(strcat("save('mints_central_node_data_from_",string(startDate),"_to_",string(endDate),"_in_",...
       strrep(string(maDt)," ","_"),"_moving_averages_for_Node_",nodeID,"',",...
       "'mintsCentralNodeWithGrimm','mintsCentralNodeWithPalas','mintsCentralNodeWithGrimmAndPalas','maDt','startDate','endDate','nodeID')"));

    clear mintsCentralNodeWithGrimm mintsCentralNodeWithPalas mintsCentralNodeWithGrimmAndPalas 
    
 end 





