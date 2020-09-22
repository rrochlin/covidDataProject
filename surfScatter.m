function [exportArray,F] = surfScatter(noiseX,noiseY,noiseZ,comp,animation,points,tSArray,first,last)

    % Robert Rochlin 9/15/2020
    %   function to create a scatterplot animation from the ordered cell array
    %   from dataHandling().
    % 
    % reccommended default
    % surfScatter(X,Y,Z,0.2,0,points,tSArray,'first','last');
    %
    % X,Y, and Z are created by data handling, and contain all
    % points to be plotted
    % 
    % comp is the input for the pause function. The better your computers cpu
    % and ram the lower you can set this. Usually i would recommend going for
    % .1-.5 seconds, if you're on a really good computer you can try for
    % .01-.05, it just speeds the animation up. the drawback are that if you're
    % going too fast for your pc you will be unable to use the
    % scaling/rotation/visibility toggles
    % 
    % setting export to 1 will enable the export of the scatterpoints to an
    % array. setting animation to 1 will create F, which is a matlab animation
    % of the scatter plotting
    % 
    % bigArray and points are created by dataHandling and are passed to
    % surfScatter.
    % 
    % tSArray is a timestamp array ordered with the noise arrays that keeps
    % track of slice timestamps
    % 
    % first/last are the beginning and end of the plotting window you want.
    % enter 'first' for the beginning and 'last' for the end. for specific
    % times enter the time in 'HH:MM:SS' format for 24 hr clock
    % 
    
    
    clf
    hold on
    
    % here i am defining a cell array to hold the plotting information for
    % scatter3
    values = {'','Black','';1,'Red','filled';2,'Green','filled';4,'Blue','filled';10,'Yellow','filled';20,'Magenta','filled';40,'Cyan','filled'};
    
    % controls the amount of artifact data displayed by plotting
    refresh = 8;
    
    % preallocating the graphics array for plotting
    plotArray = gobjects(7,refresh+2);
    
    % plotting null points to link visibility with real points, and also for
    % the legend
    plotArray(1,1) = scatter3(NaN,NaN,NaN,'Black');
    plotArray(2,1) = scatter3(NaN,NaN,NaN,'Red','filled');
    plotArray(3,1) = scatter3(NaN,NaN,NaN,'Green','filled');
    plotArray(4,1) = scatter3(NaN,NaN,NaN,'Blue','filled');
    plotArray(5,1) = scatter3(NaN,NaN,NaN,'Yellow','filled');
    plotArray(6,1) = scatter3(NaN,NaN,NaN,'Magenta','filled');
    plotArray(7,1) = scatter3(NaN,NaN,NaN,'Cyan','filled');
    
    
    % createing/labelling legend
    lgd = legend('Sensors','Dp 0.3','Dp 0.5','Dp 1.0', 'Dp 2.5', 'Dp 5', 'Dp 10');
    lgd.AutoUpdate = 'off';
    % enabling callback function for interactive legend
    lgd.ItemHitFcn = @action1;
    
    % axis sized according to picture given
    axis([0 32.5 0 30 0 8])
    
    % plotting the sensor nodes
    fig1 = scatter3(points(:,1),points(:,2),points(:,3),80,'Black');
    
    % linking sensor nodes to null black plot for toggling visibility.
    linkprop([fig1 plotArray(1,1)],'Visible');
    warning('off','last')
    
    % creating link objects for binding visible property for the new scatters
    % made to the legend
    for i = 2:7
        eval(strcat("hlink",int2str(i),"  = linkprop(plotArray(",int2str(i),",:),'Visible');"))
        warning('off','last')
    end
    
    
    % labelling axis and plotting the OR floor plan image, and setting camera
    % position to what i think is a good view
    xlabel('x');
    ylabel('y');
    zlabel('z');
    img = imread('OR Floor Plan OG.jpg');     % Load a sample image
    img = flip(img,3);
    xImage = [0 32.5; 0 32.5];   % The x data for the image corners
    yImage = [-1 -1; 30 30];              % The y data for the image corners
    zImage = [.1 .1; .1 .1];   % The z data for the image corners
    surf(xImage,yImage,zImage,...    % Plot the surface
         'CData',img,...
         'FaceColor','texturemap');set(gca,'CameraPosition',[-137.4287 -128.2322   65.5930])
    
    
    
    
    % taking in the sensors argument for sensors  to be plotted
    
    sensors = 2:7;
    
    %we always want count to be no less than 2 so the inital points are not
    %deleted
    % counter variable for help with managing the graphics
    count = 1;
    
    
    % flag to tell program to begin deleting old graphics
    countFlag = 0;
    
    % here bottom and top control the plotting range, they are essentially
    % index elements for the bigArray
    
    
    % bottom = 11263;
    % 
    % top = 13084;
    if string(first) == 'first'
        top = 1;
    else
        for i =1:size(tSArray,2)
            if tSArray(i) > datenum(first)
                top = i;
                break
            end
        end
    end
    
    if string(last) == 'last'
        bottom = size(tSArray,2);
    else
        for i =size(tSArray,2):-1:1
            if tSArray(i) < datenum(last)
                bottom = i;
                break
            end
        end
    end
    
    % var for the animation feature
    movieCount = 1;
    
    
    
            
    % this will reduce the updates given to the figure, letting it run faster
    % and also helping us use the rotate and legend toggles
    drawnow limitrate
    
    % array will loop throught the given data range
    for i = top:bottom
        title(datestr(tSArray(i),13))
        
    % %     quick and dirty way to give auto pauses   
    %     if mod(i,250) == 0
    % 
    %              w = waitforbuttonpress;
    % 
    %     end
    
    
    
    %   in this method we are not plotting any zero entries.    
        if isempty(noiseX{i,2})
            continue
        end
    
        
        
    %   q controls which particles we are concerned with plotting, default is
    %   2:7
        for q = sensors
                    
            count = count +1;
    
                if countFlag == 1
                    delete(plotArray(2:7,count))
                    warning('off','last')
    
                end
        
    
    
    %   plots are saved to plotArray so they can be deleted in the correct
    %   order
             plotArray(q,count) = scatter3(noiseX{i,q},noiseY{i,q},noiseZ{i,q},values{q,1},values{q,2},'filled');
             eval(strcat("addtarget(hlink",int2str(q),",plotArray(q,count));"))
             
                      
             if count == refresh+1
                 countFlag = 1;
                 count = 1;
             end
    
    
             
    
             pause(comp)
             
    
             if animation == 1
                F(movieCount) = getframe(figure(1));
                movieCount = movieCount +1;
             end
    
             
            
            
        end
    end
    
    % callback function for visibility on legend feature, lifted from mathworks
    % blog post by Jiro Doke
    
    function action1(src,event)
    % This callback toggles the visibility of the line
    
    if strcmp(event.Peer.Visible,'on')   % If current line is visible
        event.Peer.Visible = 'off';      %   Set the visibility to 'off'
    
    else                                 % Else
        event.Peer.Visible = 'on';       %   Set the visibility to 'on'
    
    end
    
    
    
    
    
    
    
    
    
    
    