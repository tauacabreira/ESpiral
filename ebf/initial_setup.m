function [area, lengthOfArea, width, height, ovx, ovy,altitude] = initial_setup()
% initial configuration of the area, width and height of the projected
% area, overlaping rate 

    % DIFFERENT AREAS
    %area = [ 1 0; 3 0; 4 5; 1 4; 0 2; 1 0 ];
    %area = [ 1 0; 3 0; 5 1; 6 5; 2 4; 0 2; 1 0 ];
    %area = [ 1 0; 3 0.5; 4 5; 1 4; 0 2; 1 0 ];
    %area = [ -3 0; 0 -1; 3 0; 4 5; -3 4.5; -4 2; -3 0 ];
    area = [ -3 0; 0 -1; 3 0; 4 5; 0 6; -3 4.5; -4 2; -3 0 ]*50;
    
    % AREA '1' WITH DIFFERENT STARTING POINTS
    %area = [ 1 0; 3 0; 4 1; 5 5; 1 4; 0 2; 1 0 ];
    %area = [ 0 2; 1 0; 3 0; 4 1; 5 5; 1 4; 0 2 ];
    %area = [ 1 4; 0 2; 1 0; 3 0; 4 1; 5 5; 1 4 ];
    %area = [ 5 5; 1 4; 0 2; 1 0; 3 0; 4 1; 5 5 ];
    %area = [ 4 1; 5 5; 1 4; 0 2; 1 0; 3 0; 4 1 ];
    %area = [ 3 0; 4 1; 5 5; 1 4; 0 2; 1 0; 3 0 ];
    
    % AREA '2' WITH DIFFERENT STARTING POINTS
%     area = [ 1 0; 3 0; 4 1.5; 5 5; 1 4; 0 2; 1 0 ];
%     area = [ 0 2; 1 0; 3 0; 4 1.5; 5 5; 1 4; 0 2 ];
%     area = [ 1 4; 0 2; 1 0; 3 0; 4 1.5; 5 5; 1 4 ];
%     area = [ 5 5; 1 4; 0 2; 1 0; 3 0; 4 1.5; 5 5 ];
%     area = [ 4 1.5; 5 5; 1 4; 0 2; 1 0; 3 0; 4 1.5 ];
%     area = [ 3 0; 4 1.5; 5 5; 1 4; 0 2; 1 0; 3 0 ];
    
    % AREA '3' WITH DIFFERENT STARTING POINTS
    %area = [ -3 0; 3 0; 4 5; -3 4.5; -4 2; -3 0 ];
    %area = [ -4 2; -3 0; 3 0; 4 5; -3 4.5; -4 2 ];
    %area = [ -3 4.5; -4 2; -3 0; 3 0; 4 5; -3 4.5 ];
    %area = [ 4 5; -3 4.5; -4 2; -3 0; 3 0; 4 5 ];
    %area = [ 3 0; 4 5; -3 4.5; -4 2; -3 0; 3 0 ];

    % number of vertices of the area
    lengthOfArea = length(area) - 1; 

    % printing the area of interest
%     plot(area(:,1), area(:,2), '-b')
%     axis equal
%     hold on

    % parameters of the camera
    fieldOfView = 90;
    imageResolutionX = 1920;
    imageResolutionY = 1080;
    aspectRatio = imageResolutionX / imageResolutionY;
    altitude = 40;

    % width and height of the projected area
    width = 2 * altitude * tand(fieldOfView / 2);
    height = width / aspectRatio;

    % initial overlaping rate
    ovx = 0; 
    ovy = 0; 
end