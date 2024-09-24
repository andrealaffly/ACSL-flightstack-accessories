function plotOUTLrcmd(log, der, pp)
% Plot OUTER LOOP r_cmd

set(figure,'Color','white','WindowState','maximized')
subplot(3,1,1)
plot(log.time,log.outer_loop.r_cmd.x,'b-.','LineWidth',2)
% legend('$$\ddot{\phi}_{\rm d}(t)$$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Outer loop $$r_{{\rm cmd},x}$$ [-]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])

subplot(3,1,2)
plot(log.time,log.outer_loop.r_cmd.y,'b-.','LineWidth',2)
% legend('$$\ddot{\theta}_{\rm d}(t)$$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Outer loop $$r_{{\rm cmd},y}$$ [-]','interpreter','latex','fontsize',pp.font_size)
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])

subplot(3,1,3)
plot(log.time,log.outer_loop.r_cmd.z,'b-.','LineWidth',2)
% legend('$$\ddot{\psi}_{\rm d}(t)$$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Outer loop $$r_{{\rm cmd},z}$$ [-]','interpreter','latex','fontsize',pp.font_size)
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])

end

