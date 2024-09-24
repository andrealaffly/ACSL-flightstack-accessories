function plotINNLuAdaptiveThetaHat(log, der, pp)
% Plot INNER LOOP u_adaptive_Theta_hat = - Theta_hat' * phi

set(figure,'Color','white','WindowState','maximized')
plot(log.time,der.inner_loop.u_adaptive_Theta_hat.x,'r-','LineWidth',1.2)
hold on
plot(log.time,der.inner_loop.u_adaptive_Theta_hat.y,'g-','LineWidth',1.2)
plot(log.time,der.inner_loop.u_adaptive_Theta_hat.z,'k-','LineWidth',1)
legend('$\tau_{\rm ad,\hat{\Theta},x}(t)$','$\tau_{\rm ad,\hat{\Theta},y}(t)$','$\tau_{\rm ad,\hat{\Theta},z}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Inner loop Adaptive control input of $\hat{\Theta}$ [Nm]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

end

