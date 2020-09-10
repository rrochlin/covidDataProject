% objective: define a meshgrid to easily populate data with sensor data
% we take the sensor data and define timeslices to be interpolated
% only keep data from columns 2 and 9. assign the first entries column 1
% and 8 values for data set

increment = 1;
endVarCount = 1;
dataCell = zeros(floor(size(bigArray,1)/48),25);
dataCell(1,24) = table2array(bigArray(1,2));

while endVarCount < size(bigArray,1)
    

    
    while table2array(bigArray(endVarCount+1,9))~=24
        endVarCount = endVarCount + 1;
        dataCell(increment,table2array(bigArray(endVarCount,9))) = table2array(bigArray(endVarCount,2));
    end
    increment = increment +1;
    endVarCount = endVarCount + 1;
    dataCell(increment,table2array(bigArray(endVarCount,9))) = table2array(bigArray(endVarCount,2));
    dataCell(increment,25) = table2array(bigArray(endVarCount,8));
end
        