clear
close all
clc

% Set overall properties for plots and figures
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(groot, 'defaultAxesFontSize', 20);
addpath(genpath('.\functions'));


% load('Workspace/Workspace');

%% Takeoff Hover trajectory
% % Trajectory waypoints
% traj.wpts = [0  0;
%              0  0;
%              0 -1];
% 
% % Coefficient to scale the waypoints' times
% traj.alphaFactor = 1;
% 
% % Waypoints' times
% traj.tpts = traj.alphaFactor*[0 4]';

%% Landing Hover trajectory
% % Trajectory waypoints
% traj.wpts = [ 0  0;
%               0  0;
%              -1  0];
% 
% % Coefficient to scale the waypoints' times
% traj.alphaFactor = 1;
% 
% % Waypoints' times
% traj.tpts = traj.alphaFactor*[0 4]';

%% Stadium trajectory
% % Trajectory waypoints
% traj.wpts = [0  5  20  20   0  0;
%              0  0   0   5   5  0;
%              0 -1  -1  -1  -1 -1];
% 
% % Coefficient to scale the waypoints' times
% traj.alphaFactor = 1;
% 
% % Waypoints' times
% traj.tpts = traj.alphaFactor*[0 2 5 7 10 15]';

%% Eight trajectory
% % Trajectory waypoints
% traj.wpts = [0   1     2  7  9  7  2  0 -2 -7 -9 -7 -2  0;
%              0   0    -3 -3  0  3  3  0 -3 -3  0  3  3  0;
%              0  -0.5  -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1];
% 
% % Coefficient to scale the waypoints' times
% traj.alphaFactor = 0.5;
% 
% % Waypoints' times
% traj.tpts = traj.alphaFactor*[0 2.2 5 7 8.5 10 11.5 13 14.5 16 17.5 19 20.5 23]';

%% Stadium trajectory stalling at start - NOT TO USE
% % Trajectory waypoints
% traj.wpts = [0  0  5  20  20   0  0;
%              0  0  0   0   5   5  0;
%              0  0 -1  -1  -1  -1 -1];
% 
% % Coefficient to scale the waypoints' times
% traj.alphaFactor = 1;
% 
% % Waypoints' times
% traj.tpts = traj.alphaFactor*[0 5 7 10 12 15 20]';

%% Bean trajectory

% Trajectory waypoints
% Small Bean
% traj.wpts_nt = [  0    0     0;
%                 0.1    0  -0.5;
%                 0.2 0.01    -1;
%                 0.4 0.01    -1;
%                 0.5 0.20    -1;
%                 0.4 0.30    -1;
%                 0.1 0.35    -1;
%                -0.2 0.40    -1;
%                -0.4 0.30    -1;
%                -0.2 0.10    -1;
%                 0.0  0.0   -1];

% Big bean
traj.wpts_nt = [0.0  0.0   0.0;
                0.1  0.045  -0.5;
                0.8  0.4    -1;
                1.8  0.6    -1;
                2.5  0.0    -1;
                1.8 -0.6    -1;
               -1.5 -0.6    -1;
               -2.8  0.0    -1;
               -1.0  0.4    -1;
                0.0  0.0   -1];

traj.wpts = transpose(traj.wpts_nt);

% Coefficient to scale the waypoints' times
traj.alphaFactor = 0.4;

% Waypoints' times
% traj.segment_relative_times = [0;
%                                4;
%                                6;
%                                4;
%                                4;
%                                4;
%                                6;
%                                4;
%                                4;
%                                4;
%                                4;
%                                4];

% Small Bean
% traj.segment_relative_times = [0;
%                                4;
%                                4;
%                                4;
%                                4;
%                                4;
%                                4;
%                                4;
%                                4;
%                                4;
%                                4];

% Big bean
traj.segment_relative_times = [0;
                               4;
                               4;
                               4;
                               4;
                               4;
                               4;
                               4;
                               4;
                               4];

%% Compute the trajectory

traj.tpts_temp = zeros(length(traj.segment_relative_times),1);
for i = 2:length(traj.segment_relative_times)
    traj.tpts_temp(i) = traj.tpts_temp(i-1) + traj.segment_relative_times(i);
end

traj.tpts = traj.alphaFactor * traj.tpts_temp;


% Number of samples used to evaluate the trajectory
traj.numsamples = 200;

