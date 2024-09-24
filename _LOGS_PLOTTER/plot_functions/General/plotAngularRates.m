function plotAngularRates(log, der, pp)
% Plot angular rates (first derivative of Euler angles) vs time

set(figure,'Color','white','WindowState','maximized')
subplot(3,1,1)
plot(log.time,log.euler_angles_dot.roll_dot,'r-','LineWidth',2)
hold on
plot(log.time,log.desired_euler_angles.roll_dot,'b-.','LineWidth',2)
legend('$$\dot{\phi}(t)$$','$$\dot{\phi}_{\rm d}(t)$$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Roll rate [rad/s]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])

subplot(3,1,2)
plot(log.time,log.euler_angles_dot.pitch_dot,'r-','LineWidth',2)
hold on
plot(log.time,log.desired_euler_angles.pitch_dot,'b-.','LineWidth',2)
legend('$$\dot{\theta}(t)$$','$$\dot{\theta}_{\rm d}(t)$$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Pitch rate [rad/s]','interpreter','latex','fontsize',pp.font_size)
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])

subplot(3,1,3)
plot(log.time,log.euler_angles_dot.yaw_dot,'r-','LineWidth',2)
hold on
plot(log.time,log.user_defined_yaw_dot,'b-.','LineWidth',2)
legend('$$\dot{\psi}(t)$$','$$\dot{\psi}_{\rm d}(t)$$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Yaw rate [rad/s]','interpreter','latex','fontsize',pp.font_size)
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])

end

