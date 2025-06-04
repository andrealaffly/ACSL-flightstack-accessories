function plotXerrTime(debug, pp)
    % Inputs:
    % - debug: structure containing time and xerr data
    % - pp: plot properties (font size, etc.)
    
    % Extract time and xerr data
    time = debug.time;
    xerr = debug.xerr;
    
    % Determine the number of error states
    num_errors = size(xerr, 2);
    
    % Number of errors to plot per figure
    errors_per_fig = 5;  % Adjust this to your needs
    
    % Calculate the total number of figures needed
    num_figs = ceil(num_errors / errors_per_fig);
    
    % Loop over each figure
    for fig_num = 1:num_figs
        figure('Color', 'white', 'WindowState', 'maximized');
        
        % Calculate which errors to plot in this figure
        first_err = (fig_num - 1) * errors_per_fig + 1;
        last_err = min(fig_num * errors_per_fig, num_errors);
        
        % Plot each error in the current figure
        for err_idx = first_err:last_err
            subplot(errors_per_fig, 1, err_idx - first_err + 1);
            plot(time, xerr(:, err_idx), 'LineWidth', 1.5);
            
            % Add title and labels
            title(['Error ' num2str(err_idx)], 'Interpreter', 'latex', 'fontsize', pp.font_size_title);
            xlabel('$t$ [s]', 'Interpreter', 'latex', 'fontsize', pp.font_size);
            ylabel(['$x_{err' num2str(err_idx) '}$'], 'Interpreter', 'latex', 'fontsize', pp.font_size);
            
            % Grid for better visualization
            grid on;
        end
        
        % Add a figure-wide title
        sgtitle(['Error States ' num2str(first_err) ' to ' num2str(last_err)], 'Interpreter', 'latex', 'fontsize', pp.font_size_title);
    end
end
