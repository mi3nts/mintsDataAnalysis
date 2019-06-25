%% Import data from text file
% Script for importing data from the following text file:
%
%    filename: /media/teamlary/Team_Lary_1/gitGubRepos/Lakitha/mintsDataAnalysis/FWNode/MINTS_001e06323a06_GPSGPGGA_2019_04_29.csv
%
% Auto-generated by MATLAB on 04-Jun-2019 17:42:27

%% Setup the Import Options
opts = delimitedTextImportOptions("NumVariables", 15);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["dateTime", "timestamp", "latitude", "latitudeDirection", "longitude", "longitudeDirection", "gpsQuality", "numberOfSatellites", "HorizontalDilution", "altitude", "altitudeUnits", "undulation", "undulationUnits", "age", "stationID"];
opts.VariableTypes = ["string", "string", "double", "string", "double", "string", "double", "double", "double", "double", "string", "double", "string", "string", "double"];
opts = setvaropts(opts, [1, 2, 4, 6, 11, 13, 14], "WhitespaceRule", "preserve");
opts = setvaropts(opts, [1, 2, 4, 6, 11, 13, 14], "EmptyFieldRule", "auto");
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
MINTS001e06323a06GPSGPGGA20190429 = readtable("/media/teamlary/Team_Lary_1/gitGubRepos/Lakitha/mintsDataAnalysis/FWNode/MINTS_001e06323a06_GPSGPGGA_2019_04_29.csv", opts);

%% Convert to output type
MINTS001e06323a06GPSGPGGA20190429 = table2cell(MINTS001e06323a06GPSGPGGA20190429);
numIdx = cellfun(@(x) ~isnan(str2double(x)), MINTS001e06323a06GPSGPGGA20190429);
MINTS001e06323a06GPSGPGGA20190429(numIdx) = cellfun(@(x) {str2double(x)}, MINTS001e06323a06GPSGPGGA20190429(numIdx));

%% Clear temporary variables
clear opts