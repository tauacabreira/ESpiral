load('waypoints.mat');

figure(1);
axis equal
plot(waypointsBF_poligono(:,1), waypointsBF_poligono(:,2));

figure(2);
axis equal
plot(waypointsSpiral_poligono(:,1), waypointsSpiral_poligono(:,2));

figure(3);
plot(waypointsBF_retangulo(:,1), waypointsBF_retangulo(:,2));

figure(4);
plot(waypointsSpiral_retangulo(:,1), waypointsSpiral_retangulo(:,2));