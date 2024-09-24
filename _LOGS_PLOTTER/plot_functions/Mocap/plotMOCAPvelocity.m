function plotMOCAPvelocity(log, der, pp, mocap)
% Plot MOCAP velocity vs time

set(figure,'Color','white','WindowState','maximized')
subplot(3,1,1)
plot(log.time,log.velocity.x,'r-','LineWidth',2)
hold on
plot(mocap.time,mocap.velocity.x,'k-','LineWidth',1.25)
plot(log.time,log.user_defined_velocity.x,'b-.','LineWidth',2)
legend('$\dot{r}_{x}(t)$', '$\dot{r}_{x,MOCAP}(t)$','$\dot{r}_{\rm user,x}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('X velocity [m/s]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
axis tight
hold off

subplot(3,1,2)
plot(log.time,log.velocity.y,'r-','LineWidth',2)
hold on
plot(mocap.time,mocap.velocity.y,'k-','LineWidth',1.25)
plot(log.time,log.user_defined_velocity.y,'b-.','LineWidth',2)
legend('$\dot{r}_{y}(t)$', '$\dot{r}_{y,MOCAP}(t)$','$\dot{r}_{\rm user,y}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Y velocity [m/s]','interpreter','latex','fontsize',pp.font_size)
axis tight
hold off

subplot(3,1,3)
plot(log.time,log.velocity.z,'r-','LineWidth',2)
hold on
plot(mocap.time,mocap.velocity.z,'k-','LineWidth',1.25)
plot(log.time,log.user_defined_velocity.z,'b-.','LineWidth',2)
legend('$\dot{r}_{z}(t)$', '$\dot{r}_{z,MOCAP}(t)$','$\dot{r}_{\rm user,z}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Z velocity [m/s]','interpreter','latex','fontsize',pp.font_size)
ax = gca;
ax.YDir = 'reverse';
axis tight
hold off

end

