
close all
clear all
clc

addpath('..')
addpath('../EnergyModel')
load('D:\Users\Dropbox\Dropbox\Workspace\matlab\CPP_paper\Energy_Model.mat')
load('D:\Users\Dropbox\Dropbox\Workspace\matlab\CPP_paper\E_table.mat')


angle_min = 60;
angle_max = 170;
dangle = 10;
distance =  60;


p = compute_path( angle_min,angle_max,dangle,distance )


figure(2)
hold on

for i = 1 : size(p,1) -1
    
    plot( [p(i,1) p(i+1,1)],[p(i,2) p(i+1,2)],'k-')
end
hold off
axis equal

%%
v_max = 6; 
altitude = 20;
angle = 0;
file_name = 'angles_speed_2.txt' ;

%home_coords =[43.719175	10.432822];

home_coords = [43.7186985, 10.4326317];
%home_coords10 = [43.7188497, 10.4326907];
  
 
  [ Energy_total,~,Time_total ] = compute_energy_path(E_model,p,(1:1:size(p,1)),v_max,altitude)

  Time_total/60

write_waypoints_file( file_name,p,home_coords,altitude,v_max,angle );


