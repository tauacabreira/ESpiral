function [distanceToIntersectionPointA, closestVertexA, ...
          distanceToIntersectionPointB, closestVertexB] = ...
                finding_the_intersection_point_of_the_stripe(height, criticalLine, vertices)
    
    % find the intersection point between the lateral lines of the
    % first/last projected area and the lower/upper vertices and measures the distance 
            
    distanceToIntersectionPointA = 1000;
    distanceToIntersectionPointB = 1000;
    
    intersectionArrayA = zeros(length(vertices) - 1, 2);
    intersectionArrayB = zeros(length(vertices) - 1, 2);
    
    for j = 1 : length(vertices) - 1
       % first side 
       [intersectionPoint] = ...
           line_intersection(criticalLine(1,:), criticalLine(2,:), ... 
                             vertices(j,:), vertices(j+1,:)); 

       distance = norm([criticalLine(1,1) - intersectionPoint(1); 
                        criticalLine(1,2) - intersectionPoint(2)]); 
                    
       if distance < distanceToIntersectionPointA 
           distanceToIntersectionPointA = distance;
           closestVertexA = intersectionPoint;
           indexA = j;
       end
       
       intersectionArrayA(j,:) = intersectionPoint;
          
       % second side
       [intersectionPoint] = ...
           line_intersection(criticalLine(3,:), criticalLine(4,:), ...  
                             vertices(j,:), vertices(j+1,:)); 

       distance = norm([criticalLine(4,1) - intersectionPoint(1); 
                        criticalLine(4,2) - intersectionPoint(2)]); 
                    
       if distance < distanceToIntersectionPointB 
           distanceToIntersectionPointB = distance;
           closestVertexB = intersectionPoint;
           indexB = j;
       end
       
       intersectionArrayB(j,:) = intersectionPoint;
    end
    
    % if the two intersection points of the same projected area are placed
    % in different lines
    if(indexA ~= indexB) 
        dA = norm([intersectionArrayA(indexA,1) - intersectionArrayA(indexB,1); 
                   intersectionArrayA(indexA,2) - intersectionArrayA(indexB,2)]);
 
        dB = norm([intersectionArrayB(indexA,1) - intersectionArrayB(indexB,1); 
                   intersectionArrayB(indexA,2) - intersectionArrayB(indexB,2)]); 
        
        if((dA < dB) && (dA < height))        
           closestVertexA = intersectionArrayA(indexB,:); 
           distanceToIntersectionPointA = ...
                   norm([criticalLine(1,1) - closestVertexA(1); 
                         criticalLine(1,2) - closestVertexA(2)]);
        elseif((dA > dB) && (dB < height))
           closestVertexB = intersectionArrayB(indexA,:); 
           distanceToIntersectionPointB = ...
                   norm([criticalLine(4,1) - closestVertexB(1); 
                         criticalLine(4,2) - closestVertexB(2)]);           
        end
    end    
end