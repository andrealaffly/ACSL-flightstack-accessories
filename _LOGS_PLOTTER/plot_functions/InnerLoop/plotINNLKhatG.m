function plotINNLKhatG(log, der, pp, gains)
% Plot INENR LOOP Adaptive Gain K_hat_g

set(figure,'Color','white','WindowState','maximized')
plot(log.time,log.inner_loop.K_hat_g.ind00,'-','LineWidth',1.2)
hold on
plot(log.time,log.inner_loop.K_hat_g.ind10,'-','LineWidth',1.2)
plot(log.time,log.inner_loop.K_hat_g.ind20,'-','LineWidth',1.2)

plot(log.time,log.inner_loop.K_hat_g.ind01,'--','LineWidth',1.2)
plot(log.time,log.inner_loop.K_hat_g.ind11,'--','LineWidth',1.2)
plot(log.time,log.inner_loop.K_hat_g.ind21,'--','LineWidth',1.2)

plot(log.time,log.inner_loop.K_hat_g.ind02,'-.','LineWidth',1.2)
plot(log.time,log.inner_loop.K_hat_g.ind12,'-.','LineWidth',1.2)
plot(log.time,log.inner_loop.K_hat_g.ind22,'-.','LineWidth',1.2)

% Check if all elements in the ellipsoid vector are the same
if all(gains.ADAPTIVE.S_diagonal_g_rotational == gains.ADAPTIVE.S_diagonal_g_rotational(1))
    outer_bound = gains.ADAPTIVE.S_diagonal_g_rotational(1); % Use the scalar value
else
    error('Values in the Projection operator ellipsoid vector are not the same!');
end

% Compute inner bound
inner_bound = outer_bound * gains.ADAPTIVE.alpha_g_rotational;

% Add horizontal lines for inner and outer bounds
yline(outer_bound, 'r-', 'LineWidth', 2.0);    % Outer bound positive
yline(-outer_bound, 'r-', 'LineWidth', 2.0);   % Outer bound negative
yline(inner_bound, 'k--', 'LineWidth', 2.0);    % Inner bound positive
yline(-inner_bound, 'k--', 'LineWidth', 2.0);   % Inner bound negative

% Add semi-transparent vertical rectangles where projection operator is activated
proj_op_activated = log.inner_loop.proj_op_activated_K_hat_g;  % Boolean vector
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
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Inner loop Adaptive gain $\hat{K}_g$ [-]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

end

