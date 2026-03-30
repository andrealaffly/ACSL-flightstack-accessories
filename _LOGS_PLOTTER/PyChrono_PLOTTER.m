clear
close all
clc

%% =========================================================================
% CONFIGURATION: choose how to load the workspace
use_manual_selection = false;   % <--- SET THIS TO false TO USE THE LEGACY METHOD
% =========================================================================

% Global plotting properties
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(groot, 'defaultAxesFontSize', 20);

% Add paths
addpath(genpath('.\plot_functions'));
addpath(genpath('.\functions'));
addpath(genpath('.\pychrono'));

% =========================================================================
% WORKSPACE LOADING
% =========================================================================

if use_manual_selection
    % -------------------------------------------------------------
    % MANUAL SELECTION MODE
    % -------------------------------------------------------------
    start_path = fullfile(pwd, '..', 'pychrono', 'wrapper');
    [sel_file, sel_path] = uigetfile(fullfile(start_path, '**', '*.mat'), ...
        'Select a workspace file');

    if sel_file == 0
        error('No workspace selected. Set use_manual_selection = false to use pp.* loading.');
    end

    fullpath = fullfile(sel_path, sel_file);
    fprintf("Loading manually selected workspace:\n   %s\n\n", fullpath);

    tmp = load(fullpath);
    log     = tmp.log;
    gains   = tmp.gains;
    sim_cfg = tmp.sim_cfg;

    pp.folder_controller = string(sim_cfg.mission_config.controller_type);

else
    % -------------------------------------------------------------
    % LEGACY MODE (original folder + filename fields)
    % -------------------------------------------------------------
    pp.folder_name = '20260210';
    pp.folder_controller = 'FunnelTwoLayerMRAC';
    pp.workspace_filename = 'workspace_log_20260210_194602.mat';
    pp.auto_load_last_workspace = false;

    pp = PyC_loadWorkspace(pp);

    % log, gains, sim_cfg are loaded by PyC_loadWorkspace
end


% Plot properties
pp.font_size = 20;
pp.font_size_title = 22;

pp.x_lim_min = 0;
% pp.x_lim_min = 10;
% pp.x_lim_max = 21.5;
pp.x_lim_max = log.time(end);

% Compute derived values from log
der = PyC_computeDerivedValues(log);
if (pp.folder_controller == "PID")
    der = PyC_computeDerivedValues_PID(log, der);
elseif (pp.folder_controller == "MRAC") || ...
       (pp.folder_controller == "NonAdaptiveEBCI") || ...
       (pp.folder_controller == "TwoLayerMRAC") || ...
       (pp.folder_controller == "HybridMRAC") || ...
       (pp.folder_controller == "HybridTwoLayerMRAC")
    der = PyC_computeDerivedValues_MRAC(log, der);
elseif (pp.folder_controller == "FunnelMRAC") || ...
       (pp.folder_controller == "FunnelTwoLayerMRAC")
    der = PyC_computeDerivedValues_FunMRAC(log, der, gains);
end


%% Plot thrust vs time X8-COPTER
plotThrustX8copter(log, der, pp);

%% Plot position vs time
plotPosition(log, der, pp);

%% Plot velocity vs time
plotVelocity(log, der, pp);

%% Plot position and velocity error norm
plotOUTLposVelErrorNorms(log, der, pp);

%% Plot position and velocity error L2-norm
plotOUTLposVelErrorL2Norms(log, der, pp);

%% Plot Euler angles vs time
plotEulerAngles(log, der, pp);

%% Plot Euler angles errors
plotINNLEulerAnglesErrors(log, der, pp);

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

%% Plot virtual translational force input COMPARISON
plotVirtualTransForceInputComp(log, der, pp);

%% 3D PLOT
plot3Dposition(log, der, pp);

%% Plot OUTER LOOP Adaptive Gain K_hat_x
plotOUTLKhatX(log, der, pp, gains);

%% Plot OUTER LOOP Adaptive Gain K_hat_r
plotOUTLKhatR(log, der, pp, gains);

%% Plot OUTER LOOP Adaptive Gain Theta_hat
plotOUTLThetaHat(log, der, pp, gains);

%% Plot OUTER LOOP Adaptive Gain K_hat_g TWO-LAYER
plotOUTLKhatG(log, der, pp, gains);

%% Plot INNER LOOP Adaptive Gain K_hat_x
plotINNLKhatX(log, der, pp, gains);

%% Plot INNER LOOP Adaptive Gain K_hat_r
plotINNLKhatR(log, der, pp, gains);

%% Plot INNER LOOP Adaptive Gain Theta_hat
plotINNLThetaHat(log, der, pp, gains);

%% Plot INNER LOOP Adaptive Gain K_hat_g TWO-LAYER
plotINNLKhatG(log, der, pp, gains);

%% Plot Torque Control Inputs U2, U3, U4
plotTorqueControlInput(log, der, pp);

%% Plot OUTER LOOP norm of tracking error
plotOUTLnormTrackingError(log, der, pp);

%% Plot INNER LOOP norm of tracking error
plotINNLnormTrackingError(log, der, pp);

%% Plot OUTER LOOP L2-norm of tracking error
plotOUTLnormL2TrackingError(log, der, pp);

%% Plot OUTER LOOP norm of tracking error wrt User-Defined Trajectory
plotOUTLnormTrackingErrorUserDefTraj(log, der, pp);

%% Plot OUTER LOOP L2-norm of tracking error wrt User-Defined Trajectory
plotOUTLnormL2TrackingErrorUserDefTraj(log, der, pp);

%% Plot OUTER LOOP FUNNEL variables
plotOUTLfunnel(log, der, pp, gains);

%% Plot OUTER LOOP FUNNEL xi function
plotOUTLfunnelXiFunction(log, der, pp);

%% Interactive Plot OUTER LOOP FUNNEL variables
interactivePlotOUTLfunnel(log, der, pp, gains);


%% POSTPROCESS ============================================================
% =========================================================================

plot_single_sided_fft(der.total_thrust_motors_N, 100, pp);
plot_psd_total_thrust(der.total_thrust_motors_N, 100, pp);
% band_limited_energy_plot(der.total_thrust_motors_N, 100, pp);