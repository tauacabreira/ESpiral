function[numberOfRings, ovx] = ...
    computing_rings(distance, width, ovx)
    % computing the number and the distance between the rings considering
    % the overlapping   
    
    distanceRings = width*(1 - ovx);
    
    if distance < distanceRings /2
        numberOfRings = 0;
        return;
    end
   
    numberOfRings = ceil((distance - ovx*width) / distanceRings);
    
    % recomputing the distance between the rings
    distanceRings = (distance - width) / (numberOfRings - 1);
   
    % overlapping between rings
    ovx = width - distanceRings;
    
    if isnan(numberOfRings)
        numberOfRings = 0;
    end
    
end