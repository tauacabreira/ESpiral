function [final_waypoints] = path2wp_espiral(waypoints, waypoints_info)
    
    final_waypoints = [];
    line = 1;
    
    for i = 1 : max(waypoints_info) - 1
        if(i == 1)
            index_ini = find(waypoints_info == line, 1, 'first');
        else
            index_ini = index_end;
        end
        
        if(i ~= max(waypoints_info))
            index_mid = find(waypoints_info == line, 1, 'last');
            index_end = find(waypoints_info == line+1, 1, 'first');
            line = line + 1;
        
            % final waypoint of the line -> the midpoint 
            point(1) = (waypoints(index_mid,1) + waypoints(index_end,1)) / 2;
            point(2) = (waypoints(index_mid,2) + waypoints(index_end,2)) / 2;
        else
            index_end = find(waypoints_info == line, 1, 'last');
            point = waypoints(index_end,:);
        end
        
        if i == 1
            % saving the waypoints
            final_waypoints(end+1,:) = [waypoints(index_ini,1),waypoints(index_ini,2)];
        end
        
        % saving the waypoints
        final_waypoints(end+1,:) = point;
    end
end
