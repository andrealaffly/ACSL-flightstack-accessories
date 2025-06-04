function plotAdaptiveGainsDotComparison(log, der, gain_type, loop_type, pp)
% Generalized function to plot and compare adaptive gains for the given loop and gain type
%
% log       : logged data
% der       : derivative data
% gain_type : string specifying which gain to compare (e.g., 'K_hat_x', 'K_hat_r', etc.)
% loop_type : string specifying the loop ('outer_loop' or 'inner_loop')
% pp        : plotting parameters

    % Accessing the specific fields from the derivative and debug data
    der_data = der.(loop_type).([gain_type '_dot']);  % e.g., der.outer_loop.K_hat_x_dot
    debug_data = log.debug.(loop_type).([gain_type '_dot']);  % e.g., debug.outer_loop.K_hat_x_dot

    % Number of gains to compare
    numGains = min(size(debug_data, 2), numel(fieldnames(der_data)));  % Use the smaller of the two

    % Get available indices in der_data
    availableIndices = fieldnames(der_data);  % Get the actual field names (e.g., 'ind00', 'ind01', etc.)

    % Number of subplots per figure (3 per window)
    plots_per_fig = 3;

    % Total number of figures needed
    num_figs = ceil(numGains / plots_per_fig);

    % Loop over each figure
    for fig_num = 1:num_figs
        set(figure, 'Color', 'white', 'WindowState', 'maximized');

        % Calculate which gains to plot in this figure
        first_gain = (fig_num - 1) * plots_per_fig + 1;
        last_gain = min(fig_num * plots_per_fig, numGains);

        % Plot each gain in the current figure
        for gain_idx = first_gain:last_gain
            subplot(plots_per_fig, 1, gain_idx - first_gain + 1);

            % Extract corresponding gains from log and debug data
            log_gain = der_data.(availableIndices{gain_idx});  % Access log data using available field names
            debug_gain = debug_data(:, gain_idx);  % Column access for debug data

            % Plot the gains
            plot(log.time, log_gain, 'LineWidth', 1.2, 'DisplayName', sprintf('Log %02d', gain_idx-1))
            hold on
            plot(log.time, debug_gain, '--', 'LineWidth', 1.2, 'DisplayName', sprintf('Debug %02d', gain_idx-1))

            % Add legend, labels, and title for each subplot
            % legend('show', 'Location', 'best')
            legend('Location', 'bestoutside')
            xlabel('$t$ [s]', 'interpreter', 'latex', 'fontsize', pp.font_size)

            % Properly escape the underscores in gain_type and loop_type for LaTeX
            ylabel(['${' strrep(gain_type, '_', '\_') '}_{' num2str(gain_idx-1) '}$ [-]'], 'interpreter', 'latex', 'fontsize', pp.font_size)
            title(['Gain ' num2str(gain_idx-1) ' - ' strrep(gain_type, '_', '\_')], 'interpreter', 'latex', 'fontsize', pp.font_size_title)

            hold off
            axis tight
            xlim([pp.x_lim_min, pp.x_lim_max])
        end

        % Properly escape underscores in the figure title
        sgtitle([strrep(pp.folder_controller, '_', '\_') ' - ' strrep(loop_type, '_', '\_') ' - ' strrep(gain_type, '_', '\_') ' (Figure ' num2str(fig_num) ')'], ...
            'interpreter', 'latex', 'fontsize', pp.font_size_title)
    end
end
