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

% --- Select adaptive signals ---
use_split_adaptive = isfield(log, 'mu_adaptive_ebci_translational') && ...
                     isfield(log, 'mu_adaptive_mrac_translational');

if use_split_adaptive
  mu_ad_ebci = log.mu_adaptive_ebci_translational;
  mu_ad_mrac = log.mu_adaptive_mrac_translational;
else
  mu_ad = log.outer_loop.mu_adaptive;
end

set(figure,'Color','white','WindowState','maximized')

% ---------------- X ----------------
subplot(3,1,1)
plot(log.time, mu_raw.x, 'r-', 'LineWidth', 2)
hold on
plot(log.time, log.outer_loop.mu_PID_baseline.x, 'b-.', 'LineWidth', 2)

if use_split_adaptive
  plot(log.time, mu_ad_ebci.x, 'k-', 'LineWidth', 1.2)
  plot(log.time, mu_ad_mrac.x, 'g--', 'LineWidth', 1.2)
  legend('$\mu_x(t)$', '$\mu_{\rm PID,x}(t)$', ...
         '$\mu_{\rm ad,EBCI,x}(t)$', '$\mu_{\rm ad,MRAC,x}(t)$', ...
         'Interpreter', 'latex')
else
  plot(log.time, mu_ad.x, 'k-', 'LineWidth', 1.2)
  legend('$\mu_x(t)$', '$\mu_{\rm PID,x}(t)$', '$\mu_{\rm ad,x}(t)$', ...
         'Interpreter', 'latex')
end

xlabel('$t$ [s]', 'Interpreter', 'latex', 'FontSize', pp.font_size)
ylabel({'Translational', 'Control input', 'X [N]'}, 'Interpreter', 'latex', 'FontSize', pp.font_size)
title(pp.folder_controller, 'Interpreter', 'latex', 'FontSize', pp.font_size_title)
axis tight
xlim([pp.x_lim_min, pp.x_lim_max])

% ---------------- Y ----------------
subplot(3,1,2)
plot(log.time, mu_raw.y, 'r-', 'LineWidth', 2)
hold on
plot(log.time, log.outer_loop.mu_PID_baseline.y, 'b-.', 'LineWidth', 2)

if use_split_adaptive
  plot(log.time, mu_ad_ebci.y, 'k-', 'LineWidth', 1.2)
  plot(log.time, mu_ad_mrac.y, 'g--', 'LineWidth', 1.2)
  legend('$\mu_y(t)$', '$\mu_{\rm PID,y}(t)$', ...
         '$\mu_{\rm ad,EBCI,y}(t)$', '$\mu_{\rm ad,MRAC,y}(t)$', ...
         'Interpreter', 'latex')
else
  plot(log.time, mu_ad.y, 'k-', 'LineWidth', 1.2)
  legend('$\mu_y(t)$', '$\mu_{\rm PID,y}(t)$', '$\mu_{\rm ad,y}(t)$', ...
         'Interpreter', 'latex')
end

xlabel('$t$ [s]', 'Interpreter', 'latex', 'FontSize', pp.font_size)
ylabel({'Translational', 'Control input', 'Y [N]'}, 'Interpreter', 'latex', 'FontSize', pp.font_size)
axis tight
xlim([pp.x_lim_min, pp.x_lim_max])

% ---------------- Z ----------------
subplot(3,1,3)
plot(log.time, mu_raw.z, 'r-', 'LineWidth', 2)
hold on
plot(log.time, log.outer_loop.mu_PID_baseline.z, 'b-.', 'LineWidth', 2)

if use_split_adaptive
  plot(log.time, mu_ad_ebci.z, 'k-', 'LineWidth', 1.2)
  plot(log.time, mu_ad_mrac.z, 'g--', 'LineWidth', 1.2)
  legend('$\mu_z(t)$', '$\mu_{\rm PID,z}(t)$', ...
         '$\mu_{\rm ad,EBCI,z}(t)$', '$\mu_{\rm ad,MRAC,z}(t)$', ...
         'Interpreter', 'latex')
else
  plot(log.time, mu_ad.z, 'k-', 'LineWidth', 1.2)
  legend('$\mu_z(t)$', '$\mu_{\rm PID,z}(t)$', '$\mu_{\rm ad,z}(t)$', ...
         'Interpreter', 'latex')
end

xlabel('$t$ [s]', 'Interpreter', 'latex', 'FontSize', pp.font_size)
ylabel({'Translational', 'Control input', 'Z [N]'}, 'Interpreter', 'latex', 'FontSize', pp.font_size)
axis tight
xlim([pp.x_lim_min, pp.x_lim_max])

end