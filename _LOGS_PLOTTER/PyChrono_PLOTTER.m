clear
close all
clc

%%

% Define global propertries

% Set overall properties for plots and figures
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(groot, 'defaultAxesFontSize', 20);

% Generate a path string including all subdirectories of plot_functions
addpath(genpath('.\plot_functions'));
addpath(genpath('.\pychrono'));

% ==============================================================================
% Define the folder name 
pp.folder_name = '20250604';  

% Define the controller folder name
pp.folder_controller = 'MRAC';

% Define the workspace filename
pp.workspace_filename = 'workspace_log_20250604_102913.mat';

% Set flag to true to automatically load the most recent workspace
% contained in pp.folder_name
pp.auto_load_last_workspace = true;
% ==============================================================================

% Load the workspace
pp = PyC_loadWorkspace(pp);

% Plot properties
pp.font_size = 20;
pp.font_size_title = 22;

pp.x_lim_min = 0;
% pp.x_lim_min = 10;
pp.x_lim_max = 23.5;
% pp.x_lim_max = log.time(end);

% Compute derived values from log
der = PyC_computeDerivedValues(log);
if (pp.folder_controller == "FunnelMRAC")
    der = PyC_computeDerivedValues_FunMRAC(log, der, gains);
elseif (pp.folder_controller == "PID")
    der = PyC_computeDerivedValues_PID(log, der);
end
 

%% Plot thrust vs time X8-COPTER
plotThrustX8copter(log, der, pp);

%% Plot position vs time
plotPosition(log, der, pp);

%% Plot velocity vs time
plotVelocity(log, der, pp);

%% Plot Euler angles vs time
plotEulerAngles(log, der, pp);

%% Plot angles derivatives vs time
plotAngularRates(log, der, pp);

%% Plot angular velocities vs time
plotAngularVelocities(log, der, pp);

%% Plot OUTER LOOP r_cmd
plotOUTLrcmd(log, der, pp);

%% Plot INNER LOOP r_cmd
plotINNLrcmd(log, der, pp);

%% Plot virtual translational force input
plotVirtualTransForceInput(log, der, pp);

%% 3D PLOT
plot3Dposition(log, der, pp);

%% Plot Torque Control Inputs U2, U3, U4
plotTorqueControlInput(log, der, pp);

%% Plot OUTER LOOP norm of tracking error
plotOUTLnormTrackingError(log, der, pp);

%% Plot INNER LOOP norm of tracking error
plotINNLnormTrackingError(log, der, pp);

%% Plot OUTER LOOP FUNNEL variables
plotOUTLfunnel(log, der, pp);

%% Plot OUTER LOOP FUNNEL xi function
plotOUTLfunnelXiFunction(log, der, pp);

%% Interactive Plot OUTER LOOP FUNNEL variables
interactivePlotOUTLfunnel(log, der, pp);