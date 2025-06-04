function intervals = findProjectionOperatorActivationIntervals(proj_op_activated, time)
    % This function identifies the start and end times where proj_op_activated is true
    intervals = [];
    start_idx = [];

    % Loop through boolean vector
    for i = 1:length(proj_op_activated)
        if proj_op_activated(i) && isempty(start_idx)
            % Start of a new interval
            start_idx = i;
        elseif ~proj_op_activated(i) && ~isempty(start_idx)
            % End of the interval
            intervals = [intervals; time(start_idx), time(i)]; %#ok<AGROW>
            start_idx = [];
        end
    end

    % If the last interval reaches the end of the array
    if ~isempty(start_idx)
        intervals = [intervals; time(start_idx), time(end)]; %#ok<AGROW>
    end
end