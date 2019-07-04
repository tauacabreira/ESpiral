function [area] = generate_convex_concave_area(numVert)

    % specify polygon variables
    %numVert = 4;
    radius = 100;
    radVar = 0; % variance in the spikiness of vertices
    angVar = 1; % variance in spacing of vertices around the unit circle

    % preallocate x and y 
    x = zeros(numVert,1);
    y = zeros(numVert,1);

    % angle of the unit circle in radians
    circleAng = 2*pi;
    % the average angular separation between points in a unit circle
    angleSeparation = circleAng/numVert;
    % create the matrix of angles for equal separation of points
    angleMatrix = 0: angleSeparation: circleAng;
    % drop the final angle since 2Pi = 0
    angleMatrix(end) = [];

    % generate the points x and y
    for k = 1:numVert
        x(k) = (radius + radius*rand(1)*radVar) * cos(angleMatrix(k) + angleSeparation*rand(1)*angVar);
        y(k) = (radius + radius*rand(1)*radVar) * sin(angleMatrix(k) + angleSeparation*rand(1)*angVar);
    end

    area(:,1) = [x; x(1)];
    area(:,2) = [y; y(1)];
end