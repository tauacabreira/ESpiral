close all
clc
clear all

addpath('functions', '../', '../ebf', 'utils');
load('E_Model_full.mat');

altitude = 10;

% creating the waypoint file for E-Spiral and E-CPP
file_name_ecpp = 'waypoints/ECPP_matlab.txt';
file_name_spiral = 'waypoints/ESpiral_matlab.txt';

for numVert = 6 : 6 % number of vertices
    %for i = 1 : 10
        
        % generating a concave/convex area
        [area] = generate_convex_concave_area(numVert);

        % initial configuration of the area
        [lengthOfArea, width, height, ovx, ovy] = initial_setup(area);

        % ==== E-SPIRAL PATH ==== %
        % printing the area
        figure();
        plot(area(:,1), area(:,2), 'bo-');
        title('E-Spiral')
        axis equal;

        % computing the waypoints
        hold on
        [waypointsESpiral, waypointsInfoESpiral] = ...
            spiral(area, lengthOfArea, width, height, ovx, ovy);
        hold off
        
        % removing the intermediate waypoints
        [final_waypointsESpiral] = path2wp_espiral(waypointsESpiral, waypointsInfoESpiral);
        
        % printing the final waypoints
        hold on;
        plot(final_waypointsESpiral(:,1), final_waypointsESpiral(:,2), 'ro-');
        hold off;
        
        % computing the angles between the wayoints
        [anglesESpiral] = compute_angles_of_waypoints(final_waypointsESpiral); 
        
        % computing the energy, time and distance of the paths
%         [energy_total_espiral, time_total_espiral, distance_total_espiral] = ...
%            compute_energy_time_and_distance(e_total, E_rotate, final_waypointsESpiral, ...
%                                             anglesESpiral, altitude);
        
        % ==== E-CPP PATH ==== %
        % printing the area
        figure()
        plot(area(:,1), area(:,2), 'bo-');
        title('E-CPP');
        axis equal;

        % computing the waypoints
        hold on
        [waypointsECPP, waypointsInfoECPP] = ...
            ecpp_v2(area, lengthOfArea, width, height, ovx, ovy);
        hold off;
        
        % removing the intermediate waypoints
        [final_waypointsECPP] = path2wp_ecpp(waypointsECPP, waypointsInfoECPP);
                                  
        % printing the final waypoints
        hold on;
        plot(final_waypointsECPP(:,1), final_waypointsECPP(:,2), 'ro-');
        hold off;
        
        % computing the angles between the wayoints
        [anglesECPP] = compute_angles_of_waypoints(final_waypointsECPP);
        
%         % computing the energy, time and distance of the paths
%         [energy_total_ecpp, time_total_ecpp, distance_total_ecpp] = ...
%            compute_energy_time_and_distance(e_total, E_rotate, final_waypointsECPP, ...
%                                             anglesECPP, altitude);
                                        
        % ==== DISPLAYING ALL THE INFO ==== %
%         disp( sprintf('E-CPP energy is %f', energy_total_ecpp));
%         disp( sprintf('E-Spiral energy is %f',energy_total_espiral));
% 
%         disp( sprintf('Time needed for E-CPP is %.2f minutes', time_total_ecpp/60));
%         disp( sprintf('Time needed for E-Spiral is %.2f minutes', time_total_espiral/60));
% 
%         disp( sprintf('Total distance for E-CPP is %.2f meters', distance_total_ecpp));
%         disp( sprintf('Total distance for E-Spiral is %.2f meters', distance_total_espiral));
    %end
end