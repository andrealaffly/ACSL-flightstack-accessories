function plotOUTLThetaHat(log, der, pp)
% Plot OUTER LOOP Adaptive Gain Theta_hat

set(figure,'Color','white','WindowState','maximized')
plot(log.time,log.outer_loop.Theta_hat.ind00,'-','LineWidth',1.2)
hold on
plot(log.time,log.outer_loop.Theta_hat.ind10,'-','LineWidth',1.2)
plot(log.time,log.outer_loop.Theta_hat.ind20,'-','LineWidth',1.2)
plot(log.time,log.outer_loop.Theta_hat.ind30,'-','LineWidth',1.2)
plot(log.time,log.outer_loop.Theta_hat.ind40,'-','LineWidth',1.2)
plot(log.time,log.outer_loop.Theta_hat.ind50,'-','LineWidth',1.2)

plot(log.time,log.outer_loop.Theta_hat.ind01,'--','LineWidth',1.2)
plot(log.time,log.outer_loop.Theta_hat.ind11,'--','LineWidth',1.2)
plot(log.time,log.outer_loop.Theta_hat.ind21,'--','LineWidth',1.2)
plot(log.time,log.outer_loop.Theta_hat.ind31,'--','LineWidth',1.2)
plot(log.time,log.outer_loop.Theta_hat.ind41,'--','LineWidth',1.2)
plot(log.time,log.outer_loop.Theta_hat.ind51,'--','LineWidth',1.2)

plot(log.time,log.outer_loop.Theta_hat.ind02,'-.','LineWidth',1.2)
plot(log.time,log.outer_loop.Theta_hat.ind12,'-.','LineWidth',1.2)
plot(log.time,log.outer_loop.Theta_hat.ind22,'-.','LineWidth',1.2)
plot(log.time,log.outer_loop.Theta_hat.ind32,'-.','LineWidth',1.2)
plot(log.time,log.outer_loop.Theta_hat.ind42,'-.','LineWidth',1.2)
plot(log.time,log.outer_loop.Theta_hat.ind52,'-.','LineWidth',1.2)


legend('00', '10', '20', '30', '40', '50', ...
       '01', '11', '21', '31', '41', '51', ...
       '02', '12', '22', '32', '42', '52', 'Location','bestoutside');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Outer loop Adaptive gain $\hat{\Theta}$ [-]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

end

