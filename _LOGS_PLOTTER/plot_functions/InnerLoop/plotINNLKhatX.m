function plotINNLKhatX(log, der, pp)
% Plot INENR LOOP Adaptive Gain K_hat_x

set(figure,'Color','white','WindowState','maximized')
plot(log.time,log.inner_loop.K_hat_x.ind00,'-','LineWidth',1.2)
hold on
plot(log.time,log.inner_loop.K_hat_x.ind10,'-','LineWidth',1.2)
plot(log.time,log.inner_loop.K_hat_x.ind20,'-','LineWidth',1.2)

plot(log.time,log.inner_loop.K_hat_x.ind01,'--','LineWidth',1.2)
plot(log.time,log.inner_loop.K_hat_x.ind11,'--','LineWidth',1.2)
plot(log.time,log.inner_loop.K_hat_x.ind21,'--','LineWidth',1.2)

plot(log.time,log.inner_loop.K_hat_x.ind02,'-.','LineWidth',1.2)
plot(log.time,log.inner_loop.K_hat_x.ind12,'-.','LineWidth',1.2)
plot(log.time,log.inner_loop.K_hat_x.ind22,'-.','LineWidth',1.2)

legend('00', '10', '20', ...
       '01', '11', '21', ...
       '02', '12', '22', 'Location','bestoutside');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Inner loop Adaptive gain $\hat{K}_x$ [-]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

end

