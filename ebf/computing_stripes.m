function [numberOfStripes, distanceStripes, ovx] = ...
    computing_stripes(width, ovx, maximumWidth)
    % computing the number and the distance between the stripes considering 
    % the overlaping
    
    distanceStripes = width - ovx;
    numberOfStripes = ceil((maximumWidth - ovx) / distanceStripes);
    
    % number of stripes is rounded up and should be always even
    if(mod(numberOfStripes, 2) ~= 0)
        numberOfStripes = numberOfStripes + 1; 
    end
    
    % recomputing the distance between the stripes
    distanceStripes = (maximumWidth - width) / (numberOfStripes - 1);
    % overlapping between stripes
    ovx = width - distanceStripes;
end