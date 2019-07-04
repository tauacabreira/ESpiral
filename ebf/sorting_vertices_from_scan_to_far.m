function[verticesFromScanToFar] = ...
    sorting_vertices_from_scan_to_far(direction, lengthOfArea, farthestPointIndex,...
                                      startIndex, scanIndex, nextScanIndex)
    % organizing the order of the vertices from the scan point to the farthest point
     
    % array with the path from the vertex scan to the farthest point
    verticesFromScanToFar = [];
    
    if strcmp(direction, 'clockwise')
       if(scanIndex < nextScanIndex) 
           verticesFromScanToFar(1) = scanIndex;
           index = 2;
           for i = lengthOfArea : -1 : farthestPointIndex
              verticesFromScanToFar(index) = i;
              index = index + 1;
           end
       else
           index = 1;
           for i = scanIndex : -1 : farthestPointIndex
              verticesFromScanToFar(index) = i;
              index = index + 1;
           end
       end   
    else
       if(startIndex == farthestPointIndex)
           index = 1;
           for i = scanIndex : lengthOfArea
                verticesFromScanToFar(index) = i;
                index = index + 1;
           end
           verticesFromScanToFar(index) = farthestPointIndex;
       else
           index = 1;
           for i = scanIndex : farthestPointIndex
                verticesFromScanToFar(index) = i;
                index = index + 1;
           end   
       end
    end
end