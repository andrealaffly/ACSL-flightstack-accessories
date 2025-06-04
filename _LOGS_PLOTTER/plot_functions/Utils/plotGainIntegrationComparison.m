function plotGainIntegrationComparison(log, der, gain_name, loop_type, pp)
    % Function to handle the plotting of different gains for inner and outer loop
    % and to compare the integration of the adaptive gains between onboard
    % and offline using MATLAB's cumtrapz
    % Inputs:
    % - log: the log data
    % - der: the derivative log data
    % - gain_name: string, name of the gain ('K_hat_x', 'K_hat_r', etc.)
    % - loop_type: string, either 'inner_loop' or 'outer_loop'
    % - pp: plot properties (font size, axis limits, etc.)

    % Extract the gain from the log and derivative log dynamically
    eval(['gain_data = log.' loop_type '.' gain_name ';']);
    eval(['gain_dot_data = der.' loop_type '.' gain_name '_dot;']);
    
    % Initialize matrices for the gain and its derivative
    num_elements = numel(fieldnames(gain_data));
    gain_matrix = zeros(num_elements, length(log.time));
    gain_dot_matrix = zeros(num_elements, length(log.time));
    
    % Fill the gain_matrix and gain_dot_matrix
    for ii = 1:length(log.time)
        fieldnames_gain = fieldnames(gain_data);
        for jj = 1:num_elements
            gain_matrix(jj, ii) = gain_data.(fieldnames_gain{jj})(ii);
            gain_dot_matrix(jj, ii) = gain_dot_data.(fieldnames_gain{jj})(ii);
        end
    end
    
    % Find the indices of columns in the gain_dot_matrix that contain NaN
    cols_with_nan = any(isnan(gain_dot_matrix), 1);

    % Remove columns with NaN from gain_dot_matrix
    gain_dot_clean = gain_dot_matrix(:, ~cols_with_nan);

    % Remove corresponding rows from time (since time is a row vector for cumtrapz)
    time = log.time(~cols_with_nan)';

    % Perform the cumulative trapezoidal integration on the cleaned data
    gain_integrated = cumtrapz(time, gain_dot_clean, 2);

    %% PLOTTING

    % Number of rows in gain_matrix (for each state)
    num_states = size(gain_matrix, 1);

    % Number of subplots per figure (3 per window)
    plots_per_fig = 3;

    % Total number of figures needed
    num_figs = ceil(num_states / plots_per_fig);

    % Loop over each figure
    for fig_num = 1:num_figs
        set(figure, 'Color', 'white', 'WindowState', 'maximized');

        % Calculate which states (rows) to plot in this figure
        first_state = (fig_num - 1) * plots_per_fig + 1;
        last_state = min(fig_num * plots_per_fig, num_states);

        % Plot each state in the current figure
        for state = first_state:last_state
            subplot(plots_per_fig, 1, state - first_state + 1);

            % Plot original gain_matrix
            plot(time, gain_matrix(state, ~cols_with_nan), 'b', 'LineWidth', 1.5);
            hold on;

            % Plot integrated gain_integrated
            plot(time, gain_integrated(state, :), 'r--', 'LineWidth', 1.5);

            % Add title and labels for each subplot
            title(['State ' num2str(state)], 'Interpreter', 'latex', 'fontsize', pp.font_size_title);
            xlabel('$t$ [s]', 'Interpreter', 'latex', 'fontsize', pp.font_size);
            ylabel(['$' strrep(gain_name, '_', '\_') '_{' num2str(state) '}$'], 'Interpreter', 'latex', 'fontsize', pp.font_size);

            % Add legend
            legend({'Original', 'Integrated'}, 'Interpreter', 'latex', 'fontsize', pp.font_size, 'Location', 'best');

            % Grid for better visualization
            grid on;
            hold off;
        end

        % Adjust layout and add a figure title
        sgtitle(['Comparison of $' strrep(gain_name, '_', '\_') '$ ' strrep(loop_type, '_', '\_') ' - Original vs Integrated (Figure ' num2str(fig_num) ')'], ...
            'Interpreter', 'latex', 'fontsize', pp.font_size_title);
    end
end

