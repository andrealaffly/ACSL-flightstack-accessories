function plotOUTLKhatRdot(log, der, pp)
% Plot OUTER LOOP Adaptive Gain derivative K_hat_r_dot

set(figure,'Color','white','WindowState','maximized')
plot(log.time,der.outer_loop.K_hat_r_dot.ind00,'-','LineWidth',1.2)
hold on
plot(log.time,der.outer_loop.K_hat_r_dot.ind10,'-','LineWidth',1.2)
plot(log.time,der.outer_loop.K_hat_r_dot.ind20,'-','LineWidth',1.2)

plot(log.time,der.outer_loop.K_hat_r_dot.ind01,'--','LineWidth',1.2)
plot(log.time,der.outer_loop.K_hat_r_dot.ind11,'--','LineWidth',1.2)
plot(log.time,der.outer_loop.K_hat_r_dot.ind21,'--','LineWidth',1.2)

plot(log.time,der.outer_loop.K_hat_r_dot.ind02,'-.','LineWidth',1.2)
plot(log.time,der.outer_loop.K_hat_r_dot.ind12,'-.','LineWidth',1.2)
plot(log.time,der.outer_loop.K_hat_r_dot.ind22,'-.','LineWidth',1.2)


legend('00', '10', '20', ...
       '01', '11', '21', ...
       '02', '12', '22', 'Location','bestoutside');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Outer loop Adaptive gain derivative $\dot{\hat{K}}_r$ [-]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

end
