close all
clear all
clc

addpath('../utils');
addpath('../EnergyModel');
addpath('functions');
load('e_table_simple.mat');

% configuration parameters
angle_min = 60;
angle_max = 170;
dangle = 10;
distance =  70;
altitude = 20;
home_coords = [43.7186985 10.4326317 altitude];

% flight speed from 2m/s to 9m/s
speed = 2:1:9;
acceleration = 1;
time_at_const_speed = 5;

for j = 1 : size(speed,2)
    % straight distance of the path
    time = speed(j) / acceleration;
    distance_to_reach_speed = 0.5 * acceleration * time^2; 
    distance = distance_to_reach_speed + speed(j) * time_at_const_speed;
    distance = min(100, distance);

    % computing the path
    [waypoints, angles] = compute_path(angle_min, angle_max, dangle, distance);
     waypoints = [waypoints ; waypoints(1,:)];
    
    % computing the last angle -> from the last waypoint to home location 
    [last_angle] = compute_angle_between_3_points(waypoints(end-2,:), waypoints(end-1,:), waypoints(end,:));
     angles(end+1) = last_angle;
    
    % computing energy, time and distance of the path
    [energy_total, time_total, distance_total] = ...
        compute_energy_time_and_distance(e_total, E_rotate, ...
                                         waypoints, angles, altitude);

    % writing the waypoint file for each speed
    file_name = ['waypoints/angles_speed_' num2str(speed(j)) '.txt'];
    write_waypoints_file(file_name, waypoints, home_coords, altitude, speed(j));
    
    % plotting the path with all information
    figure; 
    plot(waypoints(:,1), waypoints(:,2));
    info = sprintf(['flight speed: %dm/s - straight distance: %.2fm \n' ...
                    'flight time: %.4fmin. - time at constant speed: %ds'], ...  
                    speed(j), distance, time_total/60, time_at_const_speed);
    title(info)
    axis equal;
end