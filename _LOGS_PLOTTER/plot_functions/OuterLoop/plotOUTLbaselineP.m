function plotOUTLbaselineP(log, der, pp)
% Plot OUTER LOOP Baseline Proportional control input

set(figure,'Color','white','WindowState','maximized')
plot(log.time,der.outer_loop.Proportional.x,'r-','LineWidth',1.2)
hold on
plot(log.time,der.outer_loop.Proportional.y,'g-','LineWidth',1.2)
plot(log.time,der.outer_loop.Proportional.z,'k-','LineWidth',1)
legend('$\mu_{\rm PID,P,x}(t)$','$\mu_{\rm PID,P,y}(t)$','$\mu_{\rm PID,P,z}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Outer loop Baseline Proportional control input [N]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

end

