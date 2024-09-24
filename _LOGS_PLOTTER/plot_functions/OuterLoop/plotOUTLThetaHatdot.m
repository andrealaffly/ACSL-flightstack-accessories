function plotOUTLThetaHatdot(log, der, pp)
% Plot OUTER LOOP Adaptive Gain derivative Theta_hat_dot

set(figure,'Color','white','WindowState','maximized')
plot(log.time,der.outer_loop.Theta_hat_dot.ind00,'-','LineWidth',1.2)
hold on
plot(log.time,der.outer_loop.Theta_hat_dot.ind10,'-','LineWidth',1.2)
plot(log.time,der.outer_loop.Theta_hat_dot.ind20,'-','LineWidth',1.2)
plot(log.time,der.outer_loop.Theta_hat_dot.ind30,'-','LineWidth',1.2)
plot(log.time,der.outer_loop.Theta_hat_dot.ind40,'-','LineWidth',1.2)
plot(log.time,der.outer_loop.Theta_hat_dot.ind50,'-','LineWidth',1.2)

plot(log.time,der.outer_loop.Theta_hat_dot.ind01,'--','LineWidth',1.2)
plot(log.time,der.outer_loop.Theta_hat_dot.ind11,'--','LineWidth',1.2)
plot(log.time,der.outer_loop.Theta_hat_dot.ind21,'--','LineWidth',1.2)
plot(log.time,der.outer_loop.Theta_hat_dot.ind31,'--','LineWidth',1.2)
plot(log.time,der.outer_loop.Theta_hat_dot.ind41,'--','LineWidth',1.2)
plot(log.time,der.outer_loop.Theta_hat_dot.ind51,'--','LineWidth',1.2)

plot(log.time,der.outer_loop.Theta_hat_dot.ind02,'-.','LineWidth',1.2)
plot(log.time,der.outer_loop.Theta_hat_dot.ind12,'-.','LineWidth',1.2)
plot(log.time,der.outer_loop.Theta_hat_dot.ind22,'-.','LineWidth',1.2)
plot(log.time,der.outer_loop.Theta_hat_dot.ind32,'-.','LineWidth',1.2)
plot(log.time,der.outer_loop.Theta_hat_dot.ind42,'-.','LineWidth',1.2)
plot(log.time,der.outer_loop.Theta_hat_dot.ind52,'-.','LineWidth',1.2)


legend('00', '10', '20', '30', '40', '50', ...
       '01', '11', '21', '31', '41', '51', ...
       '02', '12', '22', '32', '42', '52', 'Location','bestoutside');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Outer loop Adaptive gain derivative $\dot{\hat{\Theta}}$ [-]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

end

