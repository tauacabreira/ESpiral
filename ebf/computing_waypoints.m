function[waypoints, numberOfWaypoints] = ...
    computing_waypoints(distanceEdge, distanceStripes, height, ovy, ...
                        scanAngle, centralPoint, direction)
    % computing the waypoints considering the distance of the edge
    % the waypoints are rotated and positioned considering the centre point

    distanceWaypoints = height - ovy; 
    numberOfWaypoints = ceil((distanceEdge - ovy) / distanceWaypoints);  
    
    if(numberOfWaypoints == 1)
        distanceWaypoints = 0;
    else    
        distanceWaypoints = (distanceEdge - height) / (numberOfWaypoints - 1);
    end    
    
    if(strcmp(direction, 'clockwise'))
        distanceStripes = -distanceStripes;
    end
    
    % computing the waypoints
    waypoints = zeros(numberOfWaypoints,2);
    k = 1;
    for j = 0 : numberOfWaypoints - 1
        waypoints(k,:) = [(distanceWaypoints * j) distanceStripes];
        k = k + 1;
    end

    % rotating the array of waypoints
    origin = repmat([0 0], numberOfWaypoints, 1)' ; 
    [waypoints] = rotating_object(waypoints', origin, scanAngle); 
    
    % positioning the list of waypoints in the centre point
    waypoints(1,:) = waypoints(1,:) + centralPoint(1);
    waypoints(2,:) = waypoints(2,:) + centralPoint(2);   
end    