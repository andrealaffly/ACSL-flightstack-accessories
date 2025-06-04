function plotPosition(log, der, pp)
% Plot position vs time

set(figure,'Color','white','WindowState','maximized')
subplot(3,1,1)
plot(log.time,log.position.x,'r-','LineWidth',2)
hold on
plot(log.time,log.user_defined_position.x,'b-.','LineWidth',2)
if isfield(log, 'outer_loop') && isfield(log.outer_loop, 'reference_model')
    plot(log.time,log.outer_loop.reference_model.position.x,'k-','LineWidth',1.2)
    legend('$r_X(t)$','$r_{{\rm user},X}(t)$','$r_{{\rm ref},X}(t)$');
else 
    legend('$r_X(t)$','$r_{{\rm user},X}(t)$');
end
ylabel('$X$-position [m]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])

subplot(3,1,2)
plot(log.time,log.position.y,'r-','LineWidth',2)
hold on
plot(log.time,log.user_defined_position.y,'b-.','LineWidth',2)
if isfield(log, 'outer_loop') && isfield(log.outer_loop, 'reference_model')
    plot(log.time,log.outer_loop.reference_model.position.y,'k-','LineWidth',1.2)
    legend('$r_Y(t)$','$r_{{\rm user},Y}(t)$','$r_{{\rm ref},Y}(t)$');
else
    legend('$r_Y(t)$','$r_{{\rm user},Y}(t)$');
end
ylabel('$Y$-position [m]','interpreter','latex','fontsize',pp.font_size)
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])

subplot(3,1,3)
plot(log.time,log.position.z,'r-','LineWidth',2)
hold on
plot(log.time,log.user_defined_position.z,'b-.','LineWidth',2)
if isfield(log, 'outer_loop') && isfield(log.outer_loop, 'reference_model')
    plot(log.time,log.outer_loop.reference_model.position.z,'k-','LineWidth',1.2)
    legend('$r_Z(t)$','$r_{{\rm user},Z}(t)$','$r_{{\rm ref},Z}(t)$');
else
    legend('$r_Z(t)$','$r_{{\rm user},Z}(t)$');
end
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('$Z$-position [m]','interpreter','latex','fontsize',pp.font_size)
ax = gca;
ax.YDir = 'reverse';
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])

end

