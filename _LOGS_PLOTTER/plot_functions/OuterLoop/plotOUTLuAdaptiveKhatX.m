function plotOUTLuAdaptiveKhatX(log, der, pp)
% Plot OUTER LOOP u_adaptive_K_hat_x = K_hat_x' * x

set(figure,'Color','white','WindowState','maximized')
plot(log.time,der.outer_loop.u_adaptive_K_hat_x.x,'r-','LineWidth',1.2)
hold on
plot(log.time,der.outer_loop.u_adaptive_K_hat_x.y,'g-','LineWidth',1.2)
plot(log.time,der.outer_loop.u_adaptive_K_hat_x.z,'k-','LineWidth',1)
legend('$\mu_{\rm ad,\hat{K}_x,x}(t)$','$\mu_{\rm ad,\hat{K}_x,y}(t)$','$\mu_{\rm ad,\hat{K}_x,z}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Outer loop Adaptive control input of $\hat{K}_x$ [N]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

end

