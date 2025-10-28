function plotINNLKhatX(log, der, pp, gains)
% Plot INENR LOOP Adaptive Gain K_hat_x

set(figure,'Color','white','WindowState','maximized')
plot(log.time,log.inner_loop.K_hat_x.ind00,'-','LineWidth',1.2)
hold on
plot(log.time,log.inner_loop.K_hat_x.ind10,'-','LineWidth',1.2)
plot(log.time,log.inner_loop.K_hat_x.ind20,'-','LineWidth',1.2)

plot(log.time,log.inner_loop.K_hat_x.ind01,'--','LineWidth',1.2)
plot(log.time,log.inner_loop.K_hat_x.ind11,'--','LineWidth',1.2)
plot(log.time,log.inner_loop.K_hat_x.ind21,'--','LineWidth',1.2)

plot(log.time,log.inner_loop.K_hat_x.ind02,'-.','LineWidth',1.2)
plot(log.time,log.inner_loop.K_hat_x.ind12,'-.','LineWidth',1.2)
plot(log.time,log.inner_loop.K_hat_x.ind22,'-.','LineWidth',1.2)

% Determine outer_bound and inner_bound based on available gain structure
if isfield(gains, 'ADAPTIVE')
    S_diag = gains.ADAPTIVE.S_diagonal_x_rotational;
    alpha = gains.ADAPTIVE.alpha_x_rotational;
elseif isfield(gains, 'S_diagonal_x_rot')
    S_diag = gains.S_diagonal_x_rot;
    alpha = gains.alpha_x_rot;
else
    error('Unknown gain structure: Cannot find S_diagonal_x_rotational or S_diagonal_x_rot.');
end

% Check if all elements in the ellipsoid vector are the same
if all(S_diag == S_diag(1))
    outer_bound = S_diag(1); % Use the scalar value
else
    error('Values in the Projection operator ellipsoid vector are not the same!');
end

% Compute inner bound
inner_bound = outer_bound * alpha;


% Add horizontal lines for inner and outer bounds
yline(outer_bound, 'r-', 'LineWidth', 2.0);    % Outer bound positive
yline(-outer_bound, 'r-', 'LineWidth', 2.0);   % Outer bound negative
yline(inner_bound, 'k--', 'LineWidth', 2.0);    % Inner bound positive
yline(-inner_bound, 'k--', 'LineWidth', 2.0);   % Inner bound negative

% Add semi-transparent vertical rectangles where projection operator is activated
proj_op_activated = log.inner_loop.proj_op_activated_K_hat_x;  % Boolean vector
time = log.time;

% Find intervals where projection operator is activated
activated_intervals = findProjectionOperatorActivationIntervals(proj_op_activated, time);

% Debugging: Print the intervals
% disp('Activated intervals:')
% disp(activated_intervals)

% Plot the patches for each interval
for i = 1:size(activated_intervals, 1)
    x_start = activated_intervals(i, 1);
    x_end = activated_intervals(i, 2);
    % Create patch for the interval
    patch([x_start, x_end, x_end, x_start], ...
      [-outer_bound, -outer_bound, outer_bound, outer_bound], ...
      'g', 'FaceAlpha', 0.2, 'EdgeColor', 'none');
end

legend({'00', '10', '20', ...
        '01', '11', '21', ...
        '02', '12', '22', ...
         sprintf('Proj. Op. Outer Bound = %.2f', outer_bound), '', ...
         sprintf('Proj. Op. Inner Bound = %.2f', inner_bound), '', ...
         'Proj. Op. Activated'}, ...
         'Location', 'bestoutside');
ylabel('Inner loop Adaptive gain $\hat{K}_x$ [-]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

end

