function[lowerVertices] = computing_lower_vertices(sideLines, direction)
    % the lowerVertices are the intersection points between the sideLines
    % and they are computed at the end of the first stripe
    
    numberOfIntersectionPoints = floor(length(sideLines) / 4); 
    lowerVertices = zeros(numberOfIntersectionPoints,2);

    for m = 0 : numberOfIntersectionPoints - 1
         p1 = sideLines(1+4*m,:);
         p2 = sideLines(2+4*m,:);
         p3 = sideLines(3+4*m,:);
         p4 = sideLines(4+4*m,:);

         [lowerVertices(m+1,:)] = line_intersection(p1, p2, p3, p4);
         plot(lowerVertices(m+1,1), lowerVertices(m+1,2),'or');
    end

    % the last projected area of phase 3 has no intersection, so the
    % last point is chosen as a lowerVertex
    index = length(sideLines);
    
    if(strcmp(direction, 'counterclockwise'))
        [lowerVertices(m+2,:)] = sideLines(index,:);
    else
        [lowerVertices(m+2,:)] = sideLines(index - 1,:);
    end    
    plot(lowerVertices(m+2,1), lowerVertices(m+2,2),'or');
end        