close all
clc
clear all
 
load('E_Model_full.mat');
addpath('utils');

% computing the points of the area using the waypoint file
%waypointsfile = 'area/spiral_polygon.waypoints';
waypointsfile = 'espiral_vs_ebf/area/area01.waypoints';
obstaclesfile = '';
[area, ~, home] = waypoints2meters(waypointsfile, obstaclesfile);
area(end,:) = area(1,:);

% initial configuration of the area
[area, lengthOfArea, width, height, ovx, ovy, altitude] = gopro_setup(area);

% computing the spiral path
figure(1);
plot(area(:,1), area(:,2), '-b');
hold on
[waypointsESpiral, waypointsInfoESpiral] = ...
    spiral(area, lengthOfArea, width, height, ovx, ovy);
axis equal
hold off