%so i need to assign x,y,z coordinates for every point and then i can use
%plot3(x,y,z,'o') to show the point as a circle. Also need dataHandling.m
%to be prerun and the variables to be in the workspace


clf


scatter3(points(:,1),points(:,2),points(:,3),80,'Black')
hold on
axis([0 40 0 30 0 10])

% Here we will be "interprolating data. as of 8/30/2020 our first
% interpolation trial will be a random arragment of points distributed
% uniforming 2 units around each node. The amount of points shown is
% dependant entirely on that sensors reading.



values = {'','Black','';1,'Red','filled';2,'Green','filled';4,'Blue','filled';10,'Yellow','filled';20,'Magenta','filled';40,'Cyan','filled'};

listDyn = {};
dynCount = 0;
exportArray = [0,0,0,0];
speeditup = 0;
tolerance = 50;
zerocounter = 0;


for i = 1:max(size(bigArray))
    
    for q = 2:7
        
%         i know its ugly, but it works

        if table2array(bigArray(i,q)) == 0
            speeditup = speeditup +1;
            if speeditup > 3
                continue
            end
        end   
        
        if table2array(bigArray(i,q)) ~= 0
            speeditup = 0;
        end
            
             if dynCount > tolerance
                delete(listDyn{dynCount-tolerance})
             end
             dynCount = dynCount + 1;

             noiseX = (randn(1,table2array(bigArray(i,q)))-.5).*5;
             noiseY = (randn(1,table2array(bigArray(i,q)))-.5).*5;
             noiseZ = (randn(1,table2array(bigArray(i,q)))-.5).*2.5;

             listDyn{dynCount} = scatter3(points(table2array(bigArray(i,9)),1) + noiseX,points(table2array(bigArray(i,9)),2)+ noiseY,points(table2array(bigArray(i,9)),3) + noiseZ,values{q,1},values{q,2},'filled');

    %              exportArray = [exportArray;(points(table2array(bigArray(i,9)),1) + noiseX)',(points(table2array(bigArray(i,9)),2)+ noiseY)',(points(table2array(bigArray(i,9)),3) + noiseZ)',table2array(bigArray(i,8))*ones(table2array(bigArray(i,q)),1)];

             timeForTitle = table2array(bigArray(i,1));

             title(timeForTitle)

             pause(.0005)

%              F(dynCount) = getframe(figure(1));

         
         
%         end
        
        
    end
end




            
            
            
            
            
 % scatter3(points(:,1),points(:,2),points(:,3),%size goes here try 1,'red','filled')








