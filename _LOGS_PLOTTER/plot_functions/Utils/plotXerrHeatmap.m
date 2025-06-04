function plotXerrHeatmap(debug, pp)
    % Inputs:
    % - debug: structure containing time and xerr data
    % - pp: plot properties (font size, etc.)

    % Extract time and xerr data
    time = debug.time;
    xerr = debug.xerr;

    % Extract min and max values for the color bar from the matrix
    min_value = min(xerr(:));
    max_value = max(xerr(:));

    % Create a figure
    figure('Color', 'white', 'WindowState', 'maximized');
    
    % Create the heatmap with proper axis limits and spacing
    imagesc(time, 1:size(xerr, 2), xerr');  % Transpose xerr to match dimensions
    
    % Enhance the appearance of the heatmap
    set(gca, 'YTick', 1:size(xerr, 2), 'YTickLabel', 1:size(xerr, 2), 'TickLabelInterpreter', 'latex');
    set(gca, 'FontSize', pp.font_size);  % Set font size based on provided plot properties
    
    % Add colorbar with annotations
    c = colorbar;

    % Adjust color axis to the actual min and max values in the matrix
    clim([min_value max_value]);

    colormap jet;  % Use 'jet' colormap for better visualization
    ylabel(c, 'Error Magnitude', 'Interpreter', 'latex', 'fontsize', pp.font_size);  % Label the colorbar
    c.FontSize = pp.font_size;  % Set font size for the colorbar
    
    % Add labels and title
    xlabel('$t$ [s]', 'Interpreter', 'latex', 'fontsize', pp.font_size);
    ylabel('Error Index', 'Interpreter', 'latex', 'fontsize', pp.font_size);
    title('Error Heatmap over Time', 'Interpreter', 'latex', 'fontsize', pp.font_size_title);
    
    % Add grid for better visualization
    grid on;
    
    % Set axis properties for clearer view
    axis tight;
    ylim([0.5 size(xerr, 2) + 0.5]);  % Adjust y-limits to give some padding
end
