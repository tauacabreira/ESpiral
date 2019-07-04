function [final_waypoints] = path2wp_ecpp(waypoints, waypoints_info)
    
    final_waypoints = [];
    line = 1;
    
    for i = 1 : max(waypoints_info)
       
        index_ini = find(waypoints_info == line, 1, 'first');
        index_end = find(waypoints_info == line, 1, 'last');
            
        line = line + 1;
        
        % saving the waypoints
        final_waypoints(end+1,:) = [waypoints(index_ini,1),waypoints(index_ini,2)];    
        final_waypoints(end+1,:) = [waypoints(index_end,1),waypoints(index_end,2)];
    end
end
