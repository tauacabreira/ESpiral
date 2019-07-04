function[lineOfProjectedAreas, projectedArea, sideLines, firstCriticalLine, lastCriticalLine] = ...
    drawing_projected_area(waypoints, numberOfWaypoints, width, height, ...
                           scanAngle, direction, sideLines, phase, stripe)
    % rotating and plotting the projected area around the waypoints
    
    projectedArea = [];
    firstCriticalLine = [];
    lastCriticalLine = [];
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
        
        % the side lines of the first/last projected area are prolonged 
        % and crossed with the verticesFromScanToFar/lowerVertices 
        % to determine the initial/final limits of each stripe
        if(stripe > 0)
            if(k == 1)
                firstCriticalLine = [projectedArea(1,4) projectedArea(2,4);
                                     projectedArea(1,3) projectedArea(2,3);
                                     projectedArea(1,2) projectedArea(2,2);
                                     projectedArea(1,1) projectedArea(2,1)];
                                
            elseif(k == numberOfWaypoints)
                lastCriticalLine = [projectedArea(1,4) projectedArea(2,4);
                                    projectedArea(1,3) projectedArea(2,3);
                                    projectedArea(1,2) projectedArea(2,2);
                                    projectedArea(1,1) projectedArea(2,1)];
            end                
        end    
        
        % the points of the side lines depend on the direction of the coverage
        if(strcmp(direction,'clockwise'))
            pointC = [projectedArea(1,2) projectedArea(2,2)];
            pointD = [projectedArea(1,1) projectedArea(2,1)];
        else
            pointC = [projectedArea(1,4) projectedArea(2,4)];
            pointD = [projectedArea(1,3) projectedArea(2,3)];
        end    
        
        % computing the side lines of the projected areas of the first and
        % last waypoints of each coverage line
        if(k == 1 || k == numberOfWaypoints)
            if(phase == 3) 
                p1 = pointC;
                p2 = pointD; 
                
            elseif(phase == 1 )
                p1 = pointC; 
                p2 = pointD; 
                
            else % PHASE 2, only the first projected area of the first stripe
                if(k == 1 && stripe == 0)
                    p1 = pointC;
                    p2 = pointD;
                end
            end
            
            % the array containing all the side lines will be used to
            % compute the intersection points between the lines
            if(~isempty(sideLines))
                index = length(sideLines(:,1)) + 1;
            else
                index = length(sideLines) + 1;
            end
            
            if(((k == 1 || k == numberOfWaypoints && phase == 3 || phase == 1) ||... 
               (k == 1 && stripe == 0)) && (exist('p1', 'var') && exist('p2', 'var')))
                sideLines(index,:)   = p1;
                sideLines(index+1,:) = p2;
            end    
        end  % if 
    end % for
end    