function[vertexStart] = updating_vertex_start(direction, projectedArea)
    % the starting point of the next line will be the final point of the
    % current line
 
    if(strcmp(direction, 'clockwise'))
        vertexStart = [projectedArea(1,3) projectedArea(2,3)];
    else
        vertexStart = [projectedArea(1,2) projectedArea(2,2)];
    end  
end       