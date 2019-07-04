function[maximumWidth, farthestPointIndex, vertexFar] = ...
    finding_farthest_vertex(area, lengthOfArea, vertexScan, vertexNextScan)
    % discovers the farthest vertex from the longest edge and 
    % the distance between them
    
    maximumWidth = 0;
    % calculating the largest distance from a vertex to the longest edge 
    % to apply in the number of stripes formula

    for i = 1 : lengthOfArea
        v1 = [vertexScan 0];        % initial point of the line
        v2 = [vertexNextScan 0];    % final point of the line
        pt = [area(i, :) 0];        % corresponding vertex i

        % computing the distance between each vertex and the longest edge
        distance = norm(cross(v1 - v2, pt - v2)) / norm(v2 - v1);

        % maximumWidth is the distance between the farthest vertex and the longest edge
        if(distance > maximumWidth)
            maximumWidth = distance;
            farthestPointIndex = i;
            vertexFar = area(farthestPointIndex,:);
        end    
    end
end