function[distanceEdge] = ...
    recomputing_distance(firstCriticalLine, closestVertexC, closestVertexD, cornerPoint)
    % recomputing the distance of each stripe using the corner point
    % (initial position) and the closest vertex (final position considering
    % the vertices from scan to far)

    distanceC = norm([firstCriticalLine(1,1) - closestVertexC(1) ;
                      firstCriticalLine(1,2) - closestVertexC(2)]);

    distanceD = norm([firstCriticalLine(4,1) - closestVertexD(1) ;
                      firstCriticalLine(4,2) - closestVertexD(2)]);

    if(distanceC > distanceD)
        distanceEdge = norm([cornerPoint(1) - closestVertexC(1);
                             cornerPoint(2) - closestVertexC(2)]);
    else    
        distanceEdge = norm([cornerPoint(1) - closestVertexD(1);
                             cornerPoint(2) - closestVertexD(2)]);
    end
end    