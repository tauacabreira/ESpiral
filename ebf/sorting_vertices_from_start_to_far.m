function[verticesFromStartToFar] = ...
    sorting_vertices_from_start_to_far(lengthOfArea, direction, farthestPointIndex)
    % organizing the order of the vertices from the starting point to the farthest point
    % corresponds to the third phase of the algorithm, the final part of the path
    
    % array with the path from the start point to the farthest point
    verticesFromStartToFar = [];
    
    if strcmp(direction,'clockwise')
       verticesFromStartToFar(1) = 1;
       index = 2;
       for i = lengthOfArea : -1 : farthestPointIndex - 1
          verticesFromStartToFar(index) = i;
          index = index + 1;
       end 
    else
       for i = 1 : farthestPointIndex + 1
            verticesFromStartToFar(i) = i;
       end    
    end
end