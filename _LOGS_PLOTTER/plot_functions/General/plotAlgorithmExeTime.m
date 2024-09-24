function plotAlgorithmExeTime(log, der, pp)
%  Plot algorithm execution/computational time vs time 

set(figure,'Color','white','WindowState','maximized')
plot(log.time,log.algorithm_execution_time_us,'*','LineWidth',2)
hold on
plot(log.time,der.average_algorithm_execution_time_us ...
    * ones(size(log.time)),'--','LineWidth',2)

% Plot standard deviation band
std_upper = der.average_algorithm_execution_time_us + der.standard_deviation_algorithm_execution_time_us;
std_lower = der.average_algorithm_execution_time_us - der.standard_deviation_algorithm_execution_time_us;
fill([0, log.time(end), log.time(end), 0], ...
    [std_lower, std_lower, std_upper, std_upper], ...
    'r', 'EdgeColor', 'none', 'FaceAlpha', 0.3);

legend('', ['Average execution time: ', num2str(der.average_algorithm_execution_time_us), ' $\mu$s'], ...
           ['$\pm$ Standard deviation: ', num2str(der.standard_deviation_algorithm_execution_time_us), ' $\mu$s'])
xlabel('$t$ [s]','interpreter','latex','fontsize',pp.font_size)
ylabel('Algorithm execution time [$\mu$s]','interpreter','latex','fontsize',pp.font_size)
title(pp.folder_controller,'interpreter','latex','fontsize',pp.font_size_title)
hold off
axis tight
xlim([pp.x_lim_min,pp.x_lim_max])

end

