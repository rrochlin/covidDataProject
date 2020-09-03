%so i need to assign x,y,z coordinates for every point and then i can use
%plot3(x,y,z,'o') to show the point as a circle. Also need dataHandling.m
%to be prerun and the variables to be in the workspace

% 
% x = linspace(0,100,20);
% y = linspace(0,100,20);
% % Z = linspace(0,100,20);
% 
% [X,Y] = meshgrid(x,y);

clf

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

scatter3(points(:,1),points(:,2),points(:,3),80,'Black')
hold on
axis([0 40 0 30 0 10])

% Here we will be "interprolating data. as of 8/30/2020 our first
% interpolation trial will be a random arragment of points distributed
% uniforming 2 units around each node. The amount of points shown is
% dependant entirely on that sensors reading.


highI = 0;
lowI = 1000;
for i = 1:max(size(sC))
    %skipping blank entries
    if i == 12 | i == 18
        continue
    end
    
    [temp,~] = split(sC{i}{1},'-');
    
    tempArray = strcat(temp{1},'{',num2str(str2num(temp{2})),'}');
    
    if highI < max(size(eval(tempArray)))
        highI = max(size(eval(tempArray)));
    end
    
    if lowI > max(size(eval(tempArray)))
        lowI = max(size(eval(tempArray)));
    end


end

values = {'','Black','';1,'Red','filled';2,'Green','filled';4,'Blue','filled';10,'Yellow','filled';20,'Magenta','filled';40,'Cyan','filled'};

listDyn = {};
dynCount = 0;

for i = 1:max(size(bigArray))
    
    for q = 2:7
        if table2array(bigArray(i,q)) ~= 0
            
             if dynCount > 100
                delete(listDyn{dynCount-100})
             end
             dynCount = dynCount + 1;
             
             noiseX = (randn(1,table2array(bigArray(i,q)))-.5).*5;
             noiseY = (randn(1,table2array(bigArray(i,q)))-.5).*10;
             noiseZ = (randn(1,table2array(bigArray(i,q)))-.5).*2.5;
                
             listDyn{dynCount} = scatter3(points(table2array(bigArray(i,9)),1) + noiseX,points(table2array(bigArray(i,9)),2)+ noiseY,points(table2array(bigArray(i,9)),3) + noiseZ,values{q,1},values{q,2},'filled');
                
             timeForTitle = table2array(bigArray(i,1));
             
             title(timeForTitle)
             
             pause(.0005)
             
%              F(dynCount) = getframe(figure(1));
         
         
         
        end
        
        
    end
end




            
            
            
            
            
 % scatter3(points(:,1),points(:,2),points(:,3),%size goes here try 1,'red','filled')








