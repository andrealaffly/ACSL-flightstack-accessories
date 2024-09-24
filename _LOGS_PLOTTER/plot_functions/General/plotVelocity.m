function plotVelocity(log, der, pp)
% Plot velocity vs time

set(figure,'Color','white','WindowState','maximized')
subplot(3,1,1)
plot(log.time,log.velocity.x,'r-','LineWidth',2)
hold on
plot(log.time,log.user_defined_velocity.x,'b-.','LineWidth',2)
plot(log.time,log.outer_loop.reference_model.velocity.x,'k-','LineWidth',1.2)
legend('$\dot{r}_X(t)$','$\dot{r}_{{\rm user},X}(t)$','$\dot{r}_{{\rm ref},X}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('$X$-velocity [m/s]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])

subplot(3,1,2)
plot(log.time,log.velocity.y,'r-','LineWidth',2)
hold on
plot(log.time,log.user_defined_velocity.y,'b-.','LineWidth',2)
plot(log.time,log.outer_loop.reference_model.velocity.y,'k-','LineWidth',1.2)
legend('$\dot{r}_Y(t)$','$\dot{r}_{{\rm user},Y}(t)$','$\dot{r}_{{\rm ref},Y}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('$Y$-velocity [m/s]','interpreter','latex','fontsize',pp.font_size)
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])

subplot(3,1,3)
plot(log.time,log.velocity.z,'r-','LineWidth',2)
hold on
plot(log.time,log.user_defined_velocity.z,'b-.','LineWidth',2)
plot(log.time,log.outer_loop.reference_model.velocity.z,'k-','LineWidth',1.2)
legend('$\dot{r}_Z(t)$','$\dot{r}_{{\rm user},Z}(t)$','$\dot{r}_{{\rm ref},Y}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('$Z$-velocity [m/s]','interpreter','latex','fontsize',pp.font_size)
ax = gca;
ax.YDir = 'reverse';
axis tight
hold off
xlim([pp.x_lim_min,pp.x_lim_max])

end

