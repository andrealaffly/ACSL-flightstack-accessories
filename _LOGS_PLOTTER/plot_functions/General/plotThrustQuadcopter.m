function plotThrustQuadcopter(log, der, pp)
% Plot thrust vs. time for QUADCOPTER

% Total thrust
set(figure,'Color','white','WindowState','maximized')
plot(log.time,der.total_thrust_motors_quadcopter_N,'b-','LineWidth',2)
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Total thrust [N]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

% Thrust in Newton
set(figure,'Color','white','WindowState','maximized')
plot(log.time,log.thrust_motors_quadcopter_N.T1,'b-','LineWidth',2)
hold on
plot(log.time,log.thrust_motors_quadcopter_N.T2,'r-.','LineWidth',2)
plot(log.time,log.thrust_motors_quadcopter_N.T3,'g--','LineWidth',2)
plot(log.time,log.thrust_motors_quadcopter_N.T4,'k-','LineWidth',0.5)
legend('$T_1(t)$','$T_2(t)$','$T_3(t)$','$T_4(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Thrust motor $i$ [N]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

% Normalized thrust
set(figure,'Color','white','WindowState','maximized')
plot(log.time,log.thrust_motors_quadcopter_normalized.T1,'b-','LineWidth',2)
hold on
plot(log.time,log.thrust_motors_quadcopter_normalized.T2,'r-.','LineWidth',2)
plot(log.time,log.thrust_motors_quadcopter_normalized.T3,'g--','LineWidth',2)
plot(log.time,log.thrust_motors_quadcopter_normalized.T4,'k-','LineWidth',0.5)
legend('$T_1(t)$','$T_2(t)$','$T_3(t)$','$T_4(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Thrust motor $i$ [-]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

end

