function plotOUTLnormTrackingError(log, der, pp)
% Plot of norm of trajectory tracking error of OUTER LOOP

% Total thrust
set(figure,'Color','white','WindowState','maximized')
plot(log.time,der.outer_loop.tracking_error_norm,'b-','LineWidth',2)
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Outer Loop Norm of trajectory tracking error [-]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

if strcmp(pp.folder_controller, 'FunnelTwoLayerMRAC')
    hold on
    % Plot funnel diameter
    plot(log.time, der.outer_loop.funnel.diameter, 'r--', 'LineWidth', 1.5)
    

    % Highlight regions where active_condition is true
    active_condition = log.outer_loop.funnel.active_condition; % Boolean vector
    time = log.time; % Time vector
    activated_intervals = findActivationIntervals(active_condition, time);

    % Define y-axis range for the patches
    yMin = min(min(der.outer_loop.tracking_error_norm), min(der.outer_loop.funnel.diameter));
    yMax = max(max(der.outer_loop.tracking_error_norm), max(der.outer_loop.funnel.diameter));

    % Add patches for activated intervals
    for i = 1:size(activated_intervals, 1)
        x_start = activated_intervals(i, 1);
        x_end = activated_intervals(i, 2);
        patch([x_start, x_end, x_end, x_start], ...
              [yMin, yMin, yMax, yMax], ...
              'g', 'FaceAlpha', 0.2, 'EdgeColor', 'none');
    end
    legend('Tracking error norm', 'Funnel diameter', 'Funnel active condition ON');
end

end

function intervals = findActivationIntervals(active_condition, time)
% This function identifies the start and end times where active_condition is true
intervals = [];
start_idx = [];

% Loop through boolean vector
for i = 1:length(active_condition)
    if active_condition(i) && isempty(start_idx)
        % Start of a new interval
        start_idx = i;
    elseif ~active_condition(i) && ~isempty(start_idx)
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
