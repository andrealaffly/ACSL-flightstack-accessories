function plot3Dposition(log, der, pp)
% Plot 3D position in space

d_start = 995;
d_end = length(log.position.x);
set(figure,'Color','white','WindowState','maximized')
plot3(log.user_defined_position.x(d_start:d_end), ...
      log.user_defined_position.y(d_start:d_end), ...
      log.user_defined_position.z(d_start:d_end), ...
    'Color',"#4DBEEE",'LineStyle','--','LineWidth',1)
hold on
plot3(log.position.x(d_start:d_end), ...
      log.position.y(d_start:d_end), ...
      log.position.z(d_start:d_end), ...
    'Color',"#FF0000",'LineStyle','-','LineWidth',2)
legend('$r_{\rm user}$', '$r$');
axis equal
ax = gca;
ax.YDir = 'reverse';
ax.ZDir = 'reverse';
title('Position 3D','interpreter','latex','fontsize',18)
grid on
% xlim([-2 2])
% ylim([-2 2])
% zlim([-1.5 0.5])
xlabel('X [m]','interpreter','latex','fontsize',pp.font_size)
ylabel('Y [m]','interpreter','latex','fontsize',pp.font_size)
zlabel('Z [m]','interpreter','latex','fontsize',pp.font_size)
hold off

end

