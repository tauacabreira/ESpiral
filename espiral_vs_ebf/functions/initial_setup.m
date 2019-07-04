function [lengthOfArea, width, height, ovx, ovy] = initial_setup(area)

    % number of vertices of the area
    lengthOfArea = length(area) - 1; 

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
    ovy = 0; 
end