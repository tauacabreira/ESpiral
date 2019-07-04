function write_waypoints_file(file_name, waypoints, home_coords, altitude, speed)
    
    data = load('e_table_simple.mat');
    fid = fopen(file_name,'wt'); 
    index_txt = 2;
    
    fprintf(fid,'QGC WPL 110\n');
    
    % home coordinates
    fprintf(fid,'0\t1\t0\t16\t0\t0\t0\t0\t%.6f\t%.6f\t%.6f\t1\n',home_coords(1),home_coords(2),home_coords(3));
    
    % takeoff: code 22
    fprintf(fid,'1\t0\t0\t22\t0.000000\t0.000000\t0.000000\t0.000000\t%.6f\t%.6f\t%.6f\t1\n',home_coords(1), home_coords(2), altitude);
    
    % change speed: code 178
    fprintf(fid, '%d\t0\t3\t178\t%.6f\t%.6f\t0.000000\t0.000000\t0.000000\t0.000000\t0.000000\t1\n', index_txt, speed, speed);
    index_txt = index_txt + 1;
    
    % computing waypoints 
    for i = 1 : size(waypoints,1);
        % move to waypoint: code 16
        coordinate = gpsplusdeltaxy(home_coords(1), home_coords(2), waypoints(i,1), waypoints(i,2));
        fprintf(fid, '%d\t0\t3\t16\t0.000000\t0.000000\t0.000000\t0.000000\t%.6f\t%.6f\t%.6f\t1\n', index_txt, coordinate(1), coordinate(2), altitude);
        index_txt = index_txt + 1;
    end
      
    % return-to-launch: code 20
    fprintf(fid, '%d\t0\t3\t20\t0.000000\t0.000000\t0.000000\t0.000000\t0.000000\t0.000000\t0.000000\t1\n', index_txt);
    
    fclose(fid);
end
