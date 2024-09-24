function plotINNLdeadZoneModValue(log, der, pp)
% Plot INNER LOOP dead zone modification value

set(figure,'Color','white','WindowState','maximized')
plot(log.time,log.inner_loop.dead_zone_value,'b-','LineWidth',2)
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Inner Loop Dead Zone Mod. value [-]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])



end

