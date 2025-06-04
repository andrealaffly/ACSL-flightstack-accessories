function log = getLogData_PID(LogDataMatrix)
%GETLOGDATA_PID Extract log data for the PID controller

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

    log.desired_euler_angles.roll = LogDataMatrix(:, 43);
    log.desired_euler_angles.pitch = LogDataMatrix(:, 44);
    log.desired_euler_angles.roll_dot = LogDataMatrix(:, 45);
    log.desired_euler_angles.pitch_dot = LogDataMatrix(:, 46);
    log.desired_euler_angles.roll_dot_dot = LogDataMatrix(:, 47);
    log.desired_euler_angles.pitch_dot_dot = LogDataMatrix(:, 48);

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

    log.outer_loop.dynamic_inversion.x = LogDataMatrix(:, 88);
    log.outer_loop.dynamic_inversion.y = LogDataMatrix(:, 89);
    log.outer_loop.dynamic_inversion.z = LogDataMatrix(:, 90);

    log.inner_loop.Proportional.x = LogDataMatrix(:, 91);
    log.inner_loop.Proportional.y = LogDataMatrix(:, 92);
    log.inner_loop.Proportional.z = LogDataMatrix(:, 93);

    log.inner_loop.Integral.x = LogDataMatrix(:, 94);
    log.inner_loop.Integral.y = LogDataMatrix(:, 95);
    log.inner_loop.Integral.z = LogDataMatrix(:, 96);

    log.inner_loop.Derivative.x = LogDataMatrix(:, 97);
    log.inner_loop.Derivative.y = LogDataMatrix(:, 98);
    log.inner_loop.Derivative.z = LogDataMatrix(:, 99);

    log.inner_loop.dynamic_inversion.x = LogDataMatrix(:, 100);
    log.inner_loop.dynamic_inversion.y = LogDataMatrix(:, 101);
    log.inner_loop.dynamic_inversion.z = LogDataMatrix(:, 102);

    
end

