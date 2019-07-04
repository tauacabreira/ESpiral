function[minSpd] = finding_minimum_speed(entranceSpeed, angle)
    % calculating the minimum speed given an entrance speed and a turning
    % angle using the dataBase in the MATLAB file
    dataBase = load('angles_and_speeds.mat');
    
    column = find(dataBase.all_minimum_speeds(1,:) == entranceSpeed);
    line = find(dataBase.all_minimum_speeds(:,1) == angle);
    
    if(isempty(line))
        minSpd = 'Angle not found';
    elseif(isempty(column))
        minSpd = 'Speed not found';
    else    
        minSpd = dataBase.all_minimum_speeds(line,column(1));
    end    
end