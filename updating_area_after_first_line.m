function[area] = ...
    updating_area_after_first_line(area, height, sideLines,... 
                                   lastTwoPoints, verticesInProjectedArea)
   % the first two points are intersected with the two last points
   % computed in the previous iteration, generating the lastLowerVertex
   
   firstTwoPoints = sideLines(1:2,:); 
   [lastLowerVertex] = ... 
       line_intersection(lastTwoPoints(1,:), lastTwoPoints(2,:),...
                         firstTwoPoints(1,:), firstTwoPoints(2,:));

   v1 = firstTwoPoints(1,:);
   v2 = lastLowerVertex;
   v3 = area(end,:);
   v4 = area(end-1,:);

   distance = abs(norm([v3(1) - v2(1); v3(2) - v2(2)]));  
   [vertex] = line_intersection(v1, v2, v3, v4);

   distanceFromV2 = abs(norm([v2(1) - vertex(1); v2(2) - vertex(2)]));
   distanceFromV3 = abs(norm([v3(1) - vertex(1); v3(2) - vertex(2)]));

   if(distance < (1.5 * height) && ... 
      distanceFromV2 < distance && distanceFromV3 < distance) 
       plot(area(end,1), area(end,2), '*w');
       area = cat(1, area(1:end-1,:), vertex);
       plot(vertex(1), vertex(2), '*b');
   else
       area = cat(1, area(1:end-verticesInProjectedArea,:), lastLowerVertex); 
       plot(lastLowerVertex(1), lastLowerVertex(2), '*y');
   end
end