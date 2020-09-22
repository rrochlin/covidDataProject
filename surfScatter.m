function [exportArray,F] = surfScatter(noiseX,noiseY,noiseZ,refresh,export,animation,bigArray,points,inputSensors)

    % Robert Rochlin 9/15/2020
    %   function to create a scatterplot animation from the ordered cell array
    %   from dataHandling().
    % 
    % reccommended default
    % surfScatter(noiseX,noiseY,noiseZ,50,0,0,bigArray,points,[2:7]);
    %
    % noiseX,noiseY, and noiseZ are created by data handling, and contain all
    % points to be plotted
    %
    % refresh adjusts how long the animation waits before removing scatters
    % from the figure
    % 
    % setting export to 1 will enable the export of the scatterpoints to an
    % array. setting animation to 1 will create F, which is a matlab animation
    % of the scatter plotting
    % 
    % bigArray and points are created by dataHandling and are passed to
    % surfScatter.
    % 
    % sensors controls which points will be plotted.
    % 2 is for dp 0.3 ---- red particles
    % 3 is for dp 0.5 ---- green particles
    % 4 is for dp 1.0 ---- blue particles
    % 5 is for dp 2.5 ---- yellow particles
    % 6 is for dp 5.0 ---- magenta particles
    % 7 is for dp 10. ---- cyan particles
    
    
    
    
    
    
    clf
    
    
    
    hold on
    
    
    
    values = {'','Black','';1,'Red','filled';2,'Green','filled';4,'Blue','filled';10,'Yellow','filled';20,'Magenta','filled';40,'Cyan','filled'};
    plotArray = gobjects(7,refresh+7);
    
    plotArray(1,1) = scatter3(NaN,NaN,NaN,'Black');
    plotArray(2,1) = scatter3(NaN,NaN,NaN,'Red','filled');
    plotArray(3,1) = scatter3(NaN,NaN,NaN,'Green','filled');
    plotArray(4,1) = scatter3(NaN,NaN,NaN,'Blue','filled');
    plotArray(5,1) = scatter3(NaN,NaN,NaN,'Yellow','filled');
    plotArray(6,1) = scatter3(NaN,NaN,NaN,'Magenta','filled');
    plotArray(7,1) = scatter3(NaN,NaN,NaN,'Cyan','filled');
    
    
    
    lgd = legend('Sensors','Dp 0.3','Dp 0.5','Dp 1.0', 'Dp 2.5', 'Dp 5', 'Dp 10');
    lgd.AutoUpdate = 'off';
    lgd.ItemHitFcn = @action1;
    
    axis([0 40 0 30 0 10])
    fig1 = scatter3(points(:,1),points(:,2),points(:,3),80,'Black');
    
    linkprop([fig1 plotArray(1,1)],'Visible');
    
    for i = 2:7
        eval(strcat("hlink",int2str(i),"  = linkprop(plotArray(",int2str(i),",:),'Visible');"))
       
        warning('off','last')
    end
    
    
    
    
    % Here we will be "interprolating data. as of 8/30/2020 our first
    % interpolation trial will be a random arragment of points distributed
    % uniforming 2 units around each node. The amount of points shown is
    % dependant entirely on that sensors reading.
    
    
    % img = imread('OR Floor Plan.jpg');
    % image([0 40],[0 30],img);
    
    test = 'x';
    xlabel(test);
    ylabel('y');
    zlabel('z');
    img = imread('OR Floor Plan.jpg');     % Load a sample image
    xImage = [0 40; 0 40];   % The x data for the image corners
    yImage = [0 0; 30 30];              % The y data for the image corners
    zImage = [.1 .1; .1 .1];   % The z data for the image corners
    surf(xImage,yImage,zImage,...    % Plot the surface
         'CData',img,...
         'FaceColor','texturemap');set(gca,'CameraPosition',[-137.4287 -128.2322   65.5930])
    
    
    
    
    
    
    sensors = inputSensors;
    
    %we always want count to be no less than 2 so the inital points are not
    %deleted
    count = 1;
    
    exportArray = [0,0,0,0];
    
    countFlag = 0;
    
    % top = max(size(bigArray));
    
    bottom = 11263;
    
    top = 13084;
    
    movieCount = 1;
    
    
    
            
    
    drawnow limitrate
    
    
    for i = bottom:top
        
    %     if mod(i,250) == 0
    % 
    %              w = waitforbuttonpress;
    % 
    %     end
        
        if table2array(bigArray(i,2)) == 0
            continue
        end
    
        
        
    
        for q = sensors
                    
            count = count +1;
    
                if countFlag == 1
                    delete(plotArray(2:7,count))
    
                end
        
    
    
    
             plotArray(q,count) = scatter3(points(table2array(bigArray(i,9)),1) + noiseX{i,q},points(table2array(bigArray(i,9)),2)+ noiseY{i,q},points(table2array(bigArray(i,9)),3) + noiseZ{i,q},values{q,1},values{q,2},'filled');
             eval(strcat("addtarget(hlink",int2str(q),",plotArray(q,count));"))
             
                      
             if count == refresh+1
                 countFlag = 1;
                 count = 1;
             end
    
    
             timeForTitle = table2array(bigArray(i,1));
    
             title(string(timeForTitle))
    
             pause(.05)
             
    
    
             if export == 1
                exportArray = [exportArray;(points(table2array(bigArray(i,9)),1) + noiseX)',(points(table2array(bigArray(i,9)),2)+ noiseY)',(points(table2array(bigArray(i,9)),3) + noiseZ)',table2array(bigArray(i,8))*ones(table2array(bigArray(i,q)),1)];
             end
    
             if animation == 1
                F(movieCount) = getframe(figure(1));
                movieCount = movieCount +1;
             end
    
             
            
            
        end
    end
    
    function action1(src,event)
    % This callback toggles the visibility of the line
    
    if strcmp(event.Peer.Visible,'on')   % If current line is visible
        event.Peer.Visible = 'off';      %   Set the visibility to 'off'
    
    else                                 % Else
        event.Peer.Visible = 'on';       %   Set the visibility to 'on'
    
    end
    
    
         % Set the title to the line name
    
                
                
                
                
                
     % scatter3(points(:,1),points(:,2),points(:,3),%size goes here try 1,'red','filled')
    
    
    
    
    
    
    
    
    