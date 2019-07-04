function[verticesDifferent] = vertices_different(vertex, v1, v2, v3, v4)
    % checking if the vertex (intersection point) is different from the 4
    % vertices
   
    tol = 0.001;
    c1 = abs(vertex(1)-v1(1)) < tol && abs(vertex(2)-v1(2)) < tol;
    c2 = abs(vertex(1)-v2(1)) < tol && abs(vertex(2)-v2(2)) < tol;
    c3 = abs(vertex(1)-v3(1)) < tol && abs(vertex(2)-v3(2)) < tol;
    c4 = abs(vertex(1)-v4(1)) < tol && abs(vertex(2)-v4(2)) < tol;
    
    if(~c1 && ~c2 && ~c3 && ~c4)
        verticesDifferent = true;
    else
        verticesDifferent = false;
    end    
end