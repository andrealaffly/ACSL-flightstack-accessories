function plotEulerAnglesSafeMech(log, der, pp)
% Plot Euler angles vs time, with highlighted areas where safety mechanism is activated

% Extract time and safety mechanism activation intervals
time = log.time;
safe_mech_activated = log.safety_mechanism.safe_mech_activated; % Boolean vector
tEllipticCone = log.safety_mechanism.tEllipticCone;
tPrime = log.safety_mechanism.tPrime;

% Find intervals where safety mechanism is activated
activated_intervals = findCustomActivationIntervals(safe_mech_activated, tEllipticCone, tPrime, time);


% disp(activated_intervals)

 % Nested function to add safety mechanism patches within a y-axis range
    function addSafetyMechanismPatches(yMin, yMax)
        for i = 1:size(activated_intervals, 1)
            x_start = activated_intervals(i, 1);
            x_end = activated_intervals(i, 2);
            % Create patch for the interval
            patch([x_start, x_end, x_end, x_start], ...
                  [yMin, yMin, yMax, yMax], ...
                  'g', 'FaceAlpha', 0.2, 'EdgeColor', 'none');
        end
    end

yMin.roll = min(min(rad2deg(log.euler_angles.roll)), ...
                min(rad2deg(log.desired_euler_angles.roll)));
yMax.roll = max(max(rad2deg(log.euler_angles.roll)), ...
                max(rad2deg(log.desired_euler_angles.roll)));

yMin.pitch = min(min(rad2deg(log.euler_angles.pitch)), ...
                min(rad2deg(log.desired_euler_angles.pitch)));
yMax.pitch = max(max(rad2deg(log.euler_angles.pitch)), ...
                max(rad2deg(log.desired_euler_angles.pitch)));

set(figure, 'Color', 'white', 'WindowState', 'maximized')
% Plot Roll angle
subplot(3,1,1)
plot(time, rad2deg(log.euler_angles.roll), 'r-', 'LineWidth', 2)
hold on
plot(time, rad2deg(log.desired_euler_angles.roll), 'b-.', 'LineWidth', 2)
addSafetyMechanismPatches(yMin.roll, yMax.roll)
legend({'$$\phi(t)$$','$$\phi_{\rm d}(t)$$', ...
    ['Safe' newline 'Mech' newline 'ON']}, 'Location', 'bestoutside')
% xlabel('$t$ [s]', 'interpreter', 'latex', 'fontsize', pp.font_size)
ylabel('Roll [deg]', 'interpreter', 'latex', 'fontsize', pp.font_size)
title(pp.folder_controller, 'interpreter', 'latex', 'fontsize', pp.font_size_title)
axis tight
xlim([pp.x_lim_min, pp.x_lim_max])
hold off

% Plot Pitch angle
subplot(3,1,2)
plot(time, rad2deg(log.euler_angles.pitch), 'r-', 'LineWidth', 2)
hold on
plot(time, rad2deg(log.desired_euler_angles.pitch), 'b-.', 'LineWidth', 2)
addSafetyMechanismPatches(yMin.pitch, yMax.pitch)
legend({'$$\theta(t)$$','$$\theta_{\rm d}(t)$$', ...
    ['Safe' newline 'Mech' newline 'ON']}, 'Location', 'bestoutside')
% xlabel('$t$ [s]', 'interpreter', 'latex', 'fontsize', pp.font_size)
ylabel('Pitch [deg]', 'interpreter', 'latex', 'fontsize', pp.font_size)
axis tight
xlim([pp.x_lim_min, pp.x_lim_max])
hold off

% Plot Yaw angle
subplot(3,1,3)
plot(time, rad2deg(log.euler_angles.yaw), 'r-', 'LineWidth', 2)
hold on
plot(time, rad2deg(der.user_defined_yaw), 'b-.', 'LineWidth', 2)
legend({'$$\psi(t)$$','$$\psi_{\rm d}(t)$$'}, 'Location', 'bestoutside')
xlabel('$t$ [s]', 'interpreter', 'latex', 'fontsize', pp.font_size)
ylabel('Yaw [deg]', 'interpreter', 'latex', 'fontsize', pp.font_size)
axis tight
xlim([pp.x_lim_min, pp.x_lim_max])
hold off

end


function intervals = findCustomActivationIntervals(safe_mech_activated, tEllipticCone, tPrime, time)
    % This function identifies the start and end times where safe_mech_activated is true
    % and tEllipticCone == tPrime, which means that the elliptic cone was
    % the most restrictive requirement
    intervals = [];
    start_idx = [];

    % Loop through boolean vector
    for i = 1:length(safe_mech_activated)
        if safe_mech_activated(i) && isempty(start_idx) && tEllipticCone(i) == tPrime(i)
            % Start of a new interval
            start_idx = i;
        elseif ~safe_mech_activated(i) && ~isempty(start_idx) && ~(tEllipticCone(i) == tPrime(i))
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