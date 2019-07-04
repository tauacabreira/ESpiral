function[object] = rotating_object(object, origin, angle)
% rotating an object regarding a origin/reference point

    % rotation matrix
    r = [cosd(angle) -sind(angle); sind(angle) cosd(angle)]; 
    object = r*(object - origin) + origin;  
end