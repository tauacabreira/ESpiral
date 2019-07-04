function[fullListOfWaypoints, waypointsInfo] = ...
    spiral(area, lengthOfArea, width, height, ovx, ovy)

    fullListOfWaypoints = []; 
    waypointsInfo = [];
    
    % calculating the centroid of the polygon 
    [~, cx, cy] = polycenter(area(:,1),area(:,2),1);
    centroid = [cx cy];
    plot(cx, cy, 'om');

    % computing the distance from the centroid to the first edge of the area
    [distance] = computing_distance(centroid, area);   
   
    % computing the number of rings and the overlapping rate
    [numberOfRings, ovx] = computing_rings(distance, width, ovx);

    % starting vertex (the first point of the area)
    vertexStart = area(1,:);
    plot(vertexStart(1), vertexStart(2), 'xg');

    % defining the coverage direction
    direction = 'counterclockwise';
    oppositeDirection = 'clockwise';
    counter = 1;
    
    % ==== SPIRAL ==== % 
    for j = 1 : numberOfRings
        sideLines = [];
        i = 1;
        while i < length(area)
            % calculating the distance of the edge that is being covered and 
            % the scan angle - the turn angle is used to compute the distance
            % of the first line of the first ring, which is longer
            [distanceEdge, scanAngle] = ...
                calculating_distance_and_angles_spiral(area, width, i); 

            % computing the starting point of the first line of the first ring
            % the starting point is positioned before the vertexStart
            if(i == 1 && j == 1)
                [startingPoint, intersectionPoint, vertexStartAngle] = ...
                    computing_starting_point(area, lengthOfArea, direction, ...
                                             vertexStart, width, scanAngle);

                % the intersectinPoint is added as a final point of the area if it's 
                % inside the area (on the edge) or the angle is smaller than 90
                if(inpolygon(intersectionPoint(1), intersectionPoint(2), ...
                             area(:,1), area(:,2)) || vertexStartAngle < 90)               
                    area = cat(1, area(1:end-1,:), intersectionPoint);
                else
                    area = area(1:end-1,:);
                end

                if(vertexStartAngle < 90)
                    % computing the centre point positioned regarding the startingPoint
                    [centralPoint] = computing_central_point(oppositeDirection, startingPoint', width, height);
                    % rotating an object regarding a origin/reference point 
                    [centralPoint] = rotating_object(centralPoint, startingPoint, scanAngle);
                else  
                    % computing the centre point positioned regarding the intersectionPoint
                    [centralPoint] = computing_central_point(oppositeDirection, intersectionPoint, width, height);
                    % rotating an object regarding a origin/reference point 
                    [centralPoint] = rotating_object(centralPoint, intersectionPoint', scanAngle);
                end

            else 
                % computing the centre point positioned regarding the vertexStart
                [centralPoint] = computing_central_point(direction, vertexStart, width, height);

                % the overlapping is applied only in the inner rings, moving
                % the centralPoint (the reference for the entire line)
                if(j > 1)
                    centralPoint(2) = centralPoint(2) - ovx;
                end

                % rotating an object regarding a origin/reference point 
                [centralPoint] = rotating_object(centralPoint, vertexStart', scanAngle);
            end 

            % computing the waypoints considering the distance of the edge
            % the waypoints are rotated and positioned considering the centre point
            [waypoints, numberOfWaypoints] = ...
                computing_waypoints(distanceEdge, 0, height, ovy,... 
                                    scanAngle, centralPoint, direction);
                % plotting the waypoints in the area
                plot(waypoints(1,:), waypoints(2,:),'*k');

                % concatenating all the waypoints
                fullListOfWaypoints = cat(1, fullListOfWaypoints, waypoints');

                % computing the corresponding line of the waypoints
                line = repmat(counter, length(waypoints(1,:)), 1);
                waypointsInfo = cat(1, waypointsInfo, line);
                counter = counter + 1;

            % rotating and plotting the projected area around the waypoints
            % computing the side lines of the projected areas of the first and
            % last waypoints of each coverage line
            [lineOfProjectedAreas, projectedArea, sideLines] = ...
                drawing_projected_area_spiral(waypoints, numberOfWaypoints, width, height, ...
                                              scanAngle, direction, sideLines, i, j,... 
                                              lengthOfArea);                         
                                          
                verticesInProjectedArea = 0; 
                lastVertexInside = false;
                penultimateVertexInside = false;
                for m = 1 : numberOfWaypoints
                    plot(lineOfProjectedAreas(1,:,m), lineOfProjectedAreas(2,:,m), '--k');

                    % verifying if the last and penultimate lowerVertices 
                    % are inside the projected areas of the first line
                    % if so, they'll be removed in the function 'updating_area_after_first_line' 
                    [verticesInProjectedArea, lastVertexInside, penultimateVertexInside] = ...
                        vertices_inside_projected_areas(area(end,:),...
                                                        area(end-1,:), i,...    
                                                        lineOfProjectedAreas(1,:,m), ...
                                                        lineOfProjectedAreas(2,:,m), ...
                                                        verticesInProjectedArea, ...
                                                        lastVertexInside, ...
                                                        penultimateVertexInside);
                end 

            % updating the vertexStart for the next coverage line    
            vertexStart = area(i+1,:);

            % in the first line (i) of the inner rings (j > 1)...
            if(j > 1 && i == 1)  
                [area] = updating_area_after_first_line(area, height, sideLines, lastTwoPoints, verticesInProjectedArea);                                   
            end 
            i = i + 1;
            % pause
        end % while 

        % the last two points of the sideLines
        lastTwoPoints = sideLines(end-1:end,:);

        % moving the first two points of sideLines to the end to compute
        % the last intersection point (lowerVertices) of the inner rings
        if(j ~= 1)
            sideLines = cat(1, sideLines(3:end,:), sideLines(1:2,:));
        end

        % lowerVertices are the intersection points between the sideLines
        % and are computed at the end of each ring
        [lowerVertices] = computing_lower_vertices_spiral(sideLines);
        
        % updating the area with vertexStart and lowerVertices
        area = cat(1, vertexStart, lowerVertices);

        % updating and plotting the area with the intersection points
        [area] = updating_area(vertexStart, area, height);
       
    end % for numberOfRings    
end