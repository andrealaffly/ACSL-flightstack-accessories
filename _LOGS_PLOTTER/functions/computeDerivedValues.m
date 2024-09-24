function der = computeDerivedValues(log, vp)
%COMPUTEDERIVEDVALUES Compute derived values from the log values

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

    % Angular error dot
    der.angular_error_dot.roll_dot = log.euler_angles_dot.roll_dot - ...
                                     log.desired_euler_angles.roll_dot;
    der.angular_error_dot.pitch_dot = log.euler_angles_dot.pitch_dot - ...
                                      log.desired_euler_angles.pitch_dot;
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

    % User-defined yaw angle Wrapping
    der.user_defined_yaw = wrapAngleToMinusPiAndPi(log.user_defined_yaw);

    % Outer loop - multiplying by mass to obtain values in [N]
    der.outer_loop.Proportional.x = log.outer_loop.Proportional.x * vp.mass;
    der.outer_loop.Proportional.y = log.outer_loop.Proportional.y * vp.mass;
    der.outer_loop.Proportional.z = log.outer_loop.Proportional.z * vp.mass;

    der.outer_loop.Integral.x = log.outer_loop.Integral.x * vp.mass;
    der.outer_loop.Integral.y = log.outer_loop.Integral.y * vp.mass;
    der.outer_loop.Integral.z = log.outer_loop.Integral.z * vp.mass;

    der.outer_loop.Derivative.x = log.outer_loop.Derivative.x * vp.mass;
    der.outer_loop.Derivative.y = log.outer_loop.Derivative.y * vp.mass;
    der.outer_loop.Derivative.z = log.outer_loop.Derivative.z * vp.mass;

    % Inner loop - multiplying by inertia matrix to obtain values in [Nm]
    internal.inner_loop.Proportional.raw = [log.inner_loop.Proportional.x';
                                            log.inner_loop.Proportional.y';
                                            log.inner_loop.Proportional.z'];

    internal.inner_loop.Integral.raw = [log.inner_loop.Integral.x';
                                        log.inner_loop.Integral.y';
                                        log.inner_loop.Integral.z'];

    internal.inner_loop.Derivative.raw = [log.inner_loop.Derivative.x';
                                          log.inner_loop.Derivative.y';
                                          log.inner_loop.Derivative.z'];

    for i = 1:size(internal.inner_loop.Proportional.raw,2)
        
        internal.inner_loop.Proportional.adjusted(:,i) = vp.inertia_mat * ...
            internal.inner_loop.Proportional.raw(:,i);

        internal.inner_loop.Integral.adjusted(:,i) = vp.inertia_mat * ...
            internal.inner_loop.Integral.raw(:,i);

        internal.inner_loop.Derivative.adjusted(:,i) = vp.inertia_mat * ...
            internal.inner_loop.Derivative.raw(:,i);
    
        der.inner_loop.Proportional.x(i,1) = internal.inner_loop.Proportional.adjusted(1,i);
        der.inner_loop.Proportional.y(i,1) = internal.inner_loop.Proportional.adjusted(2,i);
        der.inner_loop.Proportional.z(i,1) = internal.inner_loop.Proportional.adjusted(3,i);

        der.inner_loop.Integral.x(i,1) = internal.inner_loop.Integral.adjusted(1,i);
        der.inner_loop.Integral.y(i,1) = internal.inner_loop.Integral.adjusted(2,i);
        der.inner_loop.Integral.z(i,1) = internal.inner_loop.Integral.adjusted(3,i);

        der.inner_loop.Derivative.x(i,1) = internal.inner_loop.Derivative.adjusted(1,i);
        der.inner_loop.Derivative.y(i,1) = internal.inner_loop.Derivative.adjusted(2,i);
        der.inner_loop.Derivative.z(i,1) = internal.inner_loop.Derivative.adjusted(3,i);
    end

end

