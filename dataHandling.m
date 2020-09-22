function [bigArray,B,Br,points,sC,noiseX,noiseY,noiseZ] = dataHandling(xvar,yvar,zvar)

    % [bigArray,B,Br,points,sC,noiseX,noiseY,noiseZ] = dataHandling(2,2,1);
    % 
    % 
    % Robert Rochlin 9/15/2020
    % Function to import sensor data for use with other visualiton methods.
    % currently methods are specific to the data set given to me in August, and
    % several changes will need to be made to work on general data
    % 
    % for a general array we would want to have the arguments to this function
    % be lists containing strings of the file names for sensors, and the
    % postional information for the sensors.
    % 
    % xvar, yvar, and zvar control the data spread for the surf function.
    
    
    
    numBArrays = 19;
    numBrArray = 11;
    
    B = cell(numBArrays,1);
    
    Br=cell(numBrArray,1);
    
    refColumnID = 0;
    
    % here we are reading in the data stored in the B files, we have exceptions
    % to handle the odd named files as MATLAB wants specific names for the
    % files. The files only contain the column i think we need for the
    % visualization we're going to do, and also have an added sensor id and
    % int timestamp column
    
    for i=1:numBArrays
        
        if i == 16
            T=readtable(strcat('B-',int2str(i),'(High Baseline).txt'));
            B{i} = T(:,[2,7:12]);
            B{i}(:,8) = array2table(datenum(table2array(B{i}(:,1),'HH:MM:SS')));
            refColumnID = refColumnID +1;
            try
                B{i}(:,9) = array2table(ones(max(size(B{i})),1)*refColumnID);
            catch
            end
          
            continue
        end
        try
            T=readtable(strcat('B-0',int2str(i),'.txt'));
            B{i} = T(:,[2,7:12]);
            B{i}(:,8) = array2table(datenum(table2array(B{i}(:,1),'HH:MM:SS')));
        catch
        end
        
        try
            T=readtable(strcat('B-',int2str(i),'.txt'));
            B{i} = T(:,[2,7:12]);
            B{i}(:,8) = array2table(datenum(table2array(B{i}(:,1),'HH:MM:SS')));
        catch
        end
        
        if i ~= 2 && i~= 5 && i~=9 && i ~= 11
            refColumnID = refColumnID +1;
            try
            B{i}(:,9) = array2table(ones(max(size(B{i})),1)*refColumnID);
            catch
            end
        end
        warning('off','last')
        
    end
    
    
    
    for i=1:numBrArray
        if i == 5
            T=readtable(strcat('Br-0',int2str(i),'(No Time Stamp).txt'));
            Br{i} = T(:,[2,7:12]);
            Br{i}(:,8) = array2table(datenum(table2array(Br{i}(:,1),'HH:MM:SS')));
            refColumnID = refColumnID +1;
            try
                Br{i}(:,9) = array2table(ones(max(size(Br{i})),1)*refColumnID);
            catch
            end
            
            continue
        end
        try
            T=readtable(strcat('Br-0',int2str(i),'.txt'));
            Br{i} = T(:,[2,7:12]);
            Br{i}(:,8) = array2table(datenum(table2array(Br{i}(:,1),'HH:MM:SS')));
          
            
        catch
        end
        
        try
            T=readtable(strcat('Br-',int2str(i),'.txt'));
            Br{i} = T(:,[2,7:12]);
            Br{i}(:,8) = array2table(datenum(table2array(Br{i}(:,1),'HH:MM:SS')));
        catch
            
        end
        if i ~= 3 && i~= 4
            refColumnID = refColumnID +1;
            try
                Br{i}(:,9) = array2table(ones(max(size(Br{i})),1)*refColumnID);
            catch
            end
        end
        warning('off','last')
    end
    
    
    
    numArrays = 24;
    sC = cell(24,1);
    
    %format is {'sensor name' ; [x and y coordinates] ; 'z orientation'}
    
    %here we are plotting all sensor locations in rectalinear coordinates from
    %the top lefthand corner of the room, given that sensor B-10 is the closest
    %sensor to (0,0) and B-08 would be the furthest sensor away from the x-axis
    %and closest to y-axis
    
        sC{1}  = {'B-01';  [25,25.5];'B'};
        sC{2}  = {'B-03';  [25,19];'B'};
        sC{3}  = {'B-04';  [25,13.5];'B'};
        sC{4}  = {'B-06';  [15,17];'B'};
        sC{5}  = {'B-07';  [17,11];'B'};
        sC{6}  = {'B-08';  [7.5,25.5];'B'};
        sC{7}  = {'B-10';  [6.75,10];'B'};
        sC{8}  = {'B-12';  [12.5,26]; 'M'};     %halfway between b-08 and b-05 on the middle layer
        sC{9}  = {'B-13';  [17.5,20];'M'};
        sC{10} = {'B-14';  [30,22.5];'T'};
        sC{11} = {'B-15';  [17,23];'M'};
    %     sC{12} = {'B-16';  };                   %don't use bad data
        sC{13} = {'B-17';  [21,22.5];'T'};
        sC{14} = {'B-18';  [30,17];'T'};
        sC{15} = {'B-19';  [17.5,20];'M'};
        sC{16} = {'Br-01'; [25,25.5];'T'};
        sC{17} = {'Br-02'; [25,19];'T'};
    %     sC{18} = {'Br-05'; } ;                  %Do not use this data, no timestamp
        sC{19} = {'Br-06'; [25,13.5];'T'};
        sC{20} = {'Br-07'; [17,26];'T'};
        sC{21} = {'Br-08'; [15,17];'T'};
        sC{22} = {'Br-09'; [17,11];'T'};
        sC{23} = {'Br-10'; [7.5,25.5];'T'};
        sC{24} = {'Br-11'; [7,18];'T'};
        
        
        %gets rid of the pesking last 7 rows in Br{11} that are a different
        %timestamp
        
        
        %appending all the sensors into one array
        
    for i = 1:numArrays
        if i == 12|i==18
                continue
        end
    
            [temp,~] = split(sC{i}{1},'-');
            tempArray = strcat(temp{1},'{',num2str(str2num(temp{2})),'}');
        if i == 1
            bigArray = eval(tempArray);
            continue
        end
        
        try
            bigArray = [bigArray;eval(tempArray)];
        catch
        end
        
            
        
    end
    
    
    
    
        %sorting the array
        
       bigArray = sortrows(bigArray,8);
       
       
       
       
     %creating the sensor location data for plotting  
    points = zeros(numArrays,3);
    
    for i = 1:numArrays
        try
            points(i,1:2) = sC{i}{2};
            switch sC{i}{3}
                case 'B'
                    points(i,3) = 1;
                    
                case 'M'
                    points(i,3) = 3;
                    
                case 'T'
                    points(i,3) = 5;
            end
        catch
        end
        
        
        
    end
    
    h = waitbar(0,'Please wait...');
    for i = 1:max(size(bigArray))
        waitbar(i/max(size(bigArray)),h,'Processing Data')
        if table2array(bigArray(i,2)) == 0
            continue
        end
        for q = 2:7
             if q ~= 7
                 
                  
                noiseX{i,q} = (randn(1,table2array(bigArray(i,q))-table2array(bigArray(i,q+1)))-.5).*xvar;
                noiseY{i,q} = (randn(1,table2array(bigArray(i,q))-table2array(bigArray(i,q+1)))-.5).*yvar;
                noiseZ{i,q} = (randn(1,table2array(bigArray(i,q))-table2array(bigArray(i,q+1)))-.5).*zvar;
             else
    
                 noiseX{i,q} = (randn(1,table2array(bigArray(i,q)))-.5).*xvar;
                 noiseY{i,q} = (randn(1,table2array(bigArray(i,q)))-.5).*yvar;
                 noiseZ{i,q} = (randn(1,table2array(bigArray(i,q)))-.5).*zvar;
             end
        end
    end
    
    waitbar(1,h,'Finishing');
    pause(1)
    
    close(h)
        
        
        
        
        