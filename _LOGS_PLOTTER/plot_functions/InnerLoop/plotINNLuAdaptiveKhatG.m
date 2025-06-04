function plotINNLuAdaptiveKhatG(log, der, pp)
% Plot INNER LOOP u_adaptive_K_hat_g = K_hat_g' * e

set(figure,'Color','white','WindowState','maximized')
plot(log.time,der.inner_loop.u_adaptive_K_hat_g.x,'r-','LineWidth',1.2)
hold on
plot(log.time,der.inner_loop.u_adaptive_K_hat_g.y,'g-','LineWidth',1.2)
plot(log.time,der.inner_loop.u_adaptive_K_hat_g.z,'k-','LineWidth',1)
legend('$\tau_{\rm ad,\hat{K}_g,x}(t)$','$\tau_{\rm ad,\hat{K}_g,y}(t)$','$\tau_{\rm ad,\hat{K}_g,z}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Inner loop Adaptive control input of $\hat{K}_g$ [Nm]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

end

