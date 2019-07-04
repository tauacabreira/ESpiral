function [newStartPoint, cornerPoint] = ...
    recomputing_starting_point(area, currentStripe, numberOfStripes,... 
                               width, height, scanAngle, farthestPointIndex,... 
                               closestVertexA, closestVertexB,... 
                               distancePointA, distancePointB, direction)
    % during the back-and-forth movements, the starting point of each stripe is moved
    % based on the intersection points that marks the limits of the visited places
    % the corner point is the new vertex reference point used to compute the distance of the stripe
                           
    if(currentStripe == numberOfStripes - 1)
        if(strcmp(direction, 'counterclockwise'))
            newStartPoint = area(farthestPointIndex,:)' + [width/2, height/2]';
            cornerPoint   = area(farthestPointIndex,:)' + [width, 0]';
        else
            newStartPoint = area(farthestPointIndex,:)' + [-width/2, height/2]';
            cornerPoint   = area(farthestPointIndex,:)' + [-width, 0]';
        end    
        newStartPoint = rotating_object(newStartPoint, area(farthestPointIndex,:)', scanAngle - 90);
        cornerPoint   = rotating_object(cornerPoint, area(farthestPointIndex,:)', scanAngle - 90);
     
    elseif(distancePointA > distancePointB)
        newStartPoint = closestVertexA' + [width/2, height/2]';
        newStartPoint = rotating_object(newStartPoint, closestVertexA', scanAngle - 90);
        cornerPoint   = closestVertexA' + [width, 0]';
        cornerPoint   = rotating_object(cornerPoint, closestVertexA', scanAngle - 90);
    else
        newStartPoint = closestVertexB' + [-width/2, height/2]';
        newStartPoint = rotating_object(newStartPoint, closestVertexB', scanAngle - 90); 
        cornerPoint   = closestVertexB' + [-width, 0]';
        cornerPoint   = rotating_object(cornerPoint, closestVertexB', scanAngle - 90);
    end    
end