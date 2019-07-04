function[distanceEdge, scanAngle] = ...
    calculating_distance_and_angles_spiral(area, width, i)
    % calculating distance and scan angle of the edge that is being covered
    
    index = length(area) - 1;
    v2 = area(index,:);
    v1 = area(i,:);
    v3 = area(i+1,:);
    
    distanceEdge = norm([v3(1) - v1(1); v3(2) - v1(2)]);
    scanAngle = radtodeg(asin((v3(2) - v1(2)) / distanceEdge));

    % the extra distance considering the turnAngle is only applied on the
    % first line of each ring
    if(i == 1)
        turnAngle = atan2d(abs((v2(1)-v1(1))*(v3(2)-v1(2))-(v2(2)-v1(2))*(v3(1)-v1(1))),...
                               (v2(1)-v1(1))*(v3(1)-v1(1))+(v2(2)-v1(2))*(v3(2)-v1(2)));
                       
        distanceEdge = distanceEdge + max(0, -width/tand(turnAngle));                   
    end 
    
    if(v1(1) > v3(1))
        scanAngle = 180 - scanAngle;
    end
end    