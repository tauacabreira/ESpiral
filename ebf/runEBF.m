function runEBF(area,lengthOfArea,width, height, ovx, ovy)
% initial configuration of the area, width and height of the projected
% area, overlaping rate
%[area, lengthOfArea, width, height, ovx, ovy] = initial_setup();
 
 
% travels through edges to find the longest one
[longestEdge, longestEdgeIndex, nextLongestEdgeIndex] = finding_longest_edge(area, lengthOfArea);

% starting vertex (the first point of the area)
vertexStart = area(1,:);   

% organizing the order of the vertices from the starting point to the
% first point of the longest edge
[vertexScan, vertexNextScan, verticesFromStartToScan, directionScan, directionFar] = ...
    sorting_vertices_from_start_to_scan(area, lengthOfArea, vertexStart, longestEdgeIndex, nextLongestEdgeIndex);

% discovers the farthest vertex from the longest edge and the distance between them
[maximumWidth, farthestPointIndex, vertexFar] = ...
    finding_farthest_vertex(area, lengthOfArea, vertexScan, vertexNextScan);

% organizing the order of the vertices from the scan point to the farthest point
indexScan     = length(verticesFromStartToScan) - 1;
indexNextScan = length(verticesFromStartToScan);
[verticesFromScanToFar] = ...
    sorting_vertices_from_scan_to_far(directionScan, lengthOfArea, farthestPointIndex, ... 
                                      verticesFromStartToScan(1),...
                                      verticesFromStartToScan(indexScan),... 
                                      verticesFromStartToScan(indexNextScan));

% organizing the order of the vertices from the starting point to the farthest point
% corresponds to the third phase of the algorithm, the final part of the path
[verticesFromStartToFar] = ...
    sorting_vertices_from_start_to_far(lengthOfArea, directionFar, farthestPointIndex); 
   
% printing the startingPoint, farthestPoint, vertexScan and vertexNextScan
plot(vertexStart(1), vertexStart(2), 'xg');
plot(vertexFar(1), vertexFar(2), 'xr')
plot(vertexScan(1), vertexScan(2), 'og');
plot(vertexNextScan(1), vertexNextScan(2), 'or'); 

% complete list of waypoints and the correspondent lines
fullListOfWaypoints = [];
waypointsInfo = [];
counter = 1;
    
% ==== PHASE 03 ==== %
sideLinesPhase03 = []; 
waypointsPhase03 = [];
waypointsInfoPhase03 = [];

