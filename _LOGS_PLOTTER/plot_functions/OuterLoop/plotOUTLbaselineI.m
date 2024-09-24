function plotOUTLbaselineI(log, der, pp)
% Plot OUTER LOOP Baseline Integral control input

set(figure,'Color','white','WindowState','maximized')
plot(log.time,der.outer_loop.Integral.x,'r-','LineWidth',1.2)
hold on
plot(log.time,der.outer_loop.Integral.y,'g-','LineWidth',1.2)
plot(log.time,der.outer_loop.Integral.z,'k-','LineWidth',1)
legend('$\mu_{\rm PID,I,x}(t)$','$\mu_{\rm PID,I,y}(t)$','$\mu_{\rm PID,I,z}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Outer loop Baseline Integral control input [N]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])
end

