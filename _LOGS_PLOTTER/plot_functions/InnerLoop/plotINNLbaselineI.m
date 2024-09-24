function plotINNLbaselineI(log, der, pp)
% Plot INNER LOOP Baseline Integral control input

set(figure,'Color','white','WindowState','maximized')
plot(log.time,der.inner_loop.Integral.x,'r-','LineWidth',1.2)
hold on
plot(log.time,der.inner_loop.Integral.y,'g-','LineWidth',1.2)
plot(log.time,der.inner_loop.Integral.z,'k-','LineWidth',1)
legend('$\tau_{\rm PID,I,x}(t)$','$\tau_{\rm PID,I,y}(t)$','$\tau_{\rm PID,I,z}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Inner loop Baseline Integral control input [Nm]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])
end

