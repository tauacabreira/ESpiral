function[startingPoint, intersectionPoint, vertexStartAngle] = ...
    computing_starting_point(area, lengthOfArea, direction, ...
                             vertexStart, width, scanAngle)                  
                         
    % positioning the starting point according to direction                     
    if(strcmp(direction, 'clockwise'))
        xCenter = vertexStart(1);
        yCenter = vertexStart(2) - width;
    else
        xCenter = vertexStart(1);
        yCenter = vertexStart(2) + width;
    end
    startingPoint = [xCenter yCenter]';
    
    % rotating the starting point
    [startingPoint] = rotating_object(startingPoint, vertexStart', scanAngle);
    
    % creating a line and rotating it using the same angle of the vertexStart
    % the line is positioned at the starting point
    p = [0 1; 0 0];
    origin = repmat([0 0], 2, 1)' ; 
    [p] = rotating_object(p, origin, scanAngle);
    %plot(p(1,:), p(2,:), '*b'); 

    p(1,:) = p(1,:) + startingPoint(1);
    p(2,:) = p(2,:) + startingPoint(2);
    %plot(p(1,:), p(2,:), '*r');
    
    % intersecting the line of the starting point with the edge formed by
    % the vertexStart and the last vertex - the intersection point will be
    % the new starting point
    [intersectionPoint] = line_intersection(p(:,1)', p(:,2)', ...
                                            vertexStart, area(lengthOfArea,:));
    
    v2 = area(2,:);                                    
    v1 = vertexStart;
    v3 = area(lengthOfArea,:);
    vertexStartAngle = atan2d(abs((v2(1)-v1(1))*(v3(2)-v1(2))-(v2(2)-v1(2))*(v3(1)-v1(1))),...
                                  (v2(1)-v1(1))*(v3(1)-v1(1))+(v2(2)-v1(2))*(v3(2)-v1(2)));                                                                      
end