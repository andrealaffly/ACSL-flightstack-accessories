function plotVirtualTransForceInput(log, der, pp)
% Plot virtual translational force input

set(figure,'Color','white','WindowState','maximized')
plot(log.time,log.mu_translational.x,'r-','LineWidth',1.2)
hold on
plot(log.time,log.mu_translational.y,'g-','LineWidth',1.2)
plot(log.time,log.mu_translational.z,'k-','LineWidth',1)
legend('$\mu_x(t)$','$\mu_y(t)$','$\mu_z(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Virtual translational force input [N]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

end



