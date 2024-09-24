function plotMOCAPposition(log, der, pp, mocap)
% Plot MOCAP position vs time

set(figure,'Color','white','WindowState','maximized')
subplot(3,1,1)
plot(log.time,log.position.x,'r-','LineWidth',2)
hold on
plot(mocap.time,mocap.position.x,'k-','LineWidth',1.25)
plot(log.time,log.user_defined_position.x,'b-.','LineWidth',2)
legend('$r_{x}(t)$','$r_{x,MOCAP}(t)$','$r_{\rm user,x}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('X position [m]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
axis tight
hold off

subplot(3,1,2)
plot(log.time,log.position.y,'r-','LineWidth',2)
hold on
plot(mocap.time,mocap.position.y,'k-','LineWidth',1.25)
plot(log.time,log.user_defined_position.y,'b-.','LineWidth',2)
legend('$r_{y}(t)$','$r_{y,MOCAP}(t)$','$r_{\rm user,y}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Y position [m]','interpreter','latex','fontsize',pp.font_size)
axis tight
hold off

subplot(3,1,3)
plot(log.time,log.position.z,'r-','LineWidth',2)
hold on
plot(mocap.time,mocap.position.z,'k-','LineWidth',1.25)
plot(log.time,log.user_defined_position.z,'b-.','LineWidth',2)
legend('$r_{z}(t)$', '$r_{z,MOCAP}(t)$','$r_{\rm user,z}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Z position [m]','interpreter','latex','fontsize',pp.font_size)
ax = gca;
ax.YDir = 'reverse';
axis tight
hold off

end

