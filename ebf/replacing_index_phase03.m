function[waypointsInfoPhase03] = replacing_index_phase03(counter, waypointsInfoPhase03)
% the phase 03 is the first computed by the algorithm, so the information is
% placed in a different array, changed with the final counter after phase
% 01 and 02 and then added to the final of the original array with all phases
    j = 1;
    while j <= length(waypointsInfoPhase03)
        if(j > 1)
           if(previous ~= waypointsInfoPhase03(j))
               counter = counter + 1;
           end
           previous = waypointsInfoPhase03(j);      
           waypointsInfoPhase03(j) = counter;
        else
            previous = waypointsInfoPhase03(j);
            waypointsInfoPhase03(j) = counter;
        end
        j = j + 1;
    end
end