function [area, lengthOfArea, width, height, ovx, ovy, altitude] = gopro_setup(area)
% initial configuration of the area, width and height of the projected
% area, overlaping rate 

    % number of vertices of the area
    lengthOfArea = length(area) - 1; 

    % printing the area of interest
    plot(area(:,1), area(:,2), '-b', 'LineWidth', 1);
    hold on
    axis equal
    
    % parameters of the camera
    fieldOfView = 100;
    imageResolutionX = 2386;
    imageResolutionY = 2386;
    aspectRatio = imageResolutionX / imageResolutionY;
    altitude = 10;

    % width and height of the projected area
    width = 2 * altitude * tand(fieldOfView / 2);
    height = width / aspectRatio;

    % initial overlaping rate
    ovx = 0.1; 
    ovy = 0.1; 
end