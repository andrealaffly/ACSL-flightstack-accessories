
clear
close all
clc

% Switch to control whether mocap data should be processed
processMocap = false;  % Set to true to process mocap data, false to skip

% Date of the directory to analyze
properties.date_folder = '20240531';

% Path to the logs directory
properties.logs_folder = ['../', properties.date_folder, '/logs']; 

if processMocap
    % Path to the mocap directory
    properties.mocap_folder = ['../', properties.date_folder, '/mocap']; 
end

% Get a list of all .log files in the logs folder
properties.log_files = dir(fullfile(properties.logs_folder, '*.log'));

if processMocap
    % Get a list of all .log files in the mocap folder
    properties.mocap_files = dir(fullfile(properties.mocap_folder, '*.log'));
end

if processMocap
    % Ensure that the number of log files and mocap files are the same
    if length(properties.log_files) ~= length(properties.mocap_files)
        error('The number of log files and mocap files does not match.');
    end
end

% Process each log file in the directory
for i = 1:length(properties.log_files)
    % Get the full path of the current log file
    properties.log_filename = fullfile(properties.log_files(i).folder, ...
        properties.log_files(i).name);

    if processMocap
        % Get the full path of the current mocap file
        properties.mocap_filename = fullfile(properties.mocap_files(i).folder, ...
            properties.mocap_files(i).name);
    end

    % Extract the base name from the filename
    [properties.log_filename_folder, properties.log_filename_name, ~] = ...
        fileparts(properties.log_filename);

    % Find the parent folder
    properties.parent_folder = fileparts(properties.log_filename_folder);

    % Extract the specific date from the parent folder (e.g., '20240429')
    [~, properties.parent_folder_name] = fileparts( ...
                                                 properties.parent_folder);

    % Extract the timestamp portion from the log filename
    properties.timestamp = regexp(properties.log_filename_name, ...
                                  '\d{8}_\d{6}', 'match', 'once');

    % Define the directory for saving the workspace,
    % based on the parent folder
    properties.save_directory = fullfile(properties.parent_folder, ...
                                         'workspaces'); 

    % Create the full path for the new workspace file
    properties.workspace_filename = fullfile(...
        properties.save_directory,...
        sprintf('workspace_log_%s.mat', properties.timestamp));

    % Ensure the save directory exists
    if ~exist(properties.save_directory, 'dir')
        mkdir(properties.save_directory);
    end

    % Extracting data from the current log file
    % disp(['Processing log file: ', properties.log_filename]); % Debugging statement
    LogDataMatrix = readmatrix(properties.log_filename);

    % Check if the log file has enough columns
    if size(LogDataMatrix, 2) < 99
        disp(['Error: The file ', properties.log_filename, ' does not have enough columns.']);
        continue; % Skip this iteration and go to the next file
    end

    %----------------------------------------------------------------------
    % LOGGED VALUES

    log.time = LogDataMatrix(:, 2);
    log.user_defined_position.x = LogDataMatrix(:, 3);
    log.user_defined_position.y = LogDataMatrix(:, 4);
    log.user_defined_position.z = LogDataMatrix(:, 5);
    log.user_defined_velocity.x = LogDataMatrix(:, 6);
    log.user_defined_velocity.y = LogDataMatrix(:, 7);
    log.user_defined_velocity.z = LogDataMatrix(:, 8);
    log.user_defined_acceleration.x = LogDataMatrix(:, 9);
    log.user_defined_acceleration.y = LogDataMatrix(:, 10);
    log.user_defined_acceleration.z = LogDataMatrix(:, 11);
    log.user_defined_yaw = LogDataMatrix(:, 12);
    log.user_defined_yaw_dot = LogDataMatrix(:, 13);
    log.user_defined_yaw_dot_dot = LogDataMatrix(:, 14);
    log.odometry_time = LogDataMatrix(:, 15);
    log.position.x = LogDataMatrix(:, 16);
    log.position.y = LogDataMatrix(:, 17);
    log.position.z = LogDataMatrix(:, 18);
    log.quaternion.q0 = LogDataMatrix(:, 19);
    log.quaternion.q1 = LogDataMatrix(:, 20);
    log.quaternion.q2 = LogDataMatrix(:, 21);
    log.quaternion.q3 = LogDataMatrix(:, 22);
    log.velocity.x = LogDataMatrix(:, 23);
    log.velocity.y = LogDataMatrix(:, 24);
    log.velocity.z = LogDataMatrix(:, 25);
    log.angular_velocity.x = LogDataMatrix(:, 26);
    log.angular_velocity.y = LogDataMatrix(:, 27);
    log.angular_velocity.z = LogDataMatrix(:, 28);
    log.euler_angles.roll = LogDataMatrix(:, 29);
    log.euler_angles.pitch = LogDataMatrix(:, 30);
    log.euler_angles.yaw = LogDataMatrix(:, 31);
    log.algorithm_execution_time_us = LogDataMatrix(:, 32);
    log.mu_translational_raw.x = LogDataMatrix(:, 33);
    log.mu_translational_raw.y = LogDataMatrix(:, 34);
    log.mu_translational_raw.z = LogDataMatrix(:, 35);
    log.mu_translational.x = LogDataMatrix(:, 36);
    log.mu_translational.y = LogDataMatrix(:, 37);
    log.mu_translational.z = LogDataMatrix(:, 38);
    log.control_input.U1 = LogDataMatrix(:, 39);
    log.control_input.U2 = LogDataMatrix(:, 40);
    log.control_input.U3 = LogDataMatrix(:, 41);
    log.control_input.U4 = LogDataMatrix(:, 42);
    log.reference_euler_angles.roll = LogDataMatrix(:, 43);
    log.reference_euler_angles.pitch = LogDataMatrix(:, 44);
    log.reference_euler_angles.roll_dot = LogDataMatrix(:, 45);
    log.reference_euler_angles.pitch_dot = LogDataMatrix(:, 46);
    log.reference_euler_angles.roll_dot_dot = LogDataMatrix(:, 47);
    log.reference_euler_angles.pitch_dot_dot = LogDataMatrix(:, 48);
    log.euler_angles_dot.roll_dot = LogDataMatrix(:, 49);
    log.euler_angles_dot.pitch_dot = LogDataMatrix(:, 50);
    log.euler_angles_dot.yaw_dot = LogDataMatrix(:, 51);
    log.thrust_motors_quadcopter_N.T1 = LogDataMatrix(:, 52);
    log.thrust_motors_quadcopter_N.T2 = LogDataMatrix(:, 53);
    log.thrust_motors_quadcopter_N.T3 = LogDataMatrix(:, 54);
    log.thrust_motors_quadcopter_N.T4 = LogDataMatrix(:, 55);
    log.thrust_motors_quadcopter_normalized.T1 = LogDataMatrix(:, 56);
    log.thrust_motors_quadcopter_normalized.T2 = LogDataMatrix(:, 57);
    log.thrust_motors_quadcopter_normalized.T3 = LogDataMatrix(:, 58);
    log.thrust_motors_quadcopter_normalized.T4 = LogDataMatrix(:, 59);
    log.thrust_motors_N.T1 = LogDataMatrix(:, 60);
    log.thrust_motors_N.T2 = LogDataMatrix(:, 61);
    log.thrust_motors_N.T3 = LogDataMatrix(:, 62);
    log.thrust_motors_N.T4 = LogDataMatrix(:, 63);
    log.thrust_motors_N.T5 = LogDataMatrix(:, 64);
    log.thrust_motors_N.T6 = LogDataMatrix(:, 65);
    log.thrust_motors_N.T7 = LogDataMatrix(:, 66);
    log.thrust_motors_N.T8 = LogDataMatrix(:, 67);
    log.thrust_motors_normalized.T1 = LogDataMatrix(:, 68);
    log.thrust_motors_normalized.T2 = LogDataMatrix(:, 69);
    log.thrust_motors_normalized.T3 = LogDataMatrix(:, 70);
    log.thrust_motors_normalized.T4 = LogDataMatrix(:, 71);
    log.thrust_motors_normalized.T5 = LogDataMatrix(:, 72);
    log.thrust_motors_normalized.T6 = LogDataMatrix(:, 73);
    log.thrust_motors_normalized.T7 = LogDataMatrix(:, 74);
    log.thrust_motors_normalized.T8 = LogDataMatrix(:, 75);
    log.angular_error.roll = LogDataMatrix(:, 76);
    log.angular_error.pitch = LogDataMatrix(:, 77);
    log.angular_error.yaw = LogDataMatrix(:, 78);
    log.outer_loop.Proportional.x = LogDataMatrix(:, 79);
    log.outer_loop.Proportional.y = LogDataMatrix(:, 80);
    log.outer_loop.Proportional.z = LogDataMatrix(:, 81);
    log.outer_loop.Integral.x = LogDataMatrix(:, 82);
    log.outer_loop.Integral.y = LogDataMatrix(:, 83);
    log.outer_loop.Integral.z = LogDataMatrix(:, 84);
    log.outer_loop.Derivative.x = LogDataMatrix(:, 85);
    log.outer_loop.Derivative.y = LogDataMatrix(:, 86);
    log.outer_loop.Derivative.z = LogDataMatrix(:, 87);
    log.inner_loop.Proportional.x = LogDataMatrix(:, 88);
    log.inner_loop.Proportional.y = LogDataMatrix(:, 89);
    log.inner_loop.Proportional.z = LogDataMatrix(:, 90);
    log.inner_loop.Integral.x = LogDataMatrix(:, 91);
    log.inner_loop.Integral.y = LogDataMatrix(:, 92);
    log.inner_loop.Integral.z = LogDataMatrix(:, 93);
    log.inner_loop.Derivative.x = LogDataMatrix(:, 94);
    log.inner_loop.Derivative.y = LogDataMatrix(:, 95);
    log.inner_loop.Derivative.z = LogDataMatrix(:, 96);
    log.inner_loop.dynamic_inversion.x = LogDataMatrix(:, 97);
    log.inner_loop.dynamic_inversion.y = LogDataMatrix(:, 98);
    log.inner_loop.dynamic_inversion.z = LogDataMatrix(:, 99);
    
    %----------------------------------------------------------------------
    % DERIVED/COMPUTED VALUES

    % Position error
    der.translational_position_error.x = log.position.x - ...   
                                         log.user_defined_position.x;
    der.translational_position_error.y = log.position.y - ...   
                                         log.user_defined_position.y;
    der.translational_position_error.z = log.position.z - ...   
                                         log.user_defined_position.z;
    der.translational_position_error.norm = ...
        vecnorm([der.translational_position_error.x, ...
                 der.translational_position_error.y, ...
                 der.translational_position_error.z]')';

    % Velocity error
    der.translational_velocity_error.x = log.velocity.x - ...   
                                         log.user_defined_velocity.x;
    der.translational_velocity_error.y = log.velocity.y - ...   
                                         log.user_defined_velocity.y;
    der.translational_velocity_error.z = log.velocity.z - ...   
                                         log.user_defined_velocity.z;

    % Angular error
    der.angular_error.roll = log.euler_angles.roll - ...
                             log.reference_euler_angles.roll;
    der.angular_error.pitch = log.euler_angles.pitch - ...
                              log.reference_euler_angles.pitch;
    der.angular_error.yaw = log.euler_angles.yaw - ...
                            log.user_defined_yaw;

    % Angular error dot
    der.angular_error_dot.roll_dot = log.euler_angles_dot.roll_dot - ...
                                     log.reference_euler_angles.roll_dot;
    der.angular_error_dot.pitch_dot = log.euler_angles_dot.pitch_dot - ...
                                      log.reference_euler_angles.pitch_dot;
    der.angular_error_dot.yaw_dot = log.euler_angles_dot.yaw_dot - ...
                                    log.user_defined_yaw_dot;

    % Total thrust
    der.total_thrust_motors_quadcopter_N = log.thrust_motors_quadcopter_N.T1 + ... 
                                           log.thrust_motors_quadcopter_N.T2 + ...
                                           log.thrust_motors_quadcopter_N.T3 + ...
                                           log.thrust_motors_quadcopter_N.T4;

    % Total thrust
    der.total_thrust_motors_N = log.thrust_motors_N.T1 + ... 
                                log.thrust_motors_N.T2 + ...
                                log.thrust_motors_N.T3 + ...
                                log.thrust_motors_N.T4 + ...
                                log.thrust_motors_N.T5 + ... 
                                log.thrust_motors_N.T6 + ...
                                log.thrust_motors_N.T7 + ...
                                log.thrust_motors_N.T8;

    % Average algorithm execution time
    der.average_algorithm_execution_time_us = ...
        mean(log.algorithm_execution_time_us(log.algorithm_execution_time_us > 0));

    % Standard deviation of algorithm execution time
    der.standard_deviation_algorithm_execution_time_us = ...
        std(log.algorithm_execution_time_us(log.algorithm_execution_time_us > 0));

    der.user_defined_yaw = wrapAngleToMinusPiAndPi(log.user_defined_yaw);

   
    %----------------------------------------------------------------------

    if processMocap
        % Extracting data from the current mocap file
        % disp(['Processing mocap file: ', properties.mocap_filename]); % Debugging statement
        MocapDataMatrix = readmatrix(properties.mocap_filename);
    
        % Check if the mocap file has enough columns
        if size(MocapDataMatrix, 2) < 15
            disp(['Error: The file ', properties.mocap_filename, ' does not have enough columns.']);
            continue; % Skip this iteration and go to the next file
        end
    
        %----------------------------------------------------------------------
        % MOCAP VALUES
    
        mocap.time = MocapDataMatrix(:, 2);
        mocap.position.x = MocapDataMatrix(:, 3);
        mocap.position.y = MocapDataMatrix(:, 4);
        mocap.position.z = MocapDataMatrix(:, 5);
        mocap.quaternion.q0 = MocapDataMatrix(:, 6);
        mocap.quaternion.q1 = MocapDataMatrix(:, 7);
        mocap.quaternion.q2 = MocapDataMatrix(:, 8);
        mocap.quaternion.q3 = MocapDataMatrix(:, 9);
        mocap.velocity.x = MocapDataMatrix(:, 10);
        mocap.velocity.y = MocapDataMatrix(:, 11);
        mocap.velocity.z = MocapDataMatrix(:, 12);
        mocap.angular_velocity.x = MocapDataMatrix(:, 13);
        mocap.angular_velocity.y = MocapDataMatrix(:, 14);
        mocap.angular_velocity.z = MocapDataMatrix(:, 15);
    
        %---------------------------------------------------------------------- 
    
        % Create a quaternion array
        mocap.quaternion.quat = quaternion(mocap.quaternion.q0, ...
                                           mocap.quaternion.q1, ...
                                           mocap.quaternion.q2, ...
                                           mocap.quaternion.q3);
    
        % Specify the sequence for conversion to Euler angles
        mocap.quaternion.sequence = 'ZYX';
        % % mocap.quaternion.sequence = 'XYZ';
    
        % Convert quaternion array to Euler angles
        mocap.quaternion.eulerAnglesFromQuat = quat2eul(mocap.quaternion.quat, ...
                                                        mocap.quaternion.sequence);
    
        % % mocap.euler_angles.roll = mocap.quaternion.eulerAnglesFromQuat(:, 1);
        % % mocap.euler_angles.pitch = mocap.quaternion.eulerAnglesFromQuat(:, 2);
        % % mocap.euler_angles.yaw = mocap.quaternion.eulerAnglesFromQuat(:, 3);
    
        mocap.euler_angles.roll = mocap.quaternion.eulerAnglesFromQuat(:, 3);
        mocap.euler_angles.pitch = mocap.quaternion.eulerAnglesFromQuat(:, 2);
        mocap.euler_angles.yaw = mocap.quaternion.eulerAnglesFromQuat(:, 1);
    end

    % Saving the workspace for the current log file
    save(properties.workspace_filename);
end



