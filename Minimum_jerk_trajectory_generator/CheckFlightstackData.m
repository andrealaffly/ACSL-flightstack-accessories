clear all
close all
clc

% LogData = readtable(filename);

filename = 'logs/log_20240419_151238.log'; 
LogDataMatrix = readmatrix(filename);

log.time = LogDataMatrix(:, 2);
log.user_defined_position_x = LogDataMatrix(:, 3);
log.user_defined_position_y = LogDataMatrix(:, 4);
log.user_defined_position_z = LogDataMatrix(:, 5);
log.user_defined_velocity_x = LogDataMatrix(:, 6);
log.user_defined_velocity_y = LogDataMatrix(:, 7);
log.user_defined_velocity_z = LogDataMatrix(:, 8);
log.user_defined_acceleration_x = LogDataMatrix(:, 9);
log.user_defined_acceleration_y = LogDataMatrix(:, 10);
log.user_defined_acceleration_z = LogDataMatrix(:, 11);
log.user_defined_yaw = LogDataMatrix(:, 12);
log.user_defined_yaw_dot = LogDataMatrix(:, 13);
log.user_defined_yaw_dot_dot = LogDataMatrix(:, 14);

save('Workspace');