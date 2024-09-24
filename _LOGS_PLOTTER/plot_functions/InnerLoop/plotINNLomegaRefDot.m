function plotINNLomegaRefDot(log, der, pp)
% Plot INNER LOOP omega_ref_dot

set(figure,'Color','white','WindowState','maximized')
subplot(3,1,1)
plot(log.time,der.inner_loop.omega_ref_dot.x,'b-.','LineWidth',2)
% legend('$$\ddot{\phi}_{\rm d}(t)$$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('$$\dot{\omega}_{\rm ref,x}$$ [rad/s$$^2$$]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])

subplot(3,1,2)
plot(log.time,der.inner_loop.omega_ref_dot.y,'b-.','LineWidth',2)
% legend('$$\ddot{\phi}_{\rm d}(t)$$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('$$\dot{\omega}_{\rm ref,y}$$ [rad/s$$^2$$]','interpreter','latex','fontsize',pp.font_size)
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])

subplot(3,1,3)
plot(log.time,der.inner_loop.omega_ref_dot.z,'b-.','LineWidth',2)
% legend('$$\ddot{\phi}_{\rm d}(t)$$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('$$\dot{\omega}_{\rm ref,z}$$ [rad/s$$^2$$]','interpreter','latex','fontsize',pp.font_size)
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])

end

