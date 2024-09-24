clear
close all
clc

%% Define global propertries

% Define the folder name 
folder_name = '20240531';  

% Define the workspace filename
workspace_filename = 'workspace_log_20240531_164728.mat';

% Construct the full path to the workspace file
workspace_path = fullfile('..', folder_name, 'workspaces', workspace_filename);

% Load the specified workspace
load(workspace_path);

% Set overall properties for plots and figures
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(groot, 'defaultAxesFontSize', 20);

font_size = 20;
font_size_title = 22;

x_lim_min = 10;
% x_lim_max = 60;
x_lim_max = log.time(end);
 

%% Plot thrust vs time QUADCOPTER

% % Total thrust
% set(figure,'Color','white','WindowState','maximized')
% plot(log.time,der.total_thrust_motors_quadcopter_N,'b-','LineWidth',2)
% xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
% ylabel('Total thrust [N]','interpreter','latex','fontsize',font_size)
% title('PID','interpreter','latex','fontsize',font_size_title)
% hold off
% axis tight
% xlim([x_lim_min,x_lim_max])
% 
% % Thrust in Newton
% set(figure,'Color','white','WindowState','maximized')
% plot(log.time,log.thrust_motors_quadcopter_N.T1,'b-','LineWidth',2)
% hold on
% plot(log.time,log.thrust_motors_quadcopter_N.T2,'r-.','LineWidth',2)
% plot(log.time,log.thrust_motors_quadcopter_N.T3,'g--','LineWidth',2)
% plot(log.time,log.thrust_motors_quadcopter_N.T4,'k-','LineWidth',0.5)
% legend('$T_1(t)$','$T_2(t)$','$T_3(t)$','$T_4(t)$');
% xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
% ylabel('Thrust motor $i$ [N]','interpreter','latex','fontsize',font_size)
% title('PID','interpreter','latex','fontsize',font_size_title)
% hold off
% axis tight
% xlim([x_lim_min,x_lim_max])
% 
% % Normalized thrust
% set(figure,'Color','white','WindowState','maximized')
% plot(log.time,log.thrust_motors_quadcopter_normalized.T1,'b-','LineWidth',2)
% hold on
% plot(log.time,log.thrust_motors_quadcopter_normalized.T2,'r-.','LineWidth',2)
% plot(log.time,log.thrust_motors_quadcopter_normalized.T3,'g--','LineWidth',2)
% plot(log.time,log.thrust_motors_quadcopter_normalized.T4,'k-','LineWidth',0.5)
% legend('$T_1(t)$','$T_2(t)$','$T_3(t)$','$T_4(t)$');
% xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
% ylabel('Thrust motor $i$ [-]','interpreter','latex','fontsize',font_size)
% title('PID','interpreter','latex','fontsize',font_size_title)
% hold off
% axis tight
% xlim([x_lim_min,x_lim_max])

%% Plot thrust vs time X8-COPTER

% Total thrust
set(figure,'Color','white','WindowState','maximized')
plot(log.time,der.total_thrust_motors_N,'b-','LineWidth',2)
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Total thrust [N]','interpreter','latex','fontsize',font_size)
title('PID','interpreter','latex','fontsize',font_size_title)
hold off
axis tight
xlim([x_lim_min,x_lim_max])

% Thrust in Newton
set(figure,'Color','white','WindowState','maximized')
subplot(2,1,1)
plot(log.time,log.thrust_motors_N.T1,'b-','LineWidth',2)
hold on
plot(log.time,log.thrust_motors_N.T2,'r-.','LineWidth',2)
plot(log.time,log.thrust_motors_N.T3,'g--','LineWidth',2)
plot(log.time,log.thrust_motors_N.T4,'k-','LineWidth',0.5)
legend('$T_1(t)$','$T_2(t)$','$T_3(t)$','$T_4(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Thrust motor $i$ [N]','interpreter','latex','fontsize',font_size)
title('PID','interpreter','latex','fontsize',font_size_title)
hold off
axis tight
xlim([x_lim_min,x_lim_max])

subplot(2,1,2)
plot(log.time,log.thrust_motors_N.T5,'r-.','LineWidth',2)
hold on
plot(log.time,log.thrust_motors_N.T6,'b-','LineWidth',2)
plot(log.time,log.thrust_motors_N.T7,'k-','LineWidth',0.5)
plot(log.time,log.thrust_motors_N.T8,'g--','LineWidth',2)
legend('$T_5(t)$','$T_6(t)$','$T_7(t)$','$T_8(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Thrust motor $i$ [N]','interpreter','latex','fontsize',font_size)
hold off
axis tight
xlim([x_lim_min,x_lim_max])

% Normalized thrust
set(figure,'Color','white','WindowState','maximized')
subplot(2,1,1)
plot(log.time,log.thrust_motors_normalized.T1,'b-','LineWidth',2)
hold on
plot(log.time,log.thrust_motors_normalized.T2,'r-.','LineWidth',2)
plot(log.time,log.thrust_motors_normalized.T3,'g--','LineWidth',2)
plot(log.time,log.thrust_motors_normalized.T4,'k-','LineWidth',0.5)
legend('$T_1(t)$','$T_2(t)$','$T_3(t)$','$T_4(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Thrust motor $i$ [-]','interpreter','latex','fontsize',font_size)
title('PID','interpreter','latex','fontsize',font_size_title)
hold off
axis tight
xlim([x_lim_min,x_lim_max])

subplot(2,1,2)
plot(log.time,log.thrust_motors_normalized.T5,'r-.','LineWidth',2)
hold on
plot(log.time,log.thrust_motors_normalized.T6,'b-','LineWidth',2)
plot(log.time,log.thrust_motors_normalized.T7,'k-','LineWidth',0.5)
plot(log.time,log.thrust_motors_normalized.T8,'g--','LineWidth',2)
legend('$T_5(t)$','$T_6(t)$','$T_7(t)$','$T_8(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Thrust motor $i$ [-]','interpreter','latex','fontsize',font_size)
hold off
axis tight
xlim([x_lim_min,x_lim_max])

%% Plot position vs time

set(figure,'Color','white','WindowState','maximized')
subplot(3,1,1)
plot(log.time,log.position.x,'r-','LineWidth',2)
hold on
plot(log.time,log.user_defined_position.x,'b-.','LineWidth',2)
legend('$r_X(t)$','$r_{{\rm user},X}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('$X$-position [m]','interpreter','latex','fontsize',font_size)
title('PID','interpreter','latex','fontsize',font_size_title)
axis tight
hold off
xlim([x_lim_min,x_lim_max])

subplot(3,1,2)
plot(log.time,log.position.y,'r-','LineWidth',2)
hold on
plot(log.time,log.user_defined_position.y,'b-.','LineWidth',2)
legend('$r_Y(t)$','$r_{{\rm user},Y}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('$Y$-position [m]','interpreter','latex','fontsize',font_size)
axis tight
hold off
xlim([x_lim_min,x_lim_max])

subplot(3,1,3)
plot(log.time,log.position.z,'r-','LineWidth',2)
hold on
plot(log.time,log.user_defined_position.z,'b-.','LineWidth',2)
legend('$r_Z(t)$','$r_{{\rm user},Z}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('$Z$-position [m]','interpreter','latex','fontsize',font_size)
ax = gca;
ax.YDir = 'reverse';
axis tight
hold off
xlim([x_lim_min,x_lim_max])


%% Plot velocity vs time

set(figure,'Color','white','WindowState','maximized')
subplot(3,1,1)
plot(log.time,log.velocity.x,'r-','LineWidth',2)
hold on
plot(log.time,log.user_defined_velocity.x,'b-.','LineWidth',2)
legend('$\dot{r}_X(t)$','$\dot{r}_{{\rm user},X}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('$X$-velocity [m/s]','interpreter','latex','fontsize',font_size)
title('PID','interpreter','latex','fontsize',font_size_title)
axis tight
hold off
xlim([x_lim_min,x_lim_max])

subplot(3,1,2)
plot(log.time,log.velocity.y,'r-','LineWidth',2)
hold on
plot(log.time,log.user_defined_velocity.y,'b-.','LineWidth',2)
legend('$\dot{r}_Y(t)$','$\dot{r}_{{\rm user},Y}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('$Y$-velocity [m/s]','interpreter','latex','fontsize',font_size)
axis tight
hold off
xlim([x_lim_min,x_lim_max])

subplot(3,1,3)
plot(log.time,log.velocity.z,'r-','LineWidth',2)
hold on
plot(log.time,log.user_defined_velocity.z,'b-.','LineWidth',2)
legend('$\dot{r}_Z(t)$','$\dot{r}_{{\rm user},Z}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('$Z$-velocity [m/s]','interpreter','latex','fontsize',font_size)
ax = gca;
ax.YDir = 'reverse';
axis tight
hold off
xlim([x_lim_min,x_lim_max])

%% Plot angles vs time

set(figure,'Color','white','WindowState','maximized')
subplot(3,1,1)
plot(log.time,rad2deg(log.euler_angles.roll),'r-','LineWidth',2)
hold on
plot(log.time,rad2deg(log.reference_euler_angles.roll),'b-.','LineWidth',2)
legend('$$\phi(t)$$','$$\phi_{\rm ref}(t)$$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Roll [deg]','interpreter','latex','fontsize',font_size)
title('PID','interpreter','latex','fontsize',font_size_title)
axis tight
hold off
xlim([x_lim_min,x_lim_max])

subplot(3,1,2)
plot(log.time,rad2deg(log.euler_angles.pitch),'r-','LineWidth',2)
hold on
plot(log.time,rad2deg(log.reference_euler_angles.pitch),'b-.','LineWidth',2)
legend('$$\theta(t)$$','$$\theta_{\rm ref}(t)$$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Pitch [deg]','interpreter','latex','fontsize',font_size)
axis tight
hold off
xlim([x_lim_min,x_lim_max])

subplot(3,1,3)
plot(log.time,rad2deg(log.euler_angles.yaw),'r-','LineWidth',2)
hold on
plot(log.time,rad2deg(der.user_defined_yaw),'b-.','LineWidth',2)
legend('$$\psi(t)$$','$$\psi_{\rm ref}(t)$$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Yaw [deg]','interpreter','latex','fontsize',font_size)
axis tight
hold off
xlim([x_lim_min,x_lim_max])

%% Plot angles derivatives vs time

set(figure,'Color','white','WindowState','maximized')
subplot(3,1,1)
plot(log.time,log.euler_angles_dot.roll_dot,'r-','LineWidth',2)
hold on
plot(log.time,log.reference_euler_angles.roll_dot,'b-.','LineWidth',2)
legend('$$\dot{\phi}(t)$$','$$\dot{\phi}_{\rm ref}(t)$$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Roll rate [rad/s]','interpreter','latex','fontsize',font_size)
title('PID','interpreter','latex','fontsize',font_size_title)
axis tight
hold off
xlim([x_lim_min,x_lim_max])

subplot(3,1,2)
plot(log.time,log.euler_angles_dot.pitch_dot,'r-','LineWidth',2)
hold on
plot(log.time,log.reference_euler_angles.pitch_dot,'b-.','LineWidth',2)
legend('$$\dot{\theta}(t)$$','$$\dot{\theta}_{\rm ref}(t)$$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Pitch rate [rad/s]','interpreter','latex','fontsize',font_size)
axis tight
hold off
xlim([x_lim_min,x_lim_max])

subplot(3,1,3)
plot(log.time,log.euler_angles_dot.yaw_dot,'r-','LineWidth',2)
hold on
plot(log.time,log.user_defined_yaw_dot,'b-.','LineWidth',2)
legend('$$\dot{\psi}(t)$$','$$\dot{\psi}_{\rm ref}(t)$$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Yaw rate [rad/s]','interpreter','latex','fontsize',font_size)
axis tight
hold off
xlim([x_lim_min,x_lim_max])


%% 3D PLOT

d_start = 995;
d_end = 3294;
set(figure,'Color','white','WindowState','maximized')
plot3(log.user_defined_position.x(d_start:d_end), ...
      log.user_defined_position.y(d_start:d_end), ...
      log.user_defined_position.z(d_start:d_end), ...
    'Color',"#4DBEEE",'LineStyle','--','LineWidth',1)
hold on
plot3(log.position.x(d_start:d_end), ...
      log.position.y(d_start:d_end), ...
      log.position.z(d_start:d_end), ...
    'Color',"#FF0000",'LineStyle','-','LineWidth',2)
legend('$r_{\rm user}$', '$r$');
axis equal
ax = gca;
ax.YDir = 'reverse';
ax.ZDir = 'reverse';
title('Position 3D','interpreter','latex','fontsize',18)
grid on
% xlim([-2 2])
% ylim([-2 2])
% zlim([-1.5 0.5])
xlabel('X [m]','interpreter','latex','fontsize',font_size)
ylabel('Y [m]','interpreter','latex','fontsize',font_size)
zlabel('Z [m]','interpreter','latex','fontsize',font_size)
hold off

%% Plot translational position error vs time 

set(figure,'Color','white','WindowState','maximized')
plot(log.time,der.translational_position_error.x,'--','LineWidth',2)
hold on
plot(log.time,der.translational_position_error.y,'-.','LineWidth',2)
plot(log.time,der.translational_position_error.z,':','LineWidth',2)
plot(log.time,der.translational_position_error.norm,'--','LineWidth',1)
legend('$x$', '$y$', '$z$', 'Norm');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Translational position error [m]','interpreter','latex','fontsize',font_size)
title('PID','interpreter','latex','fontsize',font_size_title)
hold off
axis tight
xlim([x_lim_min,x_lim_max])

%% Plot angular error vs time 

set(figure,'Color','white','WindowState','maximized')
plot(log.time,rad2deg(log.angular_error.roll),'--','LineWidth',2)
hold on
plot(log.time,rad2deg(log.angular_error.pitch),'-.','LineWidth',2)
plot(log.time,rad2deg(log.angular_error.yaw),':','LineWidth',2)
legend('Roll error', 'Pitch error', 'Yaw error');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Angular error [deg]','interpreter','latex','fontsize',font_size)
title('PID','interpreter','latex','fontsize',font_size_title)
hold off
axis tight
xlim([x_lim_min,x_lim_max])

%% Plot algorithm execution/computational time vs time 

set(figure,'Color','white','WindowState','maximized')
plot(log.time,log.algorithm_execution_time_us,'*','LineWidth',2)
hold on
plot(log.time,der.average_algorithm_execution_time_us ...
    * ones(size(log.time)),'--','LineWidth',2)

% Plot standard deviation band
std_upper = der.average_algorithm_execution_time_us + der.standard_deviation_algorithm_execution_time_us;
std_lower = der.average_algorithm_execution_time_us - der.standard_deviation_algorithm_execution_time_us;
fill([0, log.time(end), log.time(end), 0], ...
    [std_lower, std_lower, std_upper, std_upper], ...
    'r', 'EdgeColor', 'none', 'FaceAlpha', 0.3);

legend('', ['Average execution time: ', num2str(der.average_algorithm_execution_time_us), ' $\mu$s'], ...
           ['$\pm$ Standard deviation: ', num2str(der.standard_deviation_algorithm_execution_time_us), ' $\mu$s'])
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Algorithm execution time [$\mu$s]','interpreter','latex','fontsize',font_size)
title('PID','interpreter','latex','fontsize',font_size_title)
hold off
axis tight
xlim([x_lim_min,x_lim_max])



%% Plot Torque Control Inputs U2, U3, U4

set(figure,'Color','white','WindowState','maximized')
plot(log.time,log.control_input.U2,'r-.','LineWidth',1.2)
hold on
plot(log.time,log.control_input.U3,'g--','LineWidth',1.2)
plot(log.time,log.control_input.U4,'k-','LineWidth',1)
legend('$U_2(t)$','$U_3(t)$','$U_4(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Control inputs [Nm]','interpreter','latex','fontsize',font_size)
title('PID','interpreter','latex','fontsize',font_size_title)
hold off
axis tight
xlim([x_lim_min,x_lim_max])

%% Plot virtual translational force input

set(figure,'Color','white','WindowState','maximized')
plot(log.time,log.mu_translational.x,'r-','LineWidth',1.2)
hold on
plot(log.time,log.mu_translational.y,'g-','LineWidth',1.2)
plot(log.time,log.mu_translational.z,'k-','LineWidth',1)
legend('$\mu_x(t)$','$\mu_y(t)$','$\mu_z(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Virtual translational force input [N]','interpreter','latex','fontsize',font_size)
title('PID','interpreter','latex','fontsize',font_size_title)
hold off
axis tight
xlim([x_lim_min,x_lim_max])

%% Plot OUTER LOOP Proportional control input

set(figure,'Color','white','WindowState','maximized')
plot(log.time,log.outer_loop.Proportional.x,'r-','LineWidth',1.2)
hold on
plot(log.time,log.outer_loop.Proportional.y,'g-','LineWidth',1.2)
plot(log.time,log.outer_loop.Proportional.z,'k-','LineWidth',1)
legend('$\mu_{\rm PID,P,x}(t)$','$\mu_{\rm PID,P,y}(t)$','$\mu_{\rm PID,P,z}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Outer loop Proportional control input [N]','interpreter','latex','fontsize',font_size)
title('PID','interpreter','latex','fontsize',font_size_title)
hold off
axis tight
xlim([x_lim_min,x_lim_max])

%% Plot OUTER LOOP Integral control input

set(figure,'Color','white','WindowState','maximized')
plot(log.time,log.outer_loop.Integral.x,'r-','LineWidth',1.2)
hold on
plot(log.time,log.outer_loop.Integral.y,'g-','LineWidth',1.2)
plot(log.time,log.outer_loop.Integral.z,'k-','LineWidth',1)
legend('$\mu_{\rm PID,I,x}(t)$','$\mu_{\rm PID,I,y}(t)$','$\mu_{\rm PID,I,z}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Outer loop Integral control input [N]','interpreter','latex','fontsize',font_size)
title('PID','interpreter','latex','fontsize',font_size_title)
hold off
axis tight
xlim([x_lim_min,x_lim_max])

%% Plot OUTER LOOP Derivative control input

set(figure,'Color','white','WindowState','maximized')
plot(log.time,log.outer_loop.Derivative.x,'r-','LineWidth',1.2)
hold on
plot(log.time,log.outer_loop.Derivative.y,'g-','LineWidth',1.2)
plot(log.time,log.outer_loop.Derivative.z,'k-','LineWidth',1)
legend('$\mu_{\rm PID,D,x}(t)$','$\mu_{\rm PID,D,y}(t)$','$\mu_{\rm PID,D,z}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Outer loop Derivative control input [N]','interpreter','latex','fontsize',font_size)
title('PID','interpreter','latex','fontsize',font_size_title)
hold off
axis tight
xlim([x_lim_min,x_lim_max])

%% Plot INNER LOOP Proportional control input

set(figure,'Color','white','WindowState','maximized')
plot(log.time,log.inner_loop.Proportional.x,'r-','LineWidth',1.2)
hold on
plot(log.time,log.inner_loop.Proportional.y,'g-','LineWidth',1.2)
plot(log.time,log.inner_loop.Proportional.z,'k-','LineWidth',1)
legend('$\tau_{\rm PID,P,x}(t)$','$\tau_{\rm PID,P,y}(t)$','$\tau_{\rm PID,P,z}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Inner loop Proportional control input [Nm]','interpreter','latex','fontsize',font_size)
title('PID','interpreter','latex','fontsize',font_size_title)
hold off
axis tight
xlim([x_lim_min,x_lim_max])

%% Plot INNER LOOP Integral control input

set(figure,'Color','white','WindowState','maximized')
plot(log.time,log.inner_loop.Integral.x,'r-','LineWidth',1.2)
hold on
plot(log.time,log.inner_loop.Integral.y,'g-','LineWidth',1.2)
plot(log.time,log.inner_loop.Integral.z,'k-','LineWidth',1)
legend('$\tau_{\rm PID,I,x}(t)$','$\tau_{\rm PID,I,y}(t)$','$\tau_{\rm PID,I,z}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Inner loop Integral control input [Nm]','interpreter','latex','fontsize',font_size)
title('PID','interpreter','latex','fontsize',font_size_title)
hold off
axis tight
xlim([x_lim_min,x_lim_max])

%% Plot INNER LOOP Derivative control input

set(figure,'Color','white','WindowState','maximized')
plot(log.time,log.inner_loop.Derivative.x,'r-','LineWidth',1.2)
hold on
plot(log.time,log.inner_loop.Derivative.y,'g-','LineWidth',1.2)
plot(log.time,log.inner_loop.Derivative.z,'k-','LineWidth',1)
legend('$\tau_{\rm PID,D,x}(t)$','$\tau_{\rm PID,D,y}(t)$','$\tau_{\rm PID,D,z}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Inner loop Derivative control input [Nm]','interpreter','latex','fontsize',font_size)
title('PID','interpreter','latex','fontsize',font_size_title)
hold off
axis tight
xlim([x_lim_min,x_lim_max])

%% Plot INNER LOOP Dynamic inversion control input

set(figure,'Color','white','WindowState','maximized')
plot(log.time,log.inner_loop.dynamic_inversion.x,'r-','LineWidth',1.2)
hold on
plot(log.time,log.inner_loop.dynamic_inversion.y,'g-','LineWidth',1.2)
plot(log.time,log.inner_loop.dynamic_inversion.z,'k-','LineWidth',1)
legend('$\tau_{\rm DynInv,x}(t)$','$\tau_{\rm DynInv,y}(t)$','$\tau_{\rm DynInv,z}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Inner loop dynamic inversion control input [Nm]','interpreter','latex','fontsize',font_size)
title('PID','interpreter','latex','fontsize',font_size_title)
hold off
axis tight
xlim([x_lim_min,x_lim_max])

%==========================================================================
% MOCAP
%==========================================================================
%% Plot MOCAP position vs time

set(figure,'Color','white','WindowState','maximized')
subplot(3,1,1)
plot(log.time,log.position.x,'r-','LineWidth',2)
hold on
plot(mocap.time,mocap.position.x,'k-','LineWidth',1.25)
plot(log.time,log.user_defined_position.x,'b-.','LineWidth',2)
legend('$r_{x}(t)$','$r_{x,MOCAP}(t)$','$r_{\rm user,x}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('X position [m]','interpreter','latex','fontsize',font_size)
title('PID','interpreter','latex','fontsize',font_size_title)
axis tight
hold off

subplot(3,1,2)
plot(log.time,log.position.y,'r-','LineWidth',2)
hold on
plot(mocap.time,mocap.position.y,'k-','LineWidth',1.25)
plot(log.time,log.user_defined_position.y,'b-.','LineWidth',2)
legend('$r_{y}(t)$','$r_{y,MOCAP}(t)$','$r_{\rm user,y}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Y position [m]','interpreter','latex','fontsize',font_size)
axis tight
hold off

subplot(3,1,3)
plot(log.time,log.position.z,'r-','LineWidth',2)
hold on
plot(mocap.time,mocap.position.z,'k-','LineWidth',1.25)
plot(log.time,log.user_defined_position.z,'b-.','LineWidth',2)
legend('$r_{z}(t)$', '$r_{z,MOCAP}(t)$','$r_{\rm user,z}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Z position [m]','interpreter','latex','fontsize',font_size)
ax = gca;
ax.YDir = 'reverse';
axis tight
hold off

%% Plot MOCAP velocity vs time

set(figure,'Color','white','WindowState','maximized')
subplot(3,1,1)
plot(log.time,log.velocity.x,'r-','LineWidth',2)
hold on
plot(mocap.time,mocap.velocity.x,'k-','LineWidth',1.25)
plot(log.time,log.user_defined_velocity.x,'b-.','LineWidth',2)
legend('$\dot{r}_{x}(t)$', '$\dot{r}_{x,MOCAP}(t)$','$\dot{r}_{\rm user,x}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('X velocity [m/s]','interpreter','latex','fontsize',font_size)
title('PID','interpreter','latex','fontsize',font_size_title)
axis tight
hold off

subplot(3,1,2)
plot(log.time,log.velocity.y,'r-','LineWidth',2)
hold on
plot(mocap.time,mocap.velocity.y,'k-','LineWidth',1.25)
plot(log.time,log.user_defined_velocity.y,'b-.','LineWidth',2)
legend('$\dot{r}_{y}(t)$', '$\dot{r}_{y,MOCAP}(t)$','$\dot{r}_{\rm user,y}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Y velocity [m/s]','interpreter','latex','fontsize',font_size)
axis tight
hold off

subplot(3,1,3)
plot(log.time,log.velocity.z,'r-','LineWidth',2)
hold on
plot(mocap.time,mocap.velocity.z,'k-','LineWidth',1.25)
plot(log.time,log.user_defined_velocity.z,'b-.','LineWidth',2)
legend('$\dot{r}_{z}(t)$', '$\dot{r}_{z,MOCAP}(t)$','$\dot{r}_{\rm user,z}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Z velocity [m/s]','interpreter','latex','fontsize',font_size)
ax = gca;
ax.YDir = 'reverse';
axis tight
hold off


%% Plot MOCAP angles vs time

set(figure,'Color','white','WindowState','maximized')
subplot(3,1,1)
plot(log.time,rad2deg(log.euler_angles.roll),'b-','LineWidth',2)
hold on
plot(mocap.time,rad2deg(mocap.euler_angles.roll),'r-.','LineWidth',2)
legend('$$\phi(t)$$','$$\phi_{\rm MOCAP}(t)$$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Roll [deg]','interpreter','latex','fontsize',font_size)
title('PID','interpreter','latex','fontsize',font_size_title)
axis tight
hold off

subplot(3,1,2)
plot(log.time,rad2deg(log.euler_angles.pitch),'b-','LineWidth',2)
hold on
plot(mocap.time,rad2deg(mocap.euler_angles.pitch),'r-.','LineWidth',2)
legend('$$\theta(t)$$','$$\theta_{\rm MOCAP}(t)$$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Pitch [deg]','interpreter','latex','fontsize',font_size)
axis tight
hold off

subplot(3,1,3)
plot(log.time,rad2deg(log.euler_angles.yaw),'b-','LineWidth',2)
hold on
plot(mocap.time,rad2deg(mocap.euler_angles.yaw),'r-.','LineWidth',2)
legend('$$\psi(t)$$','$$\psi_{\rm MOCAP}(t)$$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Yaw [deg]','interpreter','latex','fontsize',font_size)
axis tight
hold off

%% Plot MOCAP quaternion vs time

set(figure,'Color','white','WindowState','maximized')
subplot(4,1,1)
plot(log.time,log.quaternion.q0,'b-','LineWidth',2)
hold on
plot(mocap.time,mocap.quaternion.q0,'r-.','LineWidth',2)
legend('$q_0(t)$','$q_{\rm 0,MOCAP}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('$q_0$ [-]','interpreter','latex','fontsize',font_size)
title('PID','interpreter','latex','fontsize',font_size_title)
axis tight
hold off

subplot(4,1,2)
plot(log.time,log.quaternion.q1,'b-','LineWidth',2)
hold on
plot(mocap.time,mocap.quaternion.q1,'r-.','LineWidth',2)
legend('$q_1(t)$','$q_{\rm 1,MOCAP}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('$q_1$ [-]','interpreter','latex','fontsize',font_size)
title('PID','interpreter','latex','fontsize',font_size_title)
axis tight
hold off

subplot(4,1,3)
plot(log.time,log.quaternion.q2,'b-','LineWidth',2)
hold on
plot(mocap.time,mocap.quaternion.q2,'r-.','LineWidth',2)
legend('$q_2(t)$','$q_{\rm 2,MOCAP}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('$q_2$ [-]','interpreter','latex','fontsize',font_size)
title('PID','interpreter','latex','fontsize',font_size_title)
axis tight
hold off

subplot(4,1,4)
plot(log.time,log.quaternion.q3,'b-','LineWidth',2)
hold on
plot(mocap.time,mocap.quaternion.q3,'r-.','LineWidth',2)
legend('$q_3(t)$','$q_{\rm 3,MOCAP}(t)$');
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('$q_3$ [-]','interpreter','latex','fontsize',font_size)
title('PID','interpreter','latex','fontsize',font_size_title)
axis tight
hold off









