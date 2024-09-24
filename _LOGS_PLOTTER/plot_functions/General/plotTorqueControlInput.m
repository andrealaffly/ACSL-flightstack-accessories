function plotTorqueControlInput(log, der, pp)
% Plot Torque Control Inputs U2, U3, U4 

set(figure,'Color','white','WindowState','maximized')
plot(log.time,log.control_input.U2,'r-.','LineWidth',1.2)
hold on
plot(log.time,log.control_input.U3,'g--','LineWidth',1.2)
plot(log.time,log.control_input.U4,'k-','LineWidth',1)
legend('$U_2(t)$','$U_3(t)$','$U_4(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Control inputs [Nm]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

end

