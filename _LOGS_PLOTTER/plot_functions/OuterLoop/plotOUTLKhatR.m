function plotOUTLKhatR(log, der, pp)
% Plot OUTER LOOP Adaptive Gain K_hat_r

set(figure,'Color','white','WindowState','maximized')
plot(log.time,log.outer_loop.K_hat_r.ind00,'-','LineWidth',1.2)
hold on
plot(log.time,log.outer_loop.K_hat_r.ind10,'-','LineWidth',1.2)
plot(log.time,log.outer_loop.K_hat_r.ind20,'-','LineWidth',1.2)

plot(log.time,log.outer_loop.K_hat_r.ind01,'--','LineWidth',1.2)
plot(log.time,log.outer_loop.K_hat_r.ind11,'--','LineWidth',1.2)
plot(log.time,log.outer_loop.K_hat_r.ind21,'--','LineWidth',1.2)

plot(log.time,log.outer_loop.K_hat_r.ind02,'-.','LineWidth',1.2)
plot(log.time,log.outer_loop.K_hat_r.ind12,'-.','LineWidth',1.2)
plot(log.time,log.outer_loop.K_hat_r.ind22,'-.','LineWidth',1.2)


legend('00', '10', '20', ...
       '01', '11', '21', ...
       '02', '12', '22', 'Location','bestoutside');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Outer loop Adaptive gain $\hat{K}_r$ [-]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

end

