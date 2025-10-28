function plotOUTLnormL2TrackingError(log, der, pp)
% Plot of norm of trajectory tracking error of OUTER LOOP

set(figure,'Color','white','WindowState','maximized')
plot(log.time, der.outer_loop.tracking_error_L2norm,'b-','LineWidth',2)
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Outer Loop L2-Norm of trajectory tracking error [-]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

end