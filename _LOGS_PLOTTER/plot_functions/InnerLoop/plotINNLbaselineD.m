function plotINNLbaselineD(log, der, pp)
% Plot INNER LOOP Baseline Derivative control input

set(figure,'Color','white','WindowState','maximized')
plot(log.time,der.inner_loop.Derivative.x,'r-','LineWidth',1.2)
hold on
plot(log.time,der.inner_loop.Derivative.y,'g-','LineWidth',1.2)
plot(log.time,der.inner_loop.Derivative.z,'k-','LineWidth',1)
legend('$\tau_{\rm PID,D,x}(t)$','$\tau_{\rm PID,D,y}(t)$','$\tau_{\rm PID,D,z}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Inner loop Baseline Derivative control input [Nm]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

end