if ~isequal(vertexStart, vertexFar)
    for i = 1 : length(verticesFromStartToFar) - 2

        % calculating the distance of the edge that is being covered, the scan
        % angle and the turn angle of the next vertex
        [distanceEdge, scanAngle] = ...
            calculating_distance_and_angles(area, verticesFromStartToFar, width, i, 3);    
 
        % computing the centre point positioned regarding the starting point
        % the starting point is updated at the final of every line coverage and
        % represents the inital vertex of the next edge to be covered
        [centralPoint] = computing_central_point(directionFar, vertexStart, width, height);
        % -height
        
        % rotating an object regarding a origin/reference point
        % invertAngle = scanAngle - 180;
        [centralPoint] = rotating_object(centralPoint, vertexStart', scanAngle);

        % computing the waypoints considering the distance of the edge
        % the waypoints are rotated and positioned considering the centre point
        distanceStripes = 0;
        [waypoints, numberOfWaypoints] = ...
            computing_waypoints(distanceEdge, distanceStripes, height, ovy, scanAngle, centralPoint, directionFar);
            % plotting the waypoints in the area
            plot(waypoints(1,:), waypoints(2,:),'*k');
            
            % concatenating all the waypoints of phase 03
            waypointsPhase03 = cat(1, waypointsPhase03, waypoints');
            
            % computing the corresponding line of the waypoints of phase 03
            line = repmat(counter, length(waypoints'), 1);
            waypointsInfoPhase03 = cat(1, waypointsInfoPhase03, line);
            counter = counter + 1;
            
        % rotating and plotting the projected area around the waypoints
        % computing the side lines of the projected areas of the first and
        % last waypoints of each coverage line
        [lineOfProjectedAreas, projectedArea, sideLinesPhase03, firstCriticalLine, lastCriticalLine] = ...
            drawing_projected_area(waypoints, numberOfWaypoints, width, height, ...
                                   scanAngle, directionFar, sideLinesPhase03, 3, 0); 
            for m = 1 : numberOfWaypoints
                plot(lineOfProjectedAreas(1,:,m), lineOfProjectedAreas(2,:,m), '--k');
            end
            
        [vertexStart] = updating_vertex_start(directionFar, projectedArea); 
    end % for
end % if              

% inverting the waypoints of phase 03
waypointsPhase03 = flipud(waypointsPhase03);  
waypointsInfoPhase03 = flipud(waypointsInfoPhase03);
% reseting the counter for phase 01 and 02
counter = 1;

% returning the starting point to the initial vertex
vertexStart = area(1,:); 

% ==== PHASE 01 ==== %
% path from vertexStart to vertexScan
sideLinesPhase01 = []; 
waypointsPhase01 = [];
if ~isequal(vertexStart, vertexScan)
    for i = 1 : length(verticesFromStartToScan) - 2
        
        [distanceEdge, scanAngle] = ...
            calculating_distance_and_angles(area, verticesFromStartToScan, width, i, 1);
        
        [centralPoint] = computing_central_point(directionScan, vertexStart, width, height);
       
        [centralPoint] = rotating_object(centralPoint, vertexStart', scanAngle);

        distanceStripes = 0;
        [waypoints, numberOfWaypoints] = ...
            computing_waypoints(distanceEdge, distanceStripes, height, ovy, scanAngle, centralPoint, directionScan);
            plot(waypoints(1,:), waypoints(2,:),'*k');
            waypointsPhase01 = cat(1, waypointsPhase01, waypoints');
            
            line = repmat(counter, length(waypoints'), 1);
            waypointsInfo = cat(1, waypointsInfo, line);
            counter = counter + 1;
            
        [lineOfProjectedAreas, projectedArea, sideLinesPhase01, firstCriticalLine, lastCriticalLine] = ...
            drawing_projected_area(waypoints, numberOfWaypoints, width, height, ... 
                                   scanAngle, directionScan, sideLinesPhase01, 1, 0);
            for m = 1 : numberOfWaypoints
                plot(lineOfProjectedAreas(1,:,m), lineOfProjectedAreas(2,:,m), '--k');
            end
        
        [vertexStart] = updating_vertex_start(directionScan, projectedArea);
    end % for
end % if      
 
% ==== PHASE 02 ==== %
% path from vertexScan to vertexFar exploring multiple stripes 

sideLinesPhase02 = []; 
waypointsPhase02 = [];

% computing the number and the distance between the stripes considering 
% the overlaping
[numberOfStripes, distanceStripes, ovx] = ...
    computing_stripes(width, ovx, maximumWidth); 

[distanceEdge, scanAngle] = ...
    calculating_distance_and_angles(area, verticesFromScanToFar, width, 1, 2);
       
for i = 0 : numberOfStripes - 1 
    
    [centralPoint] = computing_central_point(directionScan, vertexStart, width, height);
   
    [centralPoint] = rotating_object(centralPoint, vertexStart', scanAngle);
    
    ds = distanceStripes * i;
    [waypoints, numberOfWaypoints] = ...
        computing_waypoints(distanceEdge, ds, height, ovy, scanAngle , centralPoint, directionScan);
       
    [lineOfProjectedAreas, projectedArea, sideLinesPhase02, firstCriticalLine, lastCriticalLine] = ...
        drawing_projected_area(waypoints, numberOfWaypoints, width, height, ...
                               scanAngle, directionScan, sideLinesPhase02, 2, ds);
            
    if(i == 0) 
        % the sideLines of phase 01 and 02 are inverted and concatenated with the
        % sideLines of phase 03, because they're  computed in opposite directions
        sideLines01AND02 = cat(1, sideLinesPhase01, sideLinesPhase02);
        sideLines01AND02 = flipud(sideLines01AND02);
        sideLines = cat(1, sideLines01AND02, sideLinesPhase03);
        
        % lowerVertices are the intersection points between the sideLines
        % and are computed at the end of the first stripe
        [lowerVertices] = computing_lower_vertices(sideLines, directionFar);
        
        % waypoints and projected areas are only plotted in the
        % first stripe in the original position
        plot(waypoints(1,:), waypoints(2,:),'*k');
        waypointsPhase02 = cat(1, waypointsPhase02, waypoints');
        
        line = repmat(counter, length(waypoints'), 1);
        waypointsInfo = cat(1, waypointsInfo, line);
        counter = counter + 1;
        
        for m = 1 : numberOfWaypoints
            plot(lineOfProjectedAreas(1,:,m), lineOfProjectedAreas(2,:,m), '--k');
        end

    elseif(i > 0) 
        % verticesFromScanToFar contains only indexes, so the vertices are
        % placed in upperVertices accessing the area using indexes
        j = 2;
        index = 1;
        upperVertices = zeros(length(verticesFromScanToFar) - 1, 2);
        while(j <= length(verticesFromScanToFar))
            upperVertices(index,:) = area(verticesFromScanToFar(j),:);
            index = index + 1;
            j = j + 1;
        end 
        
        % the starting point/distance of each stripe is recomputed as follows:
        % - there are two lateral lines in the last/first projected area
        % - extend these lines to the lower/upper vertices
        % - find the closest intersection point on each line
        % - compare the two intersection points and choose the farthest one
        [distancePointA, closestVertexA, distancePointB, closestVertexB] = ...
            finding_the_intersection_point_of_the_stripe(height, lastCriticalLine, lowerVertices);
        
        [distancePointC, closestVertexC, distancePointD, closestVertexD] = ...
            finding_the_intersection_point_of_the_stripe(height, firstCriticalLine, upperVertices);
       
        % recomputing the centre of the new starting point based on the intersection point and 
        % the corner point that will be used to measure the distance of each stripe
        [newStartPoint, cornerPoint] = ... 
            recomputing_starting_point(area, i, numberOfStripes, width, height,... 
                                       scanAngle, farthestPointIndex,... 
                                       closestVertexA, closestVertexB,... 
                                       distancePointA, distancePointB, directionScan); 
            
        % recomputing the distance of each stripe based on the corner point
        % and the intersection point of the upper vertices 
        [distanceEdge] = ...
            recomputing_distance(firstCriticalLine, closestVertexC, closestVertexD, cornerPoint);
            
        % recomputing the waypoints and projected areas using the new distance
        [waypoints, numberOfWaypoints] = ... 
            computing_waypoints(distanceEdge, 0, height, ovy, scanAngle , newStartPoint, directionScan);
            plot(waypoints(1,:), waypoints(2,:),'*k');
            
            % the waypoints of the odd stripes are inverted because they're
            % the returning points of the back-and-forth patterns
            if(mod(i,2) == 0)
                waypointsPhase02 = cat(1, waypointsPhase02, waypoints');
            else
                waypointsPhase02 = cat(1, waypointsPhase02, flipud(waypoints'));
            end 
            
            line = repmat(counter, length(waypoints'), 1);
            waypointsInfo = cat(1, waypointsInfo, line);
            counter = counter + 1;
        
        [lineOfProjectedAreas, projectedArea, sideLines, firstCriticalLine, lastCriticalLine] = ...
            drawing_projected_area(waypoints, numberOfWaypoints, width, height, ...
                                   scanAngle, directionScan, sideLines, 2, ds);
            for m = 1 : numberOfWaypoints
                plot(lineOfProjectedAreas(1,:,m), lineOfProjectedAreas(2,:,m), '--k');
            end
    end    
end     

% final list of all waypoints
fullListOfWaypoints = cat(1, fullListOfWaypoints, waypointsPhase01);
fullListOfWaypoints = cat(1, fullListOfWaypoints, waypointsPhase02);
fullListOfWaypoints = cat(1, fullListOfWaypoints, waypointsPhase03);

% replacing the index line of the waypoints of phase 03 and adding them to the
% general waypointInfo array
[waypointsInfoPhase03] = replacing_index_phase03(counter, waypointsInfoPhase03);

% line indexes of waypoints
waypointsInfo = cat(1, waypointsInfo, waypointsInfoPhase03);

end
