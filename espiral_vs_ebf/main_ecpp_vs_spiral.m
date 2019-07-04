close all;
clc
 
addpath('../ebf', '../energymodel', '../', '../utils', 'functions');
    
load('E_Model_full.mat');

% computing the points of the area using the waypoint file
% you can select one of the areas below
waypointsfile = 'area/spiral_polygon.waypoints';
%waypointsfile = 'area/rectangle.waypoints';
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

% computing the energy-aware back-and-forth path 
figure(2)
plot(area(:,1), area(:,2), '-b');
hold on
axis equal
[waypointsECPP, waypointsInfoECPP] = ...
    ecpp_v2(area, lengthOfArea, width, height, ovx, ovy);

% creating the waypoint file for E-Spiral and E-CPP
%file_name_ecpp = 'waypoints/ECPP_polygon.txt' ;
%file_name_spiral = 'waypoints/ESpiral_polygon.txt' ;
file_name_ecpp = 'waypoints/ECPP_rectangle.txt' ;
file_name_spiral = 'waypoints/ESpiral_rectangle.txt' ;

home = [43.717714	10.432227   10];

% writing the waypoint files
[final_waypointsESpiral] = ...
    write_waypoints_file_espiral03(file_name_spiral, waypointsESpiral, ...
                                 waypointsInfoESpiral, home, altitude);

[final_waypointsECPP] = ...
    write_waypoints_file_ecpp03(file_name_ecpp, waypointsECPP, ...
                              waypointsInfoECPP, home, altitude);     

% computing the angles of each path and plotting the waypoints 
figure(1);
hold on;
plot(final_waypointsESpiral(:,1), final_waypointsESpiral(:,2));
[anglesESpiral] = compute_angles_of_waypoints(final_waypointsESpiral);                          

figure(2);
hold on;
plot(final_waypointsECPP(:,1), final_waypointsECPP(:,2));
[anglesECPP] = compute_angles_of_waypoints(final_waypointsECPP);
 
% computing the energy, time and distance of the paths
[energy_total_espiral, time_total_espiral, distance_total_espiral] = ...
   compute_energy_time_and_distance(e_total, E_rotate, final_waypointsESpiral, ...
                                    anglesESpiral, altitude);                             
                                          
[energy_total_ecpp, time_total_ecpp, distance_total_ecpp] = ...
   compute_energy_time_and_distance(e_total, E_rotate, final_waypointsECPP, ...
                                    anglesECPP, altitude);
                                          
disp( sprintf('E-CPP energy is %f', energy_total_ecpp));
disp( sprintf('E-Spiral energy is %f',energy_total_espiral));

disp( sprintf('Time needed for E-CPP is %.2f minutes', time_total_ecpp/60));
disp( sprintf('Time needed for E-Spiral is %.2f minutes', time_total_espiral/60));

disp( sprintf('Total distance for E-CPP is %.2f meters', distance_total_ecpp));
disp( sprintf('Total distance for E-Spiral is %.2f meters', distance_total_espiral));