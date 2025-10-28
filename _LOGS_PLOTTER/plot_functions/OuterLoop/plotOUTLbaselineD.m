% function plotOUTLbaselineD(log, der, pp)
% % Plot OUTER LOOP Baseline Derivative control input
% 
% set(figure,'Color','white','WindowState','maximized')
% plot(log.time,der.outer_loop.Derivative.x,'r-','LineWidth',1.2)
% hold on
% plot(log.time,der.outer_loop.Derivative.y,'g-','LineWidth',1.2)
% plot(log.time,der.outer_loop.Derivative.z,'k-','LineWidth',1)
% legend('$\mu_{\rm PID,D,x,der}(t)$', ...
%        '$\mu_{\rm PID,D,x,log}(t)$', ...
%        '$\mu_{\rm PID,D,y}(t)$', ...
%        '$\mu_{\rm PID,D,z}(t)$');
% xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
% ylabel('Outer loop Baseline Derivative control input [N]','interpreter','latex','fontsize',pp.font_size)
% title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
% hold off
% axis tight
% xlim([pp.x_lim_min,pp.x_lim_max])
% 
% end
% 

function plotOUTLbaselineD(log, der, pp)
% Plot OUTER LOOP Baseline Derivative control input

set(figure,'Color','white','WindowState','maximized')
legend_entries = {};  % initialize empty legend

% Raw derivative
plot(log.time, der.outer_loop.Derivative.x, 'r-', 'LineWidth', 1)
legend_entries{end+1} = '$\mu_{\rm PID,D,x}(t)$';
hold on

plot(log.time, der.outer_loop.Derivative.y, 'g-', 'LineWidth', 1)
legend_entries{end+1} = '$\mu_{\rm PID,D,y}(t)$';

plot(log.time, der.outer_loop.Derivative.z, 'k-', 'LineWidth', 1)
legend_entries{end+1} = '$\mu_{\rm PID,D,z}(t)$';

% Filtered derivative (if it exists)
if isfield(der.outer_loop, 'Derivative_filtered')
    plot(log.time, der.outer_loop.Derivative_filtered.x, 'r--', 'LineWidth', 1.5)
    legend_entries{end+1} = '$\mu_{\rm PID,D,x,filtered}(t)$';
    
    plot(log.time, der.outer_loop.Derivative_filtered.y, 'g--', 'LineWidth', 1.5)
    legend_entries{end+1} = '$\mu_{\rm PID,D,y,filtered}(t)$';
    
    plot(log.time, der.outer_loop.Derivative_filtered.z, 'k--', 'LineWidth', 1.5)
    legend_entries{end+1} = '$\mu_{\rm PID,D,z,filtered}(t)$';
end

legend(legend_entries, 'Interpreter', 'latex', 'Location','best')

xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Outer loop Baseline Derivative control input [N]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)

axis tight
xlim([pp.x_lim_min, pp.x_lim_max])
hold off

end

