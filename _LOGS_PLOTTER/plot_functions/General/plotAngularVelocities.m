function plotAngularVelocities(log, der, pp)
% Plot angular rates (first derivative of Euler angles) vs time

set(figure,'Color','white','WindowState','maximized')
subplot(3,1,1)
plot(log.time,log.angular_velocity.x,'r-','LineWidth',2)
hold on
if isfield(log, 'inner_loop')
plot(log.time,log.inner_loop.omega_cmd.x,'b-.','LineWidth',2)
plot(log.time,log.inner_loop.reference_model.angular_velocity.x,'k-','LineWidth',1.2)
legend('$$\omega_x(t)$$','$$\omega_{{\rm cmd},x}(t)$$','$$\omega_{{\rm ref},x}(t)$$');
else
    legend('$$\omega_x(t)$$');
end
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel({'Angular velocity',' x [rad/s]'},'interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])

subplot(3,1,2)
plot(log.time,log.angular_velocity.y,'r-','LineWidth',2)
hold on
if isfield(log, 'inner_loop')
plot(log.time,log.inner_loop.omega_cmd.y,'b-.','LineWidth',2)
plot(log.time,log.inner_loop.reference_model.angular_velocity.y,'k-','LineWidth',1.2)
legend('$$\omega_y(t)$$','$$\omega_{{\rm cmd},y}(t)$$','$$\omega_{{\rm ref},y}(t)$$');
else
    legend('$$\omega_y(t)$$');
end
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel({'Angular velocity',' y [rad/s]'},'interpreter','latex','fontsize',pp.font_size)
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])

subplot(3,1,3)
plot(log.time,log.angular_velocity.z,'r-','LineWidth',2)
hold on
if isfield(log, 'inner_loop')
plot(log.time,log.inner_loop.omega_cmd.z,'b-.','LineWidth',2)
plot(log.time,log.inner_loop.reference_model.angular_velocity.z,'k-','LineWidth',1.2)
legend('$$\omega_z(t)$$','$$\omega_{{\rm cmd},z}(t)$$','$$\omega_{{\rm ref},z}(t)$$');
else
    legend('$$\omega_z(t)$$');
end
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel({'Angular velocity',' z [rad/s]'},'interpreter','latex','fontsize',pp.font_size)
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])

end

