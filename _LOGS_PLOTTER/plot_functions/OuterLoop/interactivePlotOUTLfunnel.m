function interactivePlotOUTLfunnel(log, der, pp)
    % Interactive Outer Loop Funnel plot with checkboxes and LaTeX labels

    % Create uifigure with white background and fixed size
    fig = uifigure('Name', 'Outer Loop Funnel Plot', ...
                   'Color', [1 1 1], ...
                   'Position', [100, 100, 1200, 700]);

    % Layout: left plot, right control panel
    gl = uigridlayout(fig, [1, 2]);
    gl.ColumnWidth = {'1x', 200};  % plot area + sidebar
    gl.RowHeight = {'1x'};
    gl.BackgroundColor = [1 1 1];

    % Plotting axes
    ax = uiaxes(gl);
    ax.Color = [1 1 1];
    hold(ax, 'on')
    ax.XLabel.Interpreter = 'latex';
    ax.XLabel.String = '$t$ [s]';
    ax.YLabel.Interpreter = 'latex';
    ax.YLabel.String = 'Outer loop Funnel variables [-]';
    ax.Title.Interpreter = 'latex';
    ax.Title.String = pp.folder_controller;
    ax.FontSize = pp.font_size;
    ax.Box = 'on';
    grid(ax, 'on');

    % Checkbox panel with scrollable layout
    panel = uipanel(gl, 'Title', 'Signals', 'FontWeight', 'bold', 'Scrollable', 'on');
    panel.BackgroundColor = [1 1 1];
    cbLayout = uigridlayout(panel, [20, 1]); % one layout row per checkbox+label pair
    cbLayout.RowHeight = repmat({'fit'}, 1, 20);
    cbLayout.Scrollable = 'on';
    cbLayout.BackgroundColor = [1 1 1];
    cbLayout.Padding = [0 0 0 0];  % Remove any internal padding


    % Define plot colors
    colors = struct( ...
        'xi',           [0.8500, 0.3250, 0.0980], ...
        'eta',          [0, 0.4470, 0.7410], ...
        'eta_dot',      [0, 0, 1], ...
        'Ve_function',  [1, 0, 0], ...
        'lambda_sat',   [0, 1, 0], ...
        'sigma_nom',    [0.9290, 0.6940, 0.1250], ...
        'sigma_ideal',  [0.6350, 0.0780, 0.1840], ...
        'H_function',   [0, 0, 0], ...
        'diameter',     [0.2, 0.7, 0.7], ...
        'eMe',          [0.8, 0.5, 0.9] ...
    );

    % Signals: {field, label, linestyle, source}
    signals = {
        'xi',           '$\xi(t)$',               '--', log.outer_loop.funnel;
        'eta',          '$\eta(t)$',              '--', log.outer_loop.funnel;
        'eta_dot',      '$\dot{\eta}(t)$',        ':',  log.outer_loop.funnel;
        'Ve_function',  '$V_e(t,e)$',             '--', log.outer_loop.funnel;
        'lambda_sat',   '$\lambda_{\rm sat}(t,e)$','--',log.outer_loop.funnel;
        'sigma_nom',    '$\sigma_{\rm nom}(t,e)$',':',  log.outer_loop.funnel;
        'sigma_ideal',  '$\sigma_{\rm ideal}(t)$','--', log.outer_loop.funnel;
        'H_function',   '$H(t,e)$',               ':',  log.outer_loop.funnel;
        'diameter',     'Funnel Diameter',        ':',  der.outer_loop.funnel;
        'eMe',          '$e^{\rm T}Me$',          '--', der.outer_loop.funnel;
    };

    handles = struct();
    rowCount = 0;

    for i = 1:size(signals, 1)
        key = signals{i, 1};
        label = signals{i, 2};
        style = signals{i, 3};
        source = signals{i, 4};

        if isfield(source, key)
            h = plot(ax, log.time, source.(key), ...
                'LineStyle', style, ...
                'Color', colors.(key), ...
                'DisplayName', label, ...
                'LineWidth', 1.5);
            handles.(key) = h;

            % Sub-layout for checkbox + LaTeX label
            row = uigridlayout(cbLayout, [1, 2]);
            row.BackgroundColor = [1 1 1];
            row.ColumnWidth = {22, '1x'}; % checkbox + label
            row.Layout.Row = i;

            cb = uicheckbox(row, ...
                'Value', true, ...
                'Tag', key);

            lbl = uilabel(row, ...
                'Text', label, ...
                'Interpreter', 'latex', ...
                'FontSize', 12);
            lbl.HorizontalAlignment = 'left';  % Ensure left alignment
            lbl.VerticalAlignment = 'center'; % Center vertically with checkbox

            % Link checkbox to visibility
            cb.ValueChangedFcn = @(src, ~) set(handles.(src.Tag), 'Visible', logicalToOnOff(src.Value));
            rowCount = rowCount + 1;
        end
    end

    % Plot e_min if available
    if isfield(der.outer_loop.funnel, 'e_min')
        h = yline(ax, der.outer_loop.funnel.e_min, '-.', 'Color', [0.3, 0.3, 0.3], ...
            'LineWidth', 2.0, 'DisplayName', '$e_{\min}$');
        handles.e_min = h;

        row = uigridlayout(cbLayout, [1, 2]);
        row.BackgroundColor = [1 1 1];
        row.ColumnWidth = {22, '1x'};
        row.Layout.Row = rowCount + 1;

        cb = uicheckbox(row, ...
            'Value', true, ...
            'Tag', 'e_min');

        lbl = uilabel(row, ...
            'Text', '$e_{\min}$', ...
            'Interpreter', 'latex', ...
            'FontSize', 12);
        lbl.HorizontalAlignment = 'left';  % Ensure left alignment
        lbl.VerticalAlignment = 'center'; % Center vertically with checkbox

        cb.ValueChangedFcn = @(src, ~) set(handles.(src.Tag), 'Visible', logicalToOnOff(src.Value));
    end

    % Set x-axis limits
    xlim(ax, [pp.x_lim_min, pp.x_lim_max]);

    % Add legend
    legend(ax, 'show', 'Location', 'best', 'Interpreter', 'latex');
end

function out = logicalToOnOff(val)
    if val
        out = 'on';
    else
        out = 'off';
    end
end
