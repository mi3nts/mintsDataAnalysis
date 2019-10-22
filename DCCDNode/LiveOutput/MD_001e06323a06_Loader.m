

%% Loading Model Files for 
% NODE : 001e06323a06
inode = 1

for ivar=1:length(WantedVariablesGrimm)
    Mdl_Dir=strcat(modelsFolder,nodeList{inode},"/",WantedVariablesGrimm{ivar}, "/");
    Mdl_Dir_Ver=strcat(Mdl_Dir,VersionStGrimm,"/");
    disp(Mdl_Dir_Ver);

   fn_mat_ver = strcat(Mdl_Dir_Ver,WantedVariablesGrimm{ivar},'.mat');
   load(fn_mat_ver);
   command =strcat("mints",nodeID,WantedVariablesGrimm(ivar),"= Mdl;") ;
   display(command);
   eval(command) ;              
                      
                       
 end

                      
for ivar=1:length(WantedVariablesAirMar)
    Mdl_Dir=strcat(modelsFolder,nodeList{inode},"/",WantedVariablesAirMar{ivar}, "/");
    Mdl_Dir_Ver=strcat(Mdl_Dir,VersionStAirMar,"/");
    disp(Mdl_Dir_Ver);

    fn_mat_ver = strcat(Mdl_Dir_Ver,WantedVariablesAirMar{ivar},'.mat');
    load(fn_mat_ver);
    command =strcat("mints",nodeID,WantedVariablesAirMar(ivar),"= Mdl;") ;
    display(command)
    eval(command) 

end
                       
                  