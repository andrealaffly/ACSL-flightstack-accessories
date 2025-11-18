function [t_adjusted,segment] = PolyTimeAdjusted(time_waypoint_vector,t)
%POLYTIMEADJUSTED Adjusts the time to be fed to the various polynomials
%   Detailed explanation goes here

num_waypoints = length(time_waypoint_vector);
segment = 0;
% disp('START')
for i=1:num_waypoints-1
    % disp(['i: ', num2str(i)])
    % disp(['t: ', num2str(t)])
    if (t >= time_waypoint_vector(i) & t <= time_waypoint_vector(i+1)) % >= <
        segment = i;
        % disp(['segment: ', num2str(segment)])
        % disp(['time_waypoint_vector(segment): ', num2str(time_waypoint_vector(segment))])
        t_adjusted = t - time_waypoint_vector(segment);
        % disp(['t_adjusted: ', num2str(t_adjusted)])
        % break
        return
    end
end

end

