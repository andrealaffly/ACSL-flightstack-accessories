function plotTransPosError(log, der, pp)
%  Plot translational position error vs time 

set(figure,'Color','white','WindowState','maximized')
plot(log.time,der.translational_position_error.x,'--','LineWidth',2)
hold on
plot(log.time,der.translational_position_error.y,'-.','LineWidth',2)
plot(log.time,der.translational_position_error.z,':','LineWidth',2)
plot(log.time,der.translational_position_error.norm,'--','LineWidth',1)
legend('$x-$error', '$y-$error', '$z-$error', 'error norm');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Translational position error [m]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

end

