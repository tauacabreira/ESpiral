function[distanceEdge, scanAngle] = ...
    calculating_distance_and_angles(area, vertices, width, i, phase)
    % calculating distance and scan angle of the edge that is being covered
    
    v2 = area(vertices(i),:);   
    v1 = area(vertices(i+1),:); 
    v3 = area(vertices(i+2),:);
    
    distanceEdge = norm([v1(1) - v2(1); v1(2) - v2(2)]);
    scanAngle = radtodeg(asin((v1(2) - v2(2)) / distanceEdge));
    
    % the extra distance considering the turnAngle is only applied on phase 2
    if(phase == 2)
        turnAngle = atan2d(abs((v2(1)-v1(1))*(v3(2)-v1(2))-(v2(2)-v1(2))*(v3(1)-v1(1))),...
                               (v2(1)-v1(1))*(v3(1)-v1(1))+(v2(2)-v1(2))*(v3(2)-v1(2)));
                       
        distanceEdge = distanceEdge + max(0, -width/tand(turnAngle));                   
    end 
    
    if(v2(1) > v1(1))
        scanAngle = 180 - scanAngle;
    end
end    