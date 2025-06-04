function plotTorqueControlInputComp(log, der, pp)
% Plot Torque Control Inputs U2, U3, U4 COMPARISON Baseline & Adaptive

set(figure,'Color','white','WindowState','maximized')
subplot(3,1,1)
plot(log.time,log.control_input.U2,'r-','LineWidth',2)
hold on
plot(log.time,log.inner_loop.tau_PID_baseline.x,'b-.','LineWidth',2)
plot(log.time,log.inner_loop.tau_adaptive.x,'k-','LineWidth',1.2)
legend('$\tau_x(t)$', '$\tau_{\rm PID,x}(t)$', '$\tau_{\rm ad,x}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel({'Rotational',' Control input', 'X [Nm]'},'interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])

subplot(3,1,2)
plot(log.time,log.control_input.U3,'r-','LineWidth',2)
hold on
plot(log.time,log.inner_loop.tau_PID_baseline.y,'b-.','LineWidth',2)
plot(log.time,log.inner_loop.tau_adaptive.y,'k-','LineWidth',1.2)
legend('$\tau_y(t)$', '$\tau_{\rm PID,y}(t)$', '$\tau_{\rm ad,y}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel({'Rotational',' Control input', 'Y [Nm]'},'interpreter','latex','fontsize',pp.font_size)
% title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])

subplot(3,1,3)
plot(log.time,log.control_input.U4,'r-','LineWidth',2)
hold on
plot(log.time,log.inner_loop.tau_PID_baseline.z,'b-.','LineWidth',2)
plot(log.time,log.inner_loop.tau_adaptive.z,'k-','LineWidth',1.2)
legend('$\tau_z(t)$', '$\tau_{\rm PID,z}(t)$', '$\tau_{\rm ad,z}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel({'Rotational',' Control input', 'Z [Nm]'},'interpreter','latex','fontsize',pp.font_size)
% title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])

end

