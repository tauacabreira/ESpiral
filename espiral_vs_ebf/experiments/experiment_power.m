close all;
clc;
axis equal;

% just loading a file to recognize the label's command
load('logs/speed66.mat');

% function to access the numerical indexes of logs
get_index = @(x,value) find(not(cellfun('isempty', strfind(x, value))));

% 12 angles from 60º to 170º
angles = [60 120 70 130 80 140 90 150 100 160 110 170];

% GPS_label
igps_ln = get_index(GPS_label,'LineNo'); % index = 1
it = get_index(GPS_label,'TimeMS');      % index = 3
is = get_index(GPS_label,'Spd');         % index = 11    

% CMD_label is for the waypoints. 
% CNum is the total number of waypoints 
% CId is the code of operation (takeoff, change speed, navigate to mission)
icmd_ln =  get_index(CMD_label,'LineNo'); % index = 1
icmd_cid = get_index(CMD_label, 'CId');   % index = 5 
icmd_prm1 = get_index(CMD_label, 'Prm1'); % index = 6

% CURR_label for Volt and Curr
icurr_ln = get_index(CURR_label, 'LineNo'); % index = 1
icurr_t = get_index(CURR_label, 'TimeMS');  % index = 2
iv = get_index(CURR_label, 'Volt');         % index = 5 
ic = get_index(CURR_label, 'Curr');         % index = 6
ic = ic(1);

% log files in matlab format
matlab_files = {'logs/speed66.mat', 'logs/speed772.mat',... 
                'logs/speed852.mat', 'logs/speed943.mat'};

for k = 1 : length(matlab_files)
    % loading the log files
    load(matlab_files{k});
    
    % indexes where the speed is changed
    % they'll be used the define the initial and final waypoints
    ichange_spd = find(CMD(:,icmd_cid) == 178);

    % array with different speeds
    spd = CMD(ichange_spd, icmd_prm1);
    
    % how many times the speed changes in the file?
    for j = 1 : length(spd)
        % the path of the last speed has -1 waypoint
        if(j ~= length(spd))
            sub = 0;
        else
            sub = 1;
        end 
        
        %%%%%%%%%%%%%%%%% SPEED X TIME (for each angle) %%%%%%%%%%%%%%%
        figure();
        ifig = 1;
        i_angles = 1;
        for i = ichange_spd(j) + 3 : ichange_spd(j) + 14 - sub
            % finding the line numbers of GPS closest to the line number of waypoints
            [i_ini, i_ini] = min(abs(GPS(:,igps_ln) - CMD(i,icmd_ln)));
            [i_end, i_end] = min(abs(GPS(:,igps_ln) - CMD(i+1,icmd_ln)));
            
            % plotting the speed over the time(ms)
            subplot(4,3,ifig);
            ifig = ifig + 1;
            plot(GPS(i_ini:i_end,it) - GPS(i_ini,it), GPS(i_ini:i_end,is),'r');
            title(['SPEED: ' num2str(spd(j)) 'm/s and ANGLE: ' ...
                             num2str(angles(1,i_angles)) 'º']);
            xlabel('Time(ms)');
            ylabel('Speed'); 
            
            i_angles = i_angles + 1;
        end
        
        %%%%%%%%%%%%%%%%% POWER X TIME (for each angle) %%%%%%%%%%%%%%%
        figure();
        ifig = 1;
        i_angles = 1;
        for i = ichange_spd(j) + 3 : ichange_spd(j) + 14 - sub
            % finding the line numbers of CURR closest to the line number of waypoints
            [i_ini, i_ini] = min(abs(CURR(:,icurr_ln) - CMD(i,icmd_ln)));
            [i_end, i_end] = min(abs(CURR(:,icurr_ln) - CMD(i+1,icmd_ln)));
                         
            % creating an array of power multiplying curr * volt
            power = zeros(i_end-i_ini,1);
            index = 1;
            for n = i_ini : i_end
               power(index) = CURR(n,iv)/100 * CURR(n,ic)/100;
               index = index + 1;
            end
            
            % plotting the power over the time(ms)
            subplot(4,3,ifig);
            ifig = ifig + 1;
            plot(CURR(i_ini:i_end,icurr_t) - CURR(i_ini,icurr_t), power,'m');
            title(['SPEED: ' num2str(spd(j)) 'm/s and ANGLE: ' ...
                             num2str(angles(1,i_angles)) 'º']);
            xlabel('Time(ms)');
            ylabel('Power'); 
            
            i_angles = i_angles + 1;
        end
    end % for different_speeds
end % for matlab_files