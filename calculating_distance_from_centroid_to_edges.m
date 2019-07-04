function[distanceFromCentroidToEdge] = ...
    calculating_distance_from_centroid_to_edges(area, lengthOfArea, centroid)
    % calcluting the distance from the centroid to each edge of the polygon
    % the array distanceFromCentroidToEdge contains all the distances
    
    distanceFromCentroidToEdge = zeros(1,lengthOfArea);
    for i = 1 : lengthOfArea
       index = mod(i, lengthOfArea) + 1;
       
       distanceFromCentroidToEdge(i) = ...
           abs(det([(area(i,1) - area(index,1)) ,(area(i,2) - area(index,2)); ...
                    (centroid(1) - area(index,1)), (centroid(2) - area(index,2))] ) / ...
                     norm(area(i,:) - area(index,:)));
    end
end