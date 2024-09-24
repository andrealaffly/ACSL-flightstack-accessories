function plotOUTLnormTrackingError(log, der, pp)
% Plot of norm of trajectory tracking error of OUTER LOOP

% Total thrust
set(figure,'Color','white','WindowState','maximized')
plot(log.time,der.outer_loop.tracking_error_norm,'b-','LineWidth',2)
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Outer Loop Norm of trajectory tracking error [-]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])



end

