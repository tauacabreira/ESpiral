close all;
clc;
axis equal;

% just loading a file to recognize the label's command
load('logs/speed66.mat');

% function to access the numerical indexes of logs
get_index = @(x,value) find(not(cellfun('isempty', strfind(x, value))));

% 12 angles from 60º to 170º
angles = [60 120 70 130 80 140 90 150 100 160 110 170];
smallest_speeds = zeros(length(angles),11);
smallest_speeds(:,1) = angles';

% GPS_label
igps_ln = get_index(GPS_label,'LineNo'); % index = 1
ix = get_index(GPS_label,'Lat');         % index = 7
iy = get_index(GPS_label,'Lng');         % index = 8
is = get_index(GPS_label,'Spd');         % index = 11    

% CMD_label is for the waypoints. 
% CNum is the total number of waypoints 
% CId is the code of operation (takeoff, change speed, navigate to mission)
icmd_ln =  get_index(CMD_label,'LineNo'); % index = 1
icmd_cnum = get_index(CMD_label,'CNum');  % index = 4
icmd_cid = get_index(CMD_label, 'CId');   % index = 5 
icmd_prm1 = get_index(CMD_label, 'Prm1'); % index = 6
icmd_lat = get_index(CMD_label, 'Lat');   % index = 10
icmd_lng = get_index(CMD_label, 'Lng');   % index = 11  

% CURR_label for Volt and Curr
icurr_ln = get_index(CURR_label, 'LineNo'); % index = 1
iv = get_index(CURR_label, 'Volt');         % index = 5 
ic = get_index(CURR_label, 'Curr');         % index = 6
ic = ic(1);

% log files in matlab format
matlab_files = {'logs/speed66.mat', 'logs/speed772.mat',... 
               'logs/speed852.mat', 'logs/speed943.mat'};

% the array with all the minimum speeds will be saved in a external file            
all_minimum_speeds = [];

% array with 10 smallest speeds of every angle and every speed
all_smallest_speeds = [];

% array with all the different speeds
all_legend_speeds = [];
page = 1;

for k = 1 : length(matlab_files)
    % loading the log files
    load(matlab_files{k});
    figure;
    
    % ===== plotting the path and the waypoints ===== %
    subplot(2,2,1);
    plot(GPS(1:end,ix),GPS(1:end,iy),'b--');
    hold on

    for i = 1 : length(CMD(:,icmd_cnum))
       if(CMD(i,icmd_lat) ~= 0 || CMD(i,icmd_lng) ~= 0)
           plot(CMD(i,icmd_lat), CMD(i,icmd_lng), 'or');
       end 
    end
    
    % ===== plotting the speed and waypoints(blue lines) ===== %
    subplot(2,2,[3 4]);
    plot(GPS(:,igps_ln),GPS(:,is),'r');
    hold on
    plot([CMD(:,icmd_ln) CMD(:,icmd_ln)], [0 8],'-b');
    title(['File: ' matlab_files{k}]);
    xlabel('Line nº (waypoints)')
    ylabel('Speed');
    
    % indexes where the speed is changed
    % they'll be used the define the initial and final waypoints
    ichange_spd = find(CMD(:,icmd_cid) == 178);

    % array with different speeds
    spd = CMD(ichange_spd, icmd_prm1);
    
    % number of plots per file
    h = zeros(length(spd),1);
    
    subplot(2,2,2);
    % how many times the speed changes in the file?
    for j = 1 : length(spd)
        % the path of the last speed has -1 waypoint (the central point)
        if(j ~= length(spd))
            sub = 0;
        else
            sub = 1;
        end 
        i_angles = 1;
        
        for i = ichange_spd(j) + 3 : ichange_spd(j) + 14 - sub
            % finding the line numbers of GPS closest 
            % to the line number of waypoints
            [i_ini, i_ini] = min(abs(GPS(:,igps_ln) - CMD(i,icmd_ln)));
            [i_end, i_end] = min(abs(GPS(:,igps_ln) - CMD(i+1,icmd_ln)));
            
            % sorting the 10 minimum speed values between two waypoints
            ordered_values = sort(GPS(i_ini:i_end,is));
            smallest_speeds(i_angles,2:end) = ordered_values(1:10);
            
            % computing the median based on 10 values
            angles(j+1,i_angles) = median(smallest_speeds(i_angles,2:end));
            i_angles = i_angles + 1;
        end
        % sorting the angles in ascending order 
        % with the correspondent minimum speeds
        ordered_angles = sortrows(angles');
        ordered_smallest_speeds = sortrows(smallest_speeds,1);

        % plotting the minimum speed(lines) over the angles and 
        % the 10 smallest speeds (dots)  
        h(j) = plot(ordered_angles(:,1), ordered_angles(:,j+1), '-');
        hold on;
        plot(ordered_angles(:,1), ordered_smallest_speeds(:,2:end), '.');
        
        % aditional info
        xlabel('Angles (deg)');   
        ylabel('Minimum Speed (m/s)');
        set(gca, 'XTick', ordered_angles(:,1));
        
        % saving all the minimum speeds and angles into a single matrix
        if (isempty(all_minimum_speeds))
            all_minimum_speeds(:,1) = [0; ordered_angles(:,1)];
            index = 2;
        else    
            index = length(all_minimum_speeds(1,:)) + 1;
        end
        all_minimum_speeds(:,index) = [spd(j); ordered_angles(:,j+1)];
        
        % saving the 10 smallest minimum speeds of every angle/entrance speed 
        % into a different page 
        all_smallest_speeds(:,:, page) = ordered_smallest_speeds;
        
        % saving all the different speeds - will be used as legend of the
        % full plot
        all_legend_speeds(page) = spd(j);
        page = page + 1;
        
    end % for different_speeds
    
    % legend of the plot
    legend(h, strcat(num2str(spd),' m/s'), 'Location', 'northwest');
    
    % saving .mat file with all the data
    save 'angles_and_speeds.mat' all_minimum_speeds;
end % for matlab_files

% ====== FULL PLOT! ====== %
figure;
h = zeros(length(all_legend_speeds),1);

% plotting all the minimum speeds over the angles (lines) and 
% all the smallest speeds (dots)
for k = 1 : length(all_legend_speeds)
    h(k) = plot(ordered_angles(:,1), all_minimum_speeds(2:end,k+1), '-');
    hold on;
    plot(all_smallest_speeds(:,1,1), all_smallest_speeds(:,2:end,k), '.');
end

% aditional info
xlabel('Angles (deg)');   
ylabel('Minimum Speed (m/s)');
set(gca, 'XTick', ordered_angles(:,1));

% sorting and positioning the legend of the plot
% -2: second column (speed) in descend order
g = sortrows([h all_legend_speeds'], -2);
legend(g(:,1), strcat(num2str(g(:,2)), ' m/s'), 'Location', 'northwest');

% calculating the minimum speed given an entrance speed and a turning
% angle using the dataBase in the MATLAB file
finding_minimum_speed(7,60);

% all data
all_minimum_speeds;