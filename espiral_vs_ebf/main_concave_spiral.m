close all;
clc

addpath('../ebf', '../energymodel', '../', '../utils', 'functions');

% computing the points of the area using the waypoint file
waypointsfile = 'area/spiral_concave.waypoints';
obstaclesfile = '';
[area, ~, home] = waypoints2meters(waypointsfile, obstaclesfile);
    
% initial configuration of the area
[area, lengthOfArea, width, height, ovx, ovy, altitude] = gopro_setup(area);

% computing the spiral path
figure(1);
plot(area(:,1), area(:,2), '-b');
hold on
axis equal
[waypointsESpiral, waypointsInfoESpiral] = ...
    spiral(area, lengthOfArea, width, height, ovx, ovy);

% creating the waypoint file for E-Spiral and E-CPP
file_name_spiral = 'waypoints/ESpiral_concave.txt' ;

home = [43.717714	10.432227   10];

% writing the waypoint files
[final_waypointsESpiral] = ...
    write_waypoints_file_espiral03(file_name_spiral, waypointsESpiral, ...
                                 waypointsInfoESpiral, home, altitude);

% plotting the final waypoints 
figure(1);
hold on;
plot(final_waypointsESpiral(:,1), final_waypointsESpiral(:,2));       