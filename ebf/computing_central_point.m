function[centralPoint] = computing_central_point(direction, vertexStart, width, height)
% computing the centre point positioned regarding the starting point.
% the starting point is updated at the final of every line coverage and
% represents the inital vertex of the next edge to be covered
    
    if(strcmp(direction, 'clockwise'))
        xCenter = vertexStart(1) + (height/2);
        yCenter = vertexStart(2) - (width/2);
    else
        xCenter = vertexStart(1) + (height/2);
        yCenter = vertexStart(2) + (width/2);
    end
    
    centralPoint = [xCenter yCenter]';
end    