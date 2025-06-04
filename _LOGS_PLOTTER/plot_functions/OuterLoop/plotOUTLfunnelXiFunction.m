function plotOUTLfunnelXiFunction(log, der, pp)
% Plot OUTER LOOP Funnel user-defined xi function

set(figure,'Color','white','WindowState','maximized')
plot(log.time,log.outer_loop.funnel.xi,'r-','LineWidth',1.2)
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Outer loop Funnel $\xi(t)$ [-]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])
end