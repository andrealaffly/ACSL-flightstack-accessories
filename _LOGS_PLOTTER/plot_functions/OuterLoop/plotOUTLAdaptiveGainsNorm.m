function plotOUTLAdaptiveGainsNorm(log, der, pp)
% Plot OUTER LOOP Adaptive Gain Frobenius Norms (robust to missing fields)

set(figure,'Color','white','WindowState','maximized')
box on
hold on

legend_entries = {};

% ---- K_hat_x ----
if isfield(der.outer_loop,'K_hat_x_norm')
  plot(log.time, der.outer_loop.K_hat_x_norm,'LineWidth',1.4)
  legend_entries{end+1} = '$\|\hat{K}_x(t)\|_F$';
end

% ---- K_hat_r ----
if isfield(der.outer_loop,'K_hat_r_norm')
  plot(log.time, der.outer_loop.K_hat_r_norm,'LineWidth',1.4)
  legend_entries{end+1} = '$\|\hat{K}_r(t)\|_F$';
end

% ---- K_hat_g ----
if isfield(der.outer_loop,'K_hat_g_norm')
  plot(log.time, der.outer_loop.K_hat_g_norm,'LineWidth',1.4)
  legend_entries{end+1} = '$\|\hat{K}_g(t)\|_F$';
end

% ---- Theta_hat ----
if isfield(der.outer_loop,'Theta_hat_norm')
  plot(log.time, der.outer_loop.Theta_hat_norm,'LineWidth',1.4)
  legend_entries{end+1} = '$\|\hat{\Theta}(t)\|_F$';
end

% Only create legend if something was plotted
if ~isempty(legend_entries)
  legend(legend_entries,'Interpreter','latex');
else
  warning('No adaptive gain norm fields found in der.outer_loop.')
end

xlabel('$t$ [s]','Interpreter','latex','fontsize',pp.font_size)
ylabel('Frobenius norm of adaptive gains','Interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'Interpreter','latex','fontsize',pp.font_size_title)

hold off
axis tight
xlim([pp.x_lim_min, pp.x_lim_max])

end