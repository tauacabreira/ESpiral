function [vertexScan, vertexNextScan, verticesFromStartToScan, directionScan, directionFar] = ...
    sorting_vertices_from_start_to_scan(area, lengthOfArea, vertexStart, longestEdgeIndex, nextLongestEdgeIndex)
    % organizing the order of the vertices from the starting point to the
    % first point of the longest edge

    % array with the path from the starting point until the vertex scan
    verticesFromStartToScan = [];
    
    % discovering which point of the longest edge 
    % is closer to the starting point
    distanceFromP1ToTheStartingPoint = ...
                           norm([area(longestEdgeIndex,1) - vertexStart(1); 
                                 area(longestEdgeIndex,2) - vertexStart(2)]);

    distanceFromP2ToTheStartingPoint = ...
                           norm([area(nextLongestEdgeIndex,1) - vertexStart(1); 
                                 area(nextLongestEdgeIndex,2) - vertexStart(2)]);

    if(distanceFromP1ToTheStartingPoint > distanceFromP2ToTheStartingPoint)
       % vertexScan represents the beginning of the back-and-forth pattern
       vertexScan     = [area(nextLongestEdgeIndex,1) area(nextLongestEdgeIndex,2)];
       vertexNextScan = [area(longestEdgeIndex,1) area(longestEdgeIndex,2)];

       verticesFromStartToScan(1) = 1;
       index = 2;
       for i = lengthOfArea : -1 : longestEdgeIndex
           verticesFromStartToScan(index) = i;
           index = index + 1;
       end
       
       v1 = area(1,:);
       v2 = area(lengthOfArea,:);
       v3 = area(lengthOfArea - 1,:);
    else
       vertexScan = [area(longestEdgeIndex,1) area(longestEdgeIndex,2)];
       vertexNextScan = [area(nextLongestEdgeIndex,1) area(nextLongestEdgeIndex,2)];

       for i = 1 : longestEdgeIndex
          verticesFromStartToScan(i) = i; 
       end
       verticesFromStartToScan(i+1) = nextLongestEdgeIndex;
       
       if(isequal(vertexStart, vertexScan))
          v1 = area(verticesFromStartToScan(1),:);
          v2 = area(verticesFromStartToScan(2),:);
          if(verticesFromStartToScan(2) == lengthOfArea);
              v3 = 1;
          else
              v3 = area(verticesFromStartToScan(2)+1,:);
          end    
       else
          v1 = area(verticesFromStartToScan(1),:);
          v2 = area(verticesFromStartToScan(2),:);
          v3 = area(verticesFromStartToScan(3),:);
       end
    end
    
    x = [v1(1) v2(1) v3(1)];
    y = [v1(2) v2(2) v3(2)];
    
    % scanning direction
    % directionScan => from the starting point to the scanning point
    % directionFar  => from the starting point to the final point (in
    % opposite direction)
    if(ispolycw(x, y))
        directionScan = 'clockwise';
        directionFar  = 'counterclockwise';
    else
        directionScan = 'counterclockwise';
        directionFar  = 'clockwise';
    end
end    