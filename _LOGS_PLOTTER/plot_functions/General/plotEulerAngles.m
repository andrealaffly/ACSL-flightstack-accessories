function plotEulerAngles(log, der, pp)
% Plot Euler angles vs time

set(figure,'Color','white','WindowState','maximized')
subplot(3,1,1)
plot(log.time,rad2deg(log.euler_angles.roll),'r-','LineWidth',2)
hold on
plot(log.time,rad2deg(log.desired_euler_angles.roll),'b-.','LineWidth',2)
legend('$$\phi(t)$$','$$\phi_{\rm d}(t)$$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Roll [deg]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])

subplot(3,1,2)
plot(log.time,rad2deg(log.euler_angles.pitch),'r-','LineWidth',2)
hold on
plot(log.time,rad2deg(log.desired_euler_angles.pitch),'b-.','LineWidth',2)
legend('$$\theta(t)$$','$$\theta_{\rm d}(t)$$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Pitch [deg]','interpreter','latex','fontsize',pp.font_size)
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])

subplot(3,1,3)
plot(log.time,rad2deg(log.euler_angles.yaw),'r-','LineWidth',2)
hold on
plot(log.time,rad2deg(der.user_defined_yaw),'b-.','LineWidth',2)
legend('$$\psi(t)$$','$$\psi_{\rm d}(t)$$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Yaw [deg]','interpreter','latex','fontsize',pp.font_size)
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])

end

