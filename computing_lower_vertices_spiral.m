function[lowerVertices] = computing_lower_vertices_spiral(sideLines)
    % the lowerVertices are the intersection points between the sideLines
    % and they are computed at the end of the first stripe
    
    numberOfIntersectionPoints = floor(length(sideLines) / 4); 
    lowerVertices = zeros(numberOfIntersectionPoints, 2);

    for m = 0 : numberOfIntersectionPoints - 1
         p1 = sideLines(1+4*m,:);
         p2 = sideLines(2+4*m,:);
         p3 = sideLines(3+4*m,:);
         p4 = sideLines(4+4*m,:);
         
         [lowerVertices(m+1,:)] = line_intersection(p1, p2, p3, p4); 
         plot(lowerVertices(m+1,1), lowerVertices(m+1,2), '*r');
         
         plot(p1(1), p1(2), 'bo');
         plot(p2(1), p2(2), 'bo');
         plot(p3(1), p3(2), 'bo');
         plot(p4(1), p4(2), 'bo');
         %pause;
    end
end        