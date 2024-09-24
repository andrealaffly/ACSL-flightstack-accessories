function plotOUTLbaselineDynInv(log, der, pp)
% Plot OUTER LOOP Baseline Dynamic Inversion control input

set(figure,'Color','white','WindowState','maximized')
plot(log.time,log.outer_loop.dynamic_inversion.x,'r-','LineWidth',1.2)
hold on
plot(log.time,log.outer_loop.dynamic_inversion.y,'g-','LineWidth',1.2)
plot(log.time,log.outer_loop.dynamic_inversion.z,'k-','LineWidth',1)
legend('$\mu_{\rm DynInv,x}(t)$','$\mu_{\rm DynInv,y}(t)$','$\mu_{\rm DynInv,z}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Outer loop Baseline dynamic inversion control input [N]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

end

