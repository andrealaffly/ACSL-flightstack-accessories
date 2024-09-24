function plotAngularError(log, der, pp)
%  Plot angular error vs time 

set(figure,'Color','white','WindowState','maximized')
plot(log.time,rad2deg(log.angular_error.roll),'--','LineWidth',2)
hold on
plot(log.time,rad2deg(log.angular_error.pitch),'-.','LineWidth',2)
plot(log.time,rad2deg(log.angular_error.yaw),':','LineWidth',2)
legend('Roll error', 'Pitch error', 'Yaw error');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Angular error [deg]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

end

