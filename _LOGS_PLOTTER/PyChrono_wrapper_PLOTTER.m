%% PyChrono Wrapper PLOTTER
clear; clc; close all;

% Add paths
addpath(genpath('.\plot_functions'));
addpath(genpath('.\functions'));
addpath(genpath('.\pychrono'));

%% =========================================================================
% Choose folder where wrapper workspace logs are stored
start_path = fullfile(pwd, '..', 'pychrono', 'wrapper');
wrapper_folder = uigetdir(start_path, 'Select Wrapper "workspaces" Folder');
if wrapper_folder == 0
    error('No folder selected.');
end

fprintf("Loading all .mat workspaces from: %s\n", wrapper_folder);

% List all .mat files in the selected folder
files = dir(fullfile(wrapper_folder, '*.mat'));
nFiles = length(files);

if nFiles == 0
    error('No .mat workspace files found in the selected folder.');
end

workspaces = struct([]);

% Load and compute derived values
for i = 1:nFiles
    fname = fullfile(wrapper_folder, files(i).name);
    fprintf("\n Loading [%d/%d] — %s\n", i, nFiles, files(i).name);

    tmp = load(fname);

    % Extract fields
    log     = tmp.log;
    sim_cfg = tmp.sim_cfg;
    gains   = tmp.gains;

    % Compute derived values (MRAC)
    der = struct();
    der = PyC_computeDerivedValues_MRAC(log, der);

    % Store everything
    workspaces(i).filename = files(i).name;
    workspaces(i).log      = log;
    workspaces(i).sim_cfg  = sim_cfg;
    workspaces(i).gains    = gains;
    workspaces(i).der      = der;

    % Sorting key = final L2 tracking error
    workspaces(i).sort_key = der.outer_loop.tracking_error_L2norm(end);
end

% Sort by the final L2 norm tracking error
[~, idx] = sort([workspaces.sort_key]);  % ascending = best first
workspaces = workspaces(idx);

%% Plots

% param_name = "delta_ebci_tran";
% param_name = "H_max_funnel_tran";
% param_name = "delta_2_funnel_tran";
% param_name = "delta_3_funnel_tran";
% param_name = "initial_cond_diameter_funnel_tr";
param_name = "e_min_funnel_tran";

l2_threshold = 10;

plot_sortkey_vs_param(workspaces, param_name, false, l2_threshold);

[p, y_model] = plot_sortkey_with_regression( ...
    workspaces, ...
    param_name, ...
    6, false, l2_threshold);

[best_degree, p_best] = plot_sortkey_auto_poly( ...
    workspaces, ...
    param_name, ...
    6, ...
    false, ...
    5, l2_threshold);


%% Auxilliary functions

function plot_sortkey_vs_param(workspaces, param_name, use_log_x, l2_threshold)
% plot_sortkey_vs_param
% Plots sort_key as a function of a given parameter name.
% The parameter is searched recursively inside each workspace.
%
% Inputs:
%   workspaces    : struct array
%   param_name    : string (e.g. "H_max_funnel_tran")
%   use_log_x     : optional boolean (default false)
%   l2_threshold  : optional scalar threshold for L2-norm filtering (default 0.04)

    if nargin < 3 || isempty(use_log_x)
        use_log_x = false;
    end

    if nargin < 4 || isempty(l2_threshold)
        l2_threshold = 0.04;
    end

    if isempty(workspaces)
        error('Input "workspaces" is empty.');
    end

    n = numel(workspaces);

    x_vals    = zeros(n,1);
    sort_keys = zeros(n,1);

    for i = 1:n

        % ---- Find parameter recursively ----
        try
            x_vals(i) = find_field_recursive(workspaces(i), param_name);
        catch
            error('Field "%s" not found in workspace %d', param_name, i);
        end

        % ---- Extract sort_key ----
        sort_keys(i) = workspaces(i).sort_key;
    end

    % ---- Sort by parameter ----
    [x_sorted, idx] = sort(x_vals);
    sort_keys_sorted = sort_keys(idx);

    % ---- Apply L2-norm threshold ----
    mask = sort_keys_sorted <= l2_threshold;
    x_sorted = x_sorted(mask);
    sort_keys_sorted = sort_keys_sorted(mask);

    % ---- Plot ----
    set(figure,'Color','white','WindowState','maximized'); 
    hold on;

    plot(x_sorted, sort_keys_sorted, ...
         'LineWidth', 1.8, 'MarkerSize', 6);

    grid on;

    if use_log_x
        set(gca, 'XScale', 'log');
    end

    xlabel(param_name, 'Interpreter', 'none');
    ylabel('Outer Loop $\mathcal{L}_2$-Norm Tracking Error [-]', ...
           'Interpreter','latex');
end

function [p, model] = plot_sortkey_with_regression(workspaces, param_name, ...
                                                   poly_degree, use_log_x, ...
                                                   l2_threshold)
