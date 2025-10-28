function plotVirtualTransForceInputComp(log, der, pp)
% Plot virtual translational force input COMPARISON Baseline & Adaptive

% Choose the correct raw translational force input field
if isfield(log, 'mu_translational_raw_global')
  mu_raw = log.mu_translational_raw_global;
elseif isfield(log, 'mu_translational')
  mu_raw = log.mu_translational;
else
  error('Neither mu_translational_raw_global nor mu_translational found in log.');
end

set(figure,'Color','white','WindowState','maximized')

subplot(3,1,1)
plot(log.time, mu_raw.x, 'r-', 'LineWidth', 2)
hold on
plot(log.time, log.outer_loop.mu_PID_baseline.x, 'b-.', 'LineWidth', 2)
plot(log.time, log.outer_loop.mu_adaptive.x, 'k-', 'LineWidth', 1.2)
legend('$\mu_x(t)$', '$\mu_{\rm PID,x}(t)$', '$\mu_{\rm ad,x}(t)$', 'Interpreter', 'latex')
xlabel('$t$ [s]', 'Interpreter', 'latex', 'FontSize', pp.font_size)
ylabel({'Translational', 'Control input', 'X [N]'}, 'Interpreter', 'latex', 'FontSize', pp.font_size)
title(pp.folder_controller, 'Interpreter', 'latex', 'FontSize', pp.font_size_title)
axis tight
xlim([pp.x_lim_min, pp.x_lim_max])

subplot(3,1,2)
plot(log.time, mu_raw.y, 'r-', 'LineWidth', 2)
hold on
plot(log.time, log.outer_loop.mu_PID_baseline.y, 'b-.', 'LineWidth', 2)
plot(log.time, log.outer_loop.mu_adaptive.y, 'k-', 'LineWidth', 1.2)
legend('$\mu_y(t)$', '$\mu_{\rm PID,y}(t)$', '$\mu_{\rm ad,y}(t)$', 'Interpreter', 'latex')
xlabel('$t$ [s]', 'Interpreter', 'latex', 'FontSize', pp.font_size)
ylabel({'Translational', 'Control input', 'Y [N]'}, 'Interpreter', 'latex', 'FontSize', pp.font_size)
axis tight
xlim([pp.x_lim_min, pp.x_lim_max])

subplot(3,1,3)
plot(log.time, mu_raw.z, 'r-', 'LineWidth', 2)
hold on
plot(log.time, log.outer_loop.mu_PID_baseline.z, 'b-.', 'LineWidth', 2)
plot(log.time, log.outer_loop.mu_adaptive.z, 'k-', 'LineWidth', 1.2)
legend('$\mu_z(t)$', '$\mu_{\rm PID,z}(t)$', '$\mu_{\rm ad,z}(t)$', 'Interpreter', 'latex')
xlabel('$t$ [s]', 'Interpreter', 'latex', 'FontSize', pp.font_size)
ylabel({'Translational', 'Control input', 'Z [N]'}, 'Interpreter', 'latex', 'FontSize', pp.font_size)
axis tight
xlim([pp.x_lim_min, pp.x_lim_max])

end
