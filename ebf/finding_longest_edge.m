function[longestEdge, longestEdgeIndex, nextLongestEdgeIndex] = finding_longest_edge(area, lengthOfArea)
% travels through edges to find the longest one

    longestEdge = 0;
    for i = 1 : lengthOfArea
        % the index must be circular, i.e, after 'n' go back to '1'
        index = mod(i, lengthOfArea) + 1;

        % calculating the Euclidean distance between two points (edge)
        edgeSize = norm([area(index,1) - area(i,1); area(index,2) - area(i,2)]);    
        
        % updating the longest edge 
        % i and index are the two points representing the longest edge
        if edgeSize > longestEdge
            longestEdge = edgeSize;
            longestEdgeIndex = i;
            nextLongestEdgeIndex = index;  
        end 
    end % for
end