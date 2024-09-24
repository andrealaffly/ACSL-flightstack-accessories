function plotAnglesDoubleDerivatives(log, der, pp)
% Plot angular accelerations (double derivative of Euler angles) vs time

set(figure,'Color','white','WindowState','maximized')
subplot(3,1,1)
plot(log.time,log.desired_euler_angles.roll_dot_dot,'b-.','LineWidth',2)
legend('$$\ddot{\phi}_{\rm d}(t)$$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Roll accel [rad/s$^2$]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])

subplot(3,1,2)
plot(log.time,log.desired_euler_angles.pitch_dot_dot,'b-.','LineWidth',2)
legend('$$\ddot{\theta}_{\rm d}(t)$$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Pitch accel [rad/s$^2$]','interpreter','latex','fontsize',pp.font_size)
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])

subplot(3,1,3)
plot(log.time,log.user_defined_yaw_dot_dot,'b-.','LineWidth',2)
legend('$$\ddot{\psi}_{\rm d}(t)$$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Yaw accel [rad/s$^2$]','interpreter','latex','fontsize',pp.font_size)
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])

end

