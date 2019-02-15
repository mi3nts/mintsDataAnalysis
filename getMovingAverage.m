
function movingAvg = getMovingAverage(inputTable,counts)
%GETMINTSSENSORFILES Summary of this function goes here
    movingAvg = [];
    names =inputTable.Properties.VariableNames ;
    for n= 1:height(inputTable)-counts
     
        n
        slice = inputTable(n:n+counts,:);
        currentTable = varfun(@mean, slice);
        currentTable.dateTime =  (slice.dateTime(end)-slice.dateTime(1))/2 + slice.dateTime(1);
        movingAvg = [movingAvg; currentTable]; 
        
    end   
    
    movingAvg.Properties.VariableNames = names;
    
end

