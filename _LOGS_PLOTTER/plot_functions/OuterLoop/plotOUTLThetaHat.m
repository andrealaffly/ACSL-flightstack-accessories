function plotOUTLThetaHat(log, der, pp, gains)
% Plot OUTER LOOP Adaptive Gain Theta_hat

set(figure,'Color','white','WindowState','maximized')
plot(log.time,log.outer_loop.Theta_hat.ind00,'-','LineWidth',1.2)
hold on
plot(log.time,log.outer_loop.Theta_hat.ind10,'-','LineWidth',1.2)
plot(log.time,log.outer_loop.Theta_hat.ind20,'-','LineWidth',1.2)
plot(log.time,log.outer_loop.Theta_hat.ind30,'-','LineWidth',1.2)
plot(log.time,log.outer_loop.Theta_hat.ind40,'-','LineWidth',1.2)
plot(log.time,log.outer_loop.Theta_hat.ind50,'-','LineWidth',1.2)

plot(log.time,log.outer_loop.Theta_hat.ind01,'--','LineWidth',1.2)
plot(log.time,log.outer_loop.Theta_hat.ind11,'--','LineWidth',1.2)
plot(log.time,log.outer_loop.Theta_hat.ind21,'--','LineWidth',1.2)
plot(log.time,log.outer_loop.Theta_hat.ind31,'--','LineWidth',1.2)
plot(log.time,log.outer_loop.Theta_hat.ind41,'--','LineWidth',1.2)
plot(log.time,log.outer_loop.Theta_hat.ind51,'--','LineWidth',1.2)

plot(log.time,log.outer_loop.Theta_hat.ind02,'-.','LineWidth',1.2)
plot(log.time,log.outer_loop.Theta_hat.ind12,'-.','LineWidth',1.2)
plot(log.time,log.outer_loop.Theta_hat.ind22,'-.','LineWidth',1.2)
plot(log.time,log.outer_loop.Theta_hat.ind32,'-.','LineWidth',1.2)
plot(log.time,log.outer_loop.Theta_hat.ind42,'-.','LineWidth',1.2)
plot(log.time,log.outer_loop.Theta_hat.ind52,'-.','LineWidth',1.2)

% Determine outer_bound and inner_bound based on available gain structure
if isfield(gains, 'ADAPTIVE')
    S_diag = gains.ADAPTIVE.S_diagonal_Theta_translational;
    alpha = gains.ADAPTIVE.alpha_Theta_translational;
elseif isfield(gains, 'S_diagonal_Theta_tran')
    S_diag = gains.S_diagonal_Theta_tran;
    alpha = gains.alpha_Theta_tran;
else
    error('Unknown gain structure: Cannot find S_diagonal_Theta_translational or S_diagonal_Theta_tran.');
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
proj_op_activated = log.outer_loop.proj_op_activated_Theta_hat;  % Boolean vector
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


legend({'00', '10', '20', '30', '40', '50', ...
        '01', '11', '21', '31', '41', '51', ...
        '02', '12', '22', '32', '42', '52', ...
         sprintf('Proj. Op. Outer Bound = %.2f', outer_bound), '', ...
         sprintf('Proj. Op. Inner Bound = %.2f', inner_bound), '', ...
         'Proj. Op. Activated'}, ...
         'Location', 'bestoutside');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Outer loop Adaptive gain $\hat{\Theta}$ [-]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

end

