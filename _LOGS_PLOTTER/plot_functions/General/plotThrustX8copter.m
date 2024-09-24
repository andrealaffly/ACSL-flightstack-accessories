function plotThrustX8copter(log, der, pp)
% Plot thrust vs. time for X8-COPTER

% Total thrust
set(figure,'Color','white','WindowState','maximized')
plot(log.time,der.total_thrust_motors_N,'b-','LineWidth',2)
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Total thrust [N]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

% Thrust in Newton
set(figure,'Color','white','WindowState','maximized')
subplot(2,1,1)
plot(log.time,log.thrust_motors_N.T1,'b-','LineWidth',2)
hold on
plot(log.time,log.thrust_motors_N.T2,'r-.','LineWidth',2)
plot(log.time,log.thrust_motors_N.T3,'g--','LineWidth',2)
plot(log.time,log.thrust_motors_N.T4,'k-','LineWidth',0.5)
legend('$T_1(t)$','$T_2(t)$','$T_3(t)$','$T_4(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Thrust motor $i$ [N]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

subplot(2,1,2)
plot(log.time,log.thrust_motors_N.T5,'r-.','LineWidth',2)
hold on
plot(log.time,log.thrust_motors_N.T6,'b-','LineWidth',2)
plot(log.time,log.thrust_motors_N.T7,'k-','LineWidth',0.5)
plot(log.time,log.thrust_motors_N.T8,'g--','LineWidth',2)
legend('$T_5(t)$','$T_6(t)$','$T_7(t)$','$T_8(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Thrust motor $i$ [N]','interpreter','latex','fontsize',pp.font_size)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

% Normalized thrust
set(figure,'Color','white','WindowState','maximized')
subplot(2,1,1)
plot(log.time,log.thrust_motors_normalized.T1,'b-','LineWidth',2)
hold on
plot(log.time,log.thrust_motors_normalized.T2,'r-.','LineWidth',2)
plot(log.time,log.thrust_motors_normalized.T3,'g--','LineWidth',2)
plot(log.time,log.thrust_motors_normalized.T4,'k-','LineWidth',0.5)
legend('$T_1(t)$','$T_2(t)$','$T_3(t)$','$T_4(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Thrust motor $i$ [-]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

subplot(2,1,2)
plot(log.time,log.thrust_motors_normalized.T5,'r-.','LineWidth',2)
hold on
plot(log.time,log.thrust_motors_normalized.T6,'b-','LineWidth',2)
plot(log.time,log.thrust_motors_normalized.T7,'k-','LineWidth',0.5)
plot(log.time,log.thrust_motors_normalized.T8,'g--','LineWidth',2)
legend('$T_5(t)$','$T_6(t)$','$T_7(t)$','$T_8(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Thrust motor $i$ [-]','interpreter','latex','fontsize',pp.font_size)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

end

