addpath('geometriclibrary')
clc
close all
clear

rng(12,'twister');
rand(4,1);

[~, ~, width, height, ovx, ovy] = initial_setup();
area = generatePolygon(0,0,200,0.1,0,7);

% if one of the sides is too small than we can omit that and simplify the polygon. 
area = simplifyPolygon(area,height);
lengthOfArea = size(area,1) - 1;

figure()
plot(area(:,1), area(:,2), '-b')
axis equal
hold on
spiral(area, lengthOfArea, width, height, ovx, ovy);
axis equal
hold off