function[lineOfProjectedAreas, projectedArea, sideLines] = ...
    drawing_projected_area_spiral(waypoints, numberOfWaypoints, width, height, ...
                                  scanAngle, direction, sideLines, i, j, ... 
                                  lengthOfArea)
                              
    % rotating and plotting the projected area around the waypoints
    projectedArea = [];
    lineOfProjectedAreas = zeros(2,5,numberOfWaypoints);
    
    for k = 1 : numberOfWaypoints
        x1 = waypoints(1,k) - height/2;
        x2 = waypoints(1,k) + height/2;
        y1 = waypoints(2,k) - width/2;
        y2 = waypoints(2,k) + width/2;
      
        % the projected area is computed using the waypoint as a centre point
        % and adding/subtracting the height/width
        projectedArea = [x1 x2 x2 x1 x1; y1 y1 y2 y2 y1];
        
        % the projected area is rotated as the waypoints using the same angle 
        origin = repmat([waypoints(1,k) waypoints(2,k)], 5, 1)';
        [projectedArea] = rotating_object(projectedArea, origin, scanAngle);
        
        % the projected areas of a line are put into a page
        lineOfProjectedAreas(:,:,k) = projectedArea;
        
        % computing the side lines of the projected areas of the first and
        % last waypoints of each coverage line
        %if(k == 1 && (i ~= 1 || j ~= 1) || k == numberOfWaypoints && (i ~= lengthOfArea || j ~= 1))    
         if(k == 1 && (i ~= 1 || j ~= 1)  || k == numberOfWaypoints)    
         
            % the points of the side lines depend on the direction of the coverage
            if(strcmp(direction,'clockwise'))
                p1 = [projectedArea(1,2) projectedArea(2,2)];
                p2 = [projectedArea(1,1) projectedArea(2,1)];
            else
                p1 = [projectedArea(1,4) projectedArea(2,4)];
                p2 = [projectedArea(1,3) projectedArea(2,3)];
            end 
            
            % the array containing all the side lines will be used to
            % compute the intersection points between the lines
            if(~isempty(sideLines))
                index = length(sideLines(:,1)) + 1;
            else
                index = length(sideLines) + 1;
            end
            
            sideLines(index,:)   = p1;
            sideLines(index+1,:) = p2;   
            %plot(p1(1), p1(2), 'bo');
            %plot(p2(1), p2(2), 'go');
            
        end  % if 
    end % for
end    