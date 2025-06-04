function plotOUTLfunnel(log, der, pp)
% Plot OUTER LOOP Funnel variables

set(figure, 'Color', 'white', 'WindowState', 'maximized')
hold on
legend_entries = {}; % Initialize legend entries

% Define custom RGB colors
colors = struct( ...
    'xi',           [0.8500, 0.3250, 0.0980], ... % reddish-orange
    'eta',          [0, 0.4470, 0.7410],     ... % blue
    'eta_dot',      [0, 0, 1], ... % blue
    'Ve_function',  [1, 0, 0], ... % red
    'lambda_sat',   [0, 1, 0], ... % green
    'sigma_nom',    [0.9290, 0.6940, 0.1250], ... % yellow-orange
    'sigma_ideal',  [0.6350, 0.0780, 0.1840], ... % dark red
    'H_function',   [0, 0, 0],                ... % black
    'diameter',     [0.2, 0.7, 0.7],          ...
    'eMe',          [0.8, 0.5, 0.9]           ...
);

if isfield(log.outer_loop.funnel, 'xi')
    plot(log.time, log.outer_loop.funnel.xi, '--', 'Color', colors.xi, 'LineWidth', 1.5)
    legend_entries{end+1} = '$\xi(t)$';
end
if isfield(log.outer_loop.funnel, 'eta')
    plot(log.time, log.outer_loop.funnel.eta, '--', 'Color', colors.eta, 'LineWidth', 1.2)
    legend_entries{end+1} = '$\eta(t)$';
end
if isfield(log.outer_loop.funnel, 'eta_dot')
    plot(log.time, log.outer_loop.funnel.eta_dot, ':', 'Color', colors.eta_dot, 'LineWidth', 1.2)
    legend_entries{end+1} = '$\dot{\eta}(t)$';
end
if isfield(log.outer_loop.funnel, 'Ve_function')
    plot(log.time, log.outer_loop.funnel.Ve_function, '--', 'Color', colors.Ve_function, 'LineWidth', 1.2)
    legend_entries{end+1} = '$V_e(t,e)$';
end
if isfield(log.outer_loop.funnel, 'lambda_sat')
    plot(log.time, log.outer_loop.funnel.lambda_sat, '--', 'Color', colors.lambda_sat, 'LineWidth', 1.2)
    legend_entries{end+1} = '$\lambda_{\rm sat}(t,e)$';
end
if isfield(log.outer_loop.funnel, 'sigma_nom')
    plot(log.time, log.outer_loop.funnel.sigma_nom, ':', 'Color', colors.sigma_nom, 'LineWidth', 1.0)
    legend_entries{end+1} = '$\sigma_{\rm nom}(t,e)$';
end
if isfield(log.outer_loop.funnel, 'sigma_ideal')
    plot(log.time, log.outer_loop.funnel.sigma_ideal, '--', 'Color', colors.sigma_ideal, 'LineWidth', 1.0)
    legend_entries{end+1} = '$\sigma_{\rm ideal}(t)$';
end
if isfield(log.outer_loop.funnel, 'H_function')
    plot(log.time, log.outer_loop.funnel.H_function, ':', 'Color', colors.H_function, 'LineWidth', 1.0)
    legend_entries{end+1} = '$H(t,e)$';
end
if isfield(der.outer_loop.funnel, 'diameter')
    plot(log.time, der.outer_loop.funnel.diameter, ':', 'Color', colors.diameter, 'LineWidth', 2.3)
    legend_entries{end+1} = 'Funnel Diameter';
end
if isfield(der.outer_loop.funnel, 'eMe')
    plot(log.time, der.outer_loop.funnel.eMe, '--', 'Color', colors.eMe, 'LineWidth', 1.8)
    legend_entries{end+1} = '$e^{\rm T}Me$';
end

% Plot horizontal line for e_min
if isfield(der.outer_loop.funnel, 'e_min')
    yline(der.outer_loop.funnel.e_min, '-', ...
        'Color', [0.3, 0.3, 0.3], 'LineWidth', 2.0, 'LineStyle', '-.')
    legend_entries{end+1} = '$e_{\min}$';
end

legend(legend_entries, 'interpreter', 'latex', 'fontsize', pp.font_size, 'Location', 'best')
xlabel('$t$ [s]', 'interpreter', 'latex', 'fontsize', pp.font_size)
ylabel('Outer loop Funnel variables [-]', 'interpreter', 'latex', 'fontsize', pp.font_size)
title(pp.folder_controller, 'interpreter', 'latex', 'fontsize', pp.font_size_title)
axis tight
xlim([pp.x_lim_min, pp.x_lim_max])
box on
hold off

end
