function plotINNLbaselineFF(log, der, pp)
% Plot INNER LOOP Feedforward acceleration term control input

set(figure,'Color','white','WindowState','maximized')
plot(log.time,der.inner_loop.feed_forward_accel_term.x,'r-','LineWidth',1.2)
hold on
plot(log.time,der.inner_loop.feed_forward_accel_term.y,'g-','LineWidth',1.2)
plot(log.time,der.inner_loop.feed_forward_accel_term.z,'k-','LineWidth',1)
legend('$\tau_{\rm FF,x}(t)$','$\tau_{\rm FF,y}(t)$','$\tau_{\rm FF,z}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Inner loop Baseline feedforward acceleration control input [Nm]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])
end

