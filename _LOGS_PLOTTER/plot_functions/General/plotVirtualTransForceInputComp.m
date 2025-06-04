function plotVirtualTransForceInputComp(log, der, pp)
% Plot virtual translational force input COMPARISON Baseline & Adaptive

% pp.y_lim_min = -50;
% pp.y_lim_max = 50;


set(figure,'Color','white','WindowState','maximized')
subplot(3,1,1)
plot(log.time,log.mu_translational_raw_global.x,'r-','LineWidth',2)
hold on
plot(log.time,log.outer_loop.mu_PID_baseline.x,'b-.','LineWidth',2)
plot(log.time,log.outer_loop.mu_adaptive.x,'k-','LineWidth',1.2)
legend('$\mu_x(t)$', '$\mu_{\rm PID,x}(t)$', '$\mu_{\rm ad,x}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel({'Translational',' Control input', 'X [N]'},'interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])
% ylim([pp.y_lim_min,pp.y_lim_max])

subplot(3,1,2)
plot(log.time,log.mu_translational_raw_global.y,'r-','LineWidth',2)
hold on
plot(log.time,log.outer_loop.mu_PID_baseline.y,'b-.','LineWidth',2)
plot(log.time,log.outer_loop.mu_adaptive.y,'k-','LineWidth',1.2)
legend('$\mu_y(t)$', '$\mu_{\rm PID,y}(t)$', '$\mu_{\rm ad,y}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel({'Translational',' Control input', 'Y [N]'},'interpreter','latex','fontsize',pp.font_size)
% title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])
% ylim([pp.y_lim_min,pp.y_lim_max])

subplot(3,1,3)
plot(log.time,log.mu_translational_raw_global.z,'r-','LineWidth',2)
hold on
plot(log.time,log.outer_loop.mu_PID_baseline.z,'b-.','LineWidth',2)
plot(log.time,log.outer_loop.mu_adaptive.z,'k-','LineWidth',1.2)
legend('$\mu_z(t)$', '$\mu_{\rm PID,z}(t)$', '$\mu_{\rm ad,z}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel({'Translational',' Control input', 'Z [N]'},'interpreter','latex','fontsize',pp.font_size)
% title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])
% ylim([pp.y_lim_min,pp.y_lim_max])

end

