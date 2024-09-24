function plotMOCAPquaternion(log, der, pp, mocap)
% Plot MOCAP quaternion vs time

set(figure,'Color','white','WindowState','maximized')
subplot(4,1,1)
plot(log.time,log.quaternion.q0,'b-','LineWidth',2)
hold on
plot(mocap.time,mocap.quaternion.q0,'r-.','LineWidth',2)
legend('$q_0(t)$','$q_{\rm 0,MOCAP}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('$q_0$ [-]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
axis tight
hold off

subplot(4,1,2)
plot(log.time,log.quaternion.q1,'b-','LineWidth',2)
hold on
plot(mocap.time,mocap.quaternion.q1,'r-.','LineWidth',2)
legend('$q_1(t)$','$q_{\rm 1,MOCAP}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('$q_1$ [-]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
axis tight
hold off

subplot(4,1,3)
plot(log.time,log.quaternion.q2,'b-','LineWidth',2)
hold on
plot(mocap.time,mocap.quaternion.q2,'r-.','LineWidth',2)
legend('$q_2(t)$','$q_{\rm 2,MOCAP}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('$q_2$ [-]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
axis tight
hold off

subplot(4,1,4)
plot(log.time,log.quaternion.q3,'b-','LineWidth',2)
hold on
plot(mocap.time,mocap.quaternion.q3,'r-.','LineWidth',2)
legend('$q_3(t)$','$q_{\rm 3,MOCAP}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('$q_3$ [-]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
axis tight
hold off

end