% Minimum Jerk trajectory
[traj.q,traj.qd,traj.qdd,traj.qddd,traj.pp,traj.timepoints,traj.tsamples] = ...
    minjerkpolytraj(traj.wpts, traj.tpts, traj.numsamples);

% Plotting trajectory in 3D
set(figure,'Color','white','WindowState','maximized')
plot3(traj.q(1,:),traj.q(2,:),traj.q(3,:),'.b',...
      traj.wpts(1,:),traj.wpts(2,:),traj.wpts(3,:),'or')
xlabel('X','interpreter','latex')
ylabel('Y','interpreter','latex')
zlabel('Z','interpreter','latex')
ax = gca;
ax.YDir = 'reverse';
ax.ZDir = 'reverse';
axis equal
legend('Trajectory', 'Waypoints', Location='northwest')
grid on

%%

traj.q_norm = sqrt(traj.q(1,:).^2 + traj.q(2,:).^2 + traj.q(3,:).^2);
set(figure,'Color','white')
plot(traj.tsamples,traj.q)
hold on
plot(traj.tsamples,traj.q_norm)
xlabel('t')
ylabel('Position')
legend('X-position','Y-position','Z-position','position norm')
hold off

traj.qd_norm = sqrt(traj.qd(1,:).^2 + traj.qd(2,:).^2 + traj.qd(3,:).^2);
set(figure,'Color','white')
plot(traj.tsamples,traj.qd)
hold on
plot(traj.tsamples,traj.qd_norm)
xlabel('t')
ylabel('Velocity')
legend('X-velocity','Y-velocity','Z-velocity','velocity norm')
hold off

traj.qdd_norm = sqrt(traj.qdd(1,:).^2 + traj.qdd(2,:).^2 + traj.qdd(3,:).^2);
set(figure,'Color','white')
plot(traj.tsamples,traj.qdd)
hold on
plot(traj.tsamples,traj.qdd_norm)
xlabel('t')
ylabel('Accelerations')
legend('X-acceleration','Y-acceleration','Z-acceleration','acceleration norm')
hold off

set(figure,'Color','white')
plot(traj.tsamples,traj.qddd)
xlabel('t')
ylabel('Jerks')
legend('X-jerk','Y-jerk','Z-jerk')

% TRAJECTORY POSITION 
% Assigning the polynomial coefficients to the designated variables
[position.coef.x,...
 position.coef.y,...
 position.coef.z] = PolyCoefAssigning(traj.pp.coefs);

% TRAJECTORY VELOCITY 
% Assigning the polynomial coefficients to the designated variables
velocity.coef.x = PolyderMatrix(position.coef.x);
velocity.coef.y = PolyderMatrix(position.coef.y);
velocity.coef.z = PolyderMatrix(position.coef.z);

% TRAJECTORY ACCELERATION 
% Assigning the polynomial coefficients to the designated variables
acceleration.coef.x = PolyderMatrix(velocity.coef.x);
acceleration.coef.y = PolyderMatrix(velocity.coef.y);
acceleration.coef.z = PolyderMatrix(velocity.coef.z);

% TRAJECTORY JERK 
% Assigning the polynomial coefficients to the designated variables
jerk.coef.x = PolyderMatrix(acceleration.coef.x);
jerk.coef.y = PolyderMatrix(acceleration.coef.y);
jerk.coef.z = PolyderMatrix(acceleration.coef.z);

traj.step = 0.01;
t=traj.tpts(1):traj.step:traj.tpts(end);

for i = 1:length(t)
[t_adjusted(i),segment(i)] = PolyTimeAdjusted(traj.tpts,t(i));

position.x(i) = polyval(position.coef.x(segment(i),:), t_adjusted(i));
position.y(i) = polyval(position.coef.y(segment(i),:), t_adjusted(i));
position.z(i) = polyval(position.coef.z(segment(i),:), t_adjusted(i));

velocity.x(i) = polyval(velocity.coef.x(segment(i),:), t_adjusted(i));
velocity.y(i) = polyval(velocity.coef.y(segment(i),:), t_adjusted(i));
velocity.z(i) = polyval(velocity.coef.z(segment(i),:), t_adjusted(i));
velocity.norm2D(i) = Norm2D(velocity.coef.x(segment(i),:),...
                         velocity.coef.y(segment(i),:),...
                         t_adjusted(i));

acceleration.x(i) = polyval(acceleration.coef.x(segment(i),:), t_adjusted(i));
acceleration.y(i) = polyval(acceleration.coef.y(segment(i),:), t_adjusted(i));
acceleration.z(i) = polyval(acceleration.coef.z(segment(i),:), t_adjusted(i));