% plot_sortkey_with_regression
% Plots sort_key vs parameter and fits polynomial regression.
%
% Inputs:
%   workspaces    : struct array
%   param_name    : string (e.g. "H_max_funnel_tran")
%   poly_degree   : polynomial order (default = 2)
%   use_log_x     : logical (default = false)
%   l2_threshold  : scalar threshold for L2-norm filtering (default = 0.04)
%
% Outputs:
%   p     : polynomial coefficients
%   model : fitted values evaluated on sorted data

    if nargin < 3 || isempty(poly_degree)
        poly_degree = 2;
    end
    if nargin < 4 || isempty(use_log_x)
        use_log_x = false;
    end
    if nargin < 5 || isempty(l2_threshold)
        l2_threshold = 0.04;
    end

    if isempty(workspaces)
        error('Input "workspaces" is empty.');
    end

    n = numel(workspaces);

    x_vals    = zeros(n,1);
    sort_keys = zeros(n,1);

    for i = 1:n
        x_vals(i) = find_field_recursive(workspaces(i), param_name);
        sort_keys(i) = workspaces(i).sort_key;
    end

    % -------- Sort --------
    [x_sorted, idx] = sort(x_vals);
    y_sorted = sort_keys(idx);

    % -------- Apply L2 threshold --------
    mask = y_sorted <= l2_threshold;
    x_sorted = x_sorted(mask);
    y_sorted = y_sorted(mask);

    % -------- Log transform if requested --------
    if use_log_x
        x_fit = log10(x_sorted);
    else
        x_fit = x_sorted;
    end

    % -------- Polynomial regression --------
    p = polyfit(x_fit, y_sorted, poly_degree);
    y_model = polyval(p, x_fit);

    % -------- Plot --------
    set(figure,'Color','white','WindowState','maximized'); 
    hold on;

    plot(x_sorted, y_sorted, 'o', ...
         'LineWidth',1.5, 'MarkerSize',6);

    plot(x_sorted, y_model, ...
         'LineWidth',2.2);

    grid on;

    if use_log_x
        set(gca,'XScale','log');
    end

    xlabel(param_name,'Interpreter','none');
    ylabel('Outer Loop $\mathcal{L}_2$-Norm Tracking Error [-]', ...
           'Interpreter','latex');

    legend('Data','Polynomial Fit','Location','best');

    model = y_model;
end

function [best_degree, p_best] = plot_sortkey_auto_poly( ...
        workspaces, param_name, max_degree, use_log_x, ...
        kfold, l2_threshold)

    if nargin < 3 || isempty(max_degree)
        max_degree = 6;
    end
    if nargin < 4 || isempty(use_log_x)
        use_log_x = false;
    end
    if nargin < 5 || isempty(kfold)
        kfold = 5;
    end
    if nargin < 6 || isempty(l2_threshold)
        l2_threshold = 0.04;
    end

    % --- Extract data ---
    n = numel(workspaces);
    x_vals    = zeros(n,1);
    sort_keys = zeros(n,1);

    for i = 1:n
        x_vals(i) = find_field_recursive(workspaces(i), param_name);
        sort_keys(i) = workspaces(i).sort_key;
    end

    [x_sorted, idx] = sort(x_vals);
    y_sorted = sort_keys(idx);

    % --- Apply L2 threshold ---
    mask = y_sorted <= l2_threshold;
    x_sorted = x_sorted(mask);
    y_sorted = y_sorted(mask);

    if isempty(x_sorted)
        error('No data points remain after applying L2 threshold.');
    end

    % --- Optional log transform ---
    if use_log_x
        x_fit = log10(x_sorted);
    else
        x_fit = x_sorted;
    end

    N = length(x_fit);

    if N < kfold
        error('Number of samples (%d) must be >= kfold (%d).', N, kfold);
    end

    % --- Cross-validation ---
    cv = cvpartition(N, 'KFold', kfold);
    mse = zeros(max_degree,1);

    for d = 1:max_degree
        mse_fold = zeros(kfold,1);

        for k = 1:kfold
            train_idx = training(cv,k);
            test_idx  = test(cv,k);

            p = polyfit(x_fit(train_idx), y_sorted(train_idx), d);
            y_pred = polyval(p, x_fit(test_idx));

            mse_fold(k) = mean((y_sorted(test_idx) - y_pred).^2);
        end

        mse(d) = mean(mse_fold);
    end

    % --- Select best degree ---
    [~, best_degree] = min(mse);

    % --- Fit final model ---
    p_best = polyfit(x_fit, y_sorted, best_degree);
    y_model = polyval(p_best, x_fit);

    % --- Plot ---
    set(figure,'Color','white','WindowState','maximized'); 
    hold on;

    plot(x_sorted, y_sorted, 'o', 'MarkerSize',6);
    plot(x_sorted, y_model, 'LineWidth',2);

    grid on;

    if use_log_x
        set(gca,'XScale','log');
    end

    xlabel(param_name,'Interpreter','none');
    ylabel('Outer Loop $\mathcal{L}_2$-Norm Tracking Error [-]', ...
           'Interpreter','latex');

    legend('Data','Best Polynomial Fit','Location','best');

    fprintf('Selected polynomial degree: %d\n', best_degree);
end


% -------------------------------------------------
function value = find_field_recursive(s, field_name)

    fields = fieldnames(s);

    for i = 1:numel(fields)
        if strcmp(fields{i}, field_name)
            value = s.(fields{i});
            return;
        end

        if isstruct(s.(fields{i}))
            try
                value = find_field_recursive(s.(fields{i}), field_name);
                return;
            catch
            end
        end
    end

    error('Field "%s" not found.', field_name);
end

