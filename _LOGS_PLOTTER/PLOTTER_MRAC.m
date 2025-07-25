clear
close all
clc

%% Define global propertries

% Set overall properties for plots and figures
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(groot, 'defaultAxesFontSize', 20);

% Generate a path string including all subdirectories of plot_functions
addpath(genpath('.\plot_functions'));

% ==============================================================================
% Define the folder name 
pp.folder_name = '20240729';  

% Define the controller folder name
pp.folder_controller = 'MRAC';

% Define the workspace filename
pp.workspace_filename = 'workspace_log_20240729_163324.mat';

% Set flag to true to automatically load the most recent workspace
% contained in pp.folder_name
pp.auto_load_last_workspace = false;
% ==============================================================================

% Load the workspace
pp = loadWorkspace(pp);

% Plot properties
pp.font_size = 20;
pp.font_size_title = 22;

pp.x_lim_min = 10;
% pp.x_lim_max = 20;
pp.x_lim_max = log.time(end);
 

%% Plot thrust vs time QUADCOPTER
% plotThrustQuadcopter(log, der, pp);

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

%% Plot angles double derivatives vs time
plotAnglesDoubleDerivatives(log, der, pp);

%% Plot angular velocities vs time
plotAngularVelocities(log, der, pp);

%% Plot INNER LOOP omega_ref_dot
plotINNLomegaRefDot(log, der, pp);

%% Plot OUTER LOOP r_cmd
plotOUTLrcmd(log, der, pp);

%% Plot INNER LOOP r_cmd
plotINNLrcmd(log, der, pp);

%% 3D PLOT
plot3Dposition(log, der, pp);

%% Plot translational position error vs time 
plotTransPosError(log, der, pp);

%% Plot angular error vs time 
plotAngularError(log, der, pp);

%% Plot algorithm execution/computational time vs time 
plotAlgorithmExeTime(log, der, pp);

%% Plot virtual translational force input
plotVirtualTransForceInput(log, der, pp);

%% Plot virtual translational force input COMPARISON
plotVirtualTransForceInputComp(log, der, pp);

%% Plot Torque Control Inputs U2, U3, U4
plotTorqueControlInput(log, der, pp);

%% Plot Torque Control Inputs U2, U3, U4 COMPARISON
plotTorqueControlInputComp(log, der, pp);

%% Plot OUTER LOOP Baseline Proportional control input
plotOUTLbaselineP(log, der, pp);

%% Plot OUTER LOOP Baseline Integral control input
plotOUTLbaselineI(log, der, pp);

%% Plot OUTER LOOP Baseline Derivative control input
plotOUTLbaselineD(log, der, pp);

%% Plot OUTER LOOP Baseline Dynamic inversion control input
plotOUTLbaselineDynInv(log, der, pp);

%% Plot INNER LOOP Baseline Proportional control input
plotINNLbaselineP(log, der, pp);

%% Plot INNER LOOP Baseline Integral control input
plotINNLbaselineI(log, der, pp);

%% Plot INNER LOOP Baseline Derivative control input
plotINNLbaselineD(log, der, pp);

%% Plot INNER LOOP Baseline Dynamic inversion control input
plotINNLbaselineDynInv(log, der, pp);

%% Plot INNER LOOP Feedforward acceleration term control input
plotINNLbaselineFF(log, der,pp);

%% Plot OUTER LOOP Adaptive Gain K_hat_x
plotOUTLKhatX(log, der, pp);

%% Plot OUTER LOOP Adaptive Gain K_hat_r
plotOUTLKhatR(log, der, pp);

%% Plot OUTER LOOP Adaptive Gain Theta_hat
plotOUTLThetaHat(log, der, pp);

%% Plot INNER LOOP Adaptive Gain K_hat_x
plotINNLKhatX(log, der, pp);

%% Plot INNER LOOP Adaptive Gain K_hat_r
plotINNLKhatR(log, der, pp);

%% Plot INNER LOOP Adaptive Gain Theta_hat
plotINNLThetaHat(log, der, pp);

%% Plot OUTER LOOP u_adaptive_K_hat_x
plotOUTLuAdaptiveKhatX(log, der, pp);

%% Plot OUTER LOOP u_adaptive_K_hat_r
plotOUTLuAdaptiveKhatR(log, der, pp);

%% Plot OUTER LOOP u_adaptive_Theta_hat
plotOUTLuAdaptiveThetaHat(log, der, pp);

%% Plot INNER LOOP u_adaptive_K_hat_x
plotINNLuAdaptiveKhatX(log, der, pp);

%% Plot INNER LOOP u_adaptive_K_hat_r
plotINNLuAdaptiveKhatR(log, der, pp);

%% Plot INNER LOOP u_adaptive_Theta_hat
plotINNLuAdaptiveThetaHat(log, der, pp);

%% Plot OUTER LOOP norm of tracking error
plotOUTLnormTrackingError(log, der, pp);

%% Plot INNER LOOP norm of tracking error
plotINNLnormTrackingError(log, der, pp);

%% Plot OUTER LOOP Adaptive Gain derivative K_hat_x_dot
plotOUTLKhatXdot(log, der, pp);

%% Plot OUTER LOOP Adaptive Gain derivative K_hat_r_dot
plotOUTLKhatRdot(log, der, pp);

%% Plot OUTER LOOP Adaptive Gain derivative Theta_hat_dot
plotOUTLThetaHatdot(log, der, pp);

%% Plot INNER LOOP Adaptive Gain derivative K_hat_x_dot
plotINNLKhatXdot(log, der, pp);

%% Plot INNER LOOP Adaptive Gain derivative K_hat_r_dot
plotINNLKhatRdot(log, der, pp);

%% Plot INNER LOOP Adaptive Gain derivative Theta_hat_dot
plotINNLThetaHatdot(log, der, pp);

%% Plot OUTER LOOP dead zone modification value
plotOUTLdeadZoneModValue(log, der, pp);

%% Plot INNER LOOP dead zone modification value
plotINNLdeadZoneModValue(log, der, pp);

%% MOCAP
%===============================================================================
% MOCAP
%===============================================================================
%% Plot MOCAP position vs time
plotMOCAPposition(log, der, pp, mocap);

%% Plot MOCAP velocity vs time
plotMOCAPvelocity(log, der, pp, mocap);

%% Plot MOCAP angles vs time
plotMOCAPeulerAngles(log, der, pp, mocap);

%% Plot MOCAP quaternion vs time
plotMOCAPquaternion(log, der, pp, mocap);



