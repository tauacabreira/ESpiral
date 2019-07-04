function[area] = updating_area(vertexStart, area, height)
    % checking the distances between the vertices of the area
    % if the distance is smaller than '1.5 x height', find the intersection 
    % point and measure the distance between it and the two original vertices 
    % if the distance is smaller, then employ it as a new vertex
    newArea = [];
    removibileVertices = [];
    newArea(1,:) = vertexStart;
    indexA = 2;
    indexB = 2; 
    indexC = 1;

    for k = 1 : length(area)-1
       % 4 vertices of the area form the two lines used to compute the 
       % intersection point on each side of the area
       v1 = area(k,:);
       v2 = area(mod(k, length(area))+1,:);
       v3 = area(mod(k+1, length(area))+1,:);
       v4 = area(mod(k+2, length(area))+1,:);

       % measuring the distance and finding the intersection point
       distance = abs(norm([v2(1) - v3(1); v2(2) - v3(2)])); 
       [vertex] = line_intersection(v1, v2, v3, v4);

       % measuring the distance from the intersection point to the
       % closest original vertices
       distanceFromV2 = abs(norm([v2(1) - vertex(1); v2(2) - vertex(2)]));
       distanceFromV3 = abs(norm([v3(1) - vertex(1); v3(2) - vertex(2)]));

       % checking if the vertex (intersection point) is different from the 4 points
       [verticesDifferent] = vertices_different(vertex, v1, v2, v3, v4);

       % creating a newArea with copies of the original vertices and
       % the intersection points
       if(distance < (1.5 * height) && ... 
          distanceFromV2 < distance && distanceFromV3 < distance && ...
          verticesDifferent)

           % copying the original vertex and updating the indexes 
           newArea(indexB,:) = area(indexA,:);
           %plot(newArea(indexB,1), newArea(indexB,2), 'or');
           indexB = indexB + 1;
           indexA = mod(indexA, length(area)) + 1;

           % adding the intersection point
           newArea(indexB,:) = vertex;

           % saving the indexes of the original vertices located
           % before and after the intersection points - they should be
           % removed at the end
           if(k ~= length(area) - 1)
               removibileVertices(indexC) = indexB - 1;
               indexC = indexC + 1;
               removibileVertices(indexC) = indexB + 1;
               indexC = indexC + 1;
           end

           %plot(newArea(indexB,1), newArea(indexB,2), 'or');
           indexB = indexB + 1;
       else
           % just copying the original vertices
           newArea(indexB,:) = area(indexA,:);
           %plot(newArea(indexB,1), newArea(indexB,2), 'or');
           indexB = indexB + 1;
           indexA = mod(indexA, length(area)) + 1;               
       end
    end
    
    % removing the vertices located before and after the intersection points
    newArea(removibileVertices,:) = [];
    area = newArea;
    %plot(area(:,1), area(:,2), 'ob');
end