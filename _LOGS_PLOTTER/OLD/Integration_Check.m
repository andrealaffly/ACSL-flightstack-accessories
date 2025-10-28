clear
close all
clc

% Define global propertries

% Set overall properties for plots and figures
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(groot, 'defaultAxesFontSize', 20);

% Generate a path string including all subdirectories of plot_functions
addpath(genpath('.\plot_functions'));

% ==============================================================================
% Define the folder name 
pp.folder_name = '20241011';  

% Define the controller folder name
pp.folder_controller = 'TwoLayerMRAC';

% Define the workspace filename
pp.workspace_filename = 'workspace_log_20241010_100828.mat';

% Set flag to true to automatically load the most recent workspace
% contained in pp.folder_name
pp.auto_load_last_workspace = true;
% ==============================================================================

% % Interactive dialog to select the workspace
% pp = getUserInputs();

% Load the workspace
pp = loadWorkspace(pp);

% Plot properties
pp.font_size = 20;
pp.font_size_title = 22;

pp.x_lim_min = 10;
% pp.x_lim_max = 23.5;
pp.x_lim_max = log.time(end);

%%

% OUTER LOOP
% K_hat_x outer loop
plotGainIntegrationComparison(log, der, 'K_hat_x', 'outer_loop', pp);

% K_hat_r outer loop
plotGainIntegrationComparison(log, der, 'K_hat_r', 'outer_loop', pp);

% Theta_hat outer loop
plotGainIntegrationComparison(log, der, 'Theta_hat', 'outer_loop', pp);

% K_hat_g outer loop
plotGainIntegrationComparison(log, der, 'K_hat_g', 'outer_loop', pp);

% INNER LOOP
% K_hat_x inner loop
plotGainIntegrationComparison(log, der, 'K_hat_x', 'inner_loop', pp);

% K_hat_r inner loop
plotGainIntegrationComparison(log, der, 'K_hat_r', 'inner_loop', pp);

% Theta_hat inner loop
plotGainIntegrationComparison(log, der, 'Theta_hat', 'inner_loop', pp);

% K_hat_g inner loop
plotGainIntegrationComparison(log, der, 'K_hat_g', 'inner_loop', pp);