jerk.x(i) = polyval(jerk.coef.x(segment(i),:), t_adjusted(i));
jerk.y(i) = polyval(jerk.coef.y(segment(i),:), t_adjusted(i));
jerk.z(i) = polyval(jerk.coef.z(segment(i),:), t_adjusted(i));

if t_adjusted(i) == 0
    yaw(i) = 0;
    yaw_dot(i) = 0;
    yaw_dot_dot(i) = 0;

elseif t_adjusted(i) > 0 & velocity.norm2D(i) < 1e-5
    yaw(i) = yaw(i-1);
    yaw_dot(i) = 0;
    yaw_dot_dot(i) = 0;

else

    yaw(i) = YawComputation(velocity.coef.x(segment(i),:),...  
                            velocity.coef.y(segment(i),:),...
                            t_adjusted(i));
    
    yaw_dot(i) = YawDotComputation(velocity.coef.x(segment(i),:),...
                                   velocity.coef.y(segment(i),:),...
                                   acceleration.coef.x(segment(i),:),...
                                   acceleration.coef.y(segment(i),:),...
                                   t_adjusted(i));
    
    yaw_dot_dot(i) = YawDotDotComputation(velocity.coef.x(segment(i),:),...
                                          velocity.coef.y(segment(i),:),...
                                          acceleration.coef.x(segment(i),:),...
                                          acceleration.coef.y(segment(i),:),...
                                          jerk.coef.x(segment(i),:),...
                                          jerk.coef.y(segment(i),:),...
                                          t_adjusted(i));
end

end

%% Plots Yaw, Yaw_dot, Yaw_dot_dot
font_size = 20;

set(figure,'Color','white','WindowState','maximized')
plot(t,yaw,'b-','LineWidth',2)
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Yaw [rad]','interpreter','latex','fontsize',font_size)
axis tight

set(figure,'Color','white','WindowState','maximized')
plot(t,yaw_dot,'b-','LineWidth',2)
hold on
plot(t(2:end),diff(yaw)/traj.step,'r--','LineWidth',2)
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Yaw rate [rad/s]','interpreter','latex','fontsize',font_size)
legend('Complex numbers','Differentiating','interpreter','latex','fontsize',font_size)
% ylim([-2,2])
% axis tight
hold off

set(figure,'Color','white','WindowState','maximized')
plot(t,yaw_dot_dot,'b-','LineWidth',2)
hold on
plot(t(3:end),diff(diff(yaw))/traj.step^2,'r--','LineWidth',2)
xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
ylabel('Yaw acceleration [rad/s$^2$]','interpreter','latex','fontsize',font_size)
legend('Complex numbers','Differentiating','interpreter','latex','fontsize',font_size)
% ylim([-2,2])
% axis tight
hold off

%% Exporting trajectory piecewise polynomial coefficient matrix 

% For the Flightstack
json_struct.waypoints = traj.wpts;
json_struct.waypoint_times = traj.tpts;
json_struct.piecewise_polynomial_coefficients = traj.pp.coefs;

structToJSON(json_struct, 'trajectories_json/piecewise_polynomial_trajectory.json')

%% Comparing with flightstack data

% % Plotting trajectory in 3D
% set(figure,'Color','white')
% plot3(traj.q(1,:),traj.q(2,:),traj.q(3,:),'.b',...
%       traj.wpts(1,:),traj.wpts(2,:),traj.wpts(3,:),'or')
% hold on;
% plot3(log.user_defined_position_x,log.user_defined_position_y,log.user_defined_position_z,'-g')
% xlabel('X')
% ylabel('Y')
% zlabel('Z')
% legend('MATLAB', 'waypoints', 'flightstack')
% ax = gca;
% ax.YDir = 'reverse';
% ax.ZDir = 'reverse';
% axis equal
% 
% % Plotting position
% log.postprocess.user_defined_position_norm = sqrt(log.user_defined_position_x.^2 + ...
%                                                   log.user_defined_position_y.^2 + ...
%                                                   log.user_defined_position_z.^2);
% set(figure,'Color','white')
% plot(traj.tsamples,traj.q)
% hold on
% plot(traj.tsamples,traj.q_norm)
% plot(log.time, log.user_defined_position_x, '--', ...
%      log.time, log.user_defined_position_y, '--', ...
%      log.time, log.user_defined_position_z, '--', 'LineWidth', 2)
% plot(log.time,log.postprocess.user_defined_position_norm, '--', 'LineWidth', 2)
% xlabel('t')
% ylabel('Position')
% legend('X-position MATLAB','Y-position MATLAB','Z-position MATLAB','position norm MATLAB', ...
%        'X-position flightstack','Y-position flightstack','Z-position flightstack','position norm flightstack')
% hold off
% 
% % Plotting velocity
% log.postprocess.user_defined_velocity_norm = sqrt(log.user_defined_velocity_x.^2 + ...
%                                                   log.user_defined_velocity_y.^2 + ...
%                                                   log.user_defined_velocity_z.^2);
% set(figure,'Color','white')
% plot(traj.tsamples,traj.qd)
% hold on
% plot(traj.tsamples,traj.qd_norm)
% plot(log.time, log.user_defined_velocity_x, '--', ...
%      log.time, log.user_defined_velocity_y, '--', ...
%      log.time, log.user_defined_velocity_z, '--', 'LineWidth', 2)
% 
% plot(log.time,log.postprocess.user_defined_velocity_norm, '--', 'LineWidth', 2)
% xlabel('t')
% ylabel('Velocity')
% legend('X-velocity MATLAB','Y-velocity MATLAB','Z-velocity MATLAB','velocity norm MATLAB', ...
%        'X-velocity flightstack','Y-velocity flightstack','Z-velocity flightstack','velocity norm flightstack')
% hold off
% 
% % Plotting acceleration
% log.postprocess.user_defined_acceleration_norm = sqrt(log.user_defined_acceleration_x.^2 + ...
%                                                   log.user_defined_acceleration_y.^2 + ...
%                                                   log.user_defined_acceleration_z.^2);
% set(figure,'Color','white')
% plot(traj.tsamples,traj.qdd)
% hold on
% plot(traj.tsamples,traj.qdd_norm)
% plot(log.time, log.user_defined_acceleration_x, '--', ...
%      log.time, log.user_defined_acceleration_y, '--', ...
%      log.time, log.user_defined_acceleration_z, '--', 'LineWidth', 2)
% 
% plot(log.time,log.postprocess.user_defined_acceleration_norm, '--', 'LineWidth', 2)
% xlabel('t')
% ylabel('Acceleration')
% legend('X-acceleration MATLAB','Y-acceleration MATLAB','Z-acceleration MATLAB','acceleration norm MATLAB', ...
%        'X-acceleration flightstack','Y-acceleration flightstack','Z-acceleration flightstack','acceleration norm flightstack')
% hold off
% 
% % Plotting yaw
% set(figure,'Color','white','WindowState','maximized')
% plot(t,yaw,'b-','LineWidth',2)
% hold on
% plot(log.time,log.user_defined_yaw,'r--','LineWidth',2)
% xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
% ylabel('Yaw [rad]','interpreter','latex','fontsize',font_size)
% legend('MATLAB','flightstack','interpreter','latex','fontsize',font_size)
% axis tight
% 
% % Plotting yaw rate 
% set(figure,'Color','white','WindowState','maximized')
% plot(t,yaw_dot,'b-','LineWidth',2)
% hold on
% plot(log.time,log.user_defined_yaw_dot,'r--','LineWidth',2)
% xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
% ylabel('Yaw rate [rad/s]','interpreter','latex','fontsize',font_size)
% legend('MATLAB','flightstack','interpreter','latex','fontsize',font_size)
% % ylim([-2,2])
% % axis tight
% hold off
% 
% % Plotting yaw acceleration
% set(figure,'Color','white','WindowState','maximized')
% plot(t,yaw_dot_dot,'b-','LineWidth',2)
% hold on
% plot(log.time,log.user_defined_yaw_dot_dot,'r--','LineWidth',2)
% xlabel('$t$ [s]','interpreter','latex','fontsize',font_size)
% ylabel('Yaw acceleration [rad/s$^2$]','interpreter','latex','fontsize',font_size)
% legend('MATLAB','flightstack','interpreter','latex','fontsize',font_size)
% % ylim([-2,2])
% % axis tight
% hold off

%% exporting polynomial coefficients for landing

% writematrix(position.coef.z,'trajectories_csv/landing_position_coef_z.csv') 
% writematrix(velocity.coef.z,'trajectories_csv/landing_velocity_coef_z.csv') 
% writematrix(acceleration.coef.z,'trajectories_csv/landing_acceleration_coef_z.csv') 



