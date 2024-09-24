function plotINNLuAdaptiveKhatR(log, der, pp)
% Plot INNER LOOP u_adaptive_K_hat_r = K_hat_r' * r_cmd

set(figure,'Color','white','WindowState','maximized')
plot(log.time,der.inner_loop.u_adaptive_K_hat_r.x,'r-','LineWidth',1.2)
hold on
plot(log.time,der.inner_loop.u_adaptive_K_hat_r.y,'g-','LineWidth',1.2)
plot(log.time,der.inner_loop.u_adaptive_K_hat_r.z,'k-','LineWidth',1)
legend('$\tau_{\rm ad,\hat{K}_r,x}(t)$','$\tau_{\rm ad,\hat{K}_r,y}(t)$','$\tau_{\rm ad,\hat{K}_r,z}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Inner loop Adaptive control input of $\hat{K}_r$ [Nm]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

end

