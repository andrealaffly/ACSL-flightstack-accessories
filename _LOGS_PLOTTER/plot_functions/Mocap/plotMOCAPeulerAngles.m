function plotMOCAPeulerAngles(log, der, pp, mocap)
% Plot MOCAP euler angles vs time

set(figure,'Color','white','WindowState','maximized')
subplot(3,1,1)
plot(log.time,rad2deg(log.euler_angles.roll),'b-','LineWidth',2)
hold on
plot(mocap.time,rad2deg(mocap.euler_angles.roll),'r-.','LineWidth',2)
legend('$$\phi(t)$$','$$\phi_{\rm MOCAP}(t)$$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Roll [deg]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
axis tight
hold off

subplot(3,1,2)
plot(log.time,rad2deg(log.euler_angles.pitch),'b-','LineWidth',2)
hold on
plot(mocap.time,rad2deg(mocap.euler_angles.pitch),'r-.','LineWidth',2)
legend('$$\theta(t)$$','$$\theta_{\rm MOCAP}(t)$$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Pitch [deg]','interpreter','latex','fontsize',pp.font_size)
axis tight
hold off

subplot(3,1,3)
plot(log.time,rad2deg(log.euler_angles.yaw),'b-','LineWidth',2)
hold on
plot(mocap.time,rad2deg(mocap.euler_angles.yaw),'r-.','LineWidth',2)
legend('$$\psi(t)$$','$$\psi_{\rm MOCAP}(t)$$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Yaw [deg]','interpreter','latex','fontsize',pp.font_size)
axis tight
hold off

end

