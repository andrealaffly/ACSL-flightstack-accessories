function log = getLogData_FunTLMRAC(LogDataMatrix)
%GETLOGDATA_TLMRAC Extract log data for the Two-Layer MRAC controller

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

    log.mu_translational_raw_global.x = LogDataMatrix(:, 33);
    log.mu_translational_raw_global.y = LogDataMatrix(:, 34);
    log.mu_translational_raw_global.z = LogDataMatrix(:, 35);

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

    log.outer_loop.reference_model.position.x = LogDataMatrix(:, 103);
    log.outer_loop.reference_model.position.y = LogDataMatrix(:, 104);
    log.outer_loop.reference_model.position.z = LogDataMatrix(:, 105);
    log.outer_loop.reference_model.velocity.x = LogDataMatrix(:, 106);
    log.outer_loop.reference_model.velocity.y = LogDataMatrix(:, 107);
    log.outer_loop.reference_model.velocity.z = LogDataMatrix(:, 108);

    log.outer_loop.K_hat_x.ind00 = LogDataMatrix(:, 109);
    log.outer_loop.K_hat_x.ind10 = LogDataMatrix(:, 110);
    log.outer_loop.K_hat_x.ind20 = LogDataMatrix(:, 111);
    log.outer_loop.K_hat_x.ind30 = LogDataMatrix(:, 112);
    log.outer_loop.K_hat_x.ind40 = LogDataMatrix(:, 113);
    log.outer_loop.K_hat_x.ind50 = LogDataMatrix(:, 114);
    log.outer_loop.K_hat_x.ind01 = LogDataMatrix(:, 115);
    log.outer_loop.K_hat_x.ind11 = LogDataMatrix(:, 116);
    log.outer_loop.K_hat_x.ind21 = LogDataMatrix(:, 117);
    log.outer_loop.K_hat_x.ind31 = LogDataMatrix(:, 118);
    log.outer_loop.K_hat_x.ind41 = LogDataMatrix(:, 119);
    log.outer_loop.K_hat_x.ind51 = LogDataMatrix(:, 120);
    log.outer_loop.K_hat_x.ind02 = LogDataMatrix(:, 121);
    log.outer_loop.K_hat_x.ind12 = LogDataMatrix(:, 122);
    log.outer_loop.K_hat_x.ind22 = LogDataMatrix(:, 123);
    log.outer_loop.K_hat_x.ind32 = LogDataMatrix(:, 124);
    log.outer_loop.K_hat_x.ind42 = LogDataMatrix(:, 125);
    log.outer_loop.K_hat_x.ind52 = LogDataMatrix(:, 126);

    log.outer_loop.K_hat_r.ind00 = LogDataMatrix(:, 127);
    log.outer_loop.K_hat_r.ind10 = LogDataMatrix(:, 128);
    log.outer_loop.K_hat_r.ind20 = LogDataMatrix(:, 129);
    log.outer_loop.K_hat_r.ind01 = LogDataMatrix(:, 130);
    log.outer_loop.K_hat_r.ind11 = LogDataMatrix(:, 131);
    log.outer_loop.K_hat_r.ind21 = LogDataMatrix(:, 132);
    log.outer_loop.K_hat_r.ind02 = LogDataMatrix(:, 133);
    log.outer_loop.K_hat_r.ind12 = LogDataMatrix(:, 134);
    log.outer_loop.K_hat_r.ind22 = LogDataMatrix(:, 135);

    log.outer_loop.Theta_hat.ind00 = LogDataMatrix(:, 136);
    log.outer_loop.Theta_hat.ind10 = LogDataMatrix(:, 137);
    log.outer_loop.Theta_hat.ind20 = LogDataMatrix(:, 138);
    log.outer_loop.Theta_hat.ind30 = LogDataMatrix(:, 139);
    log.outer_loop.Theta_hat.ind40 = LogDataMatrix(:, 140);
    log.outer_loop.Theta_hat.ind50 = LogDataMatrix(:, 141);
    log.outer_loop.Theta_hat.ind01 = LogDataMatrix(:, 142);
    log.outer_loop.Theta_hat.ind11 = LogDataMatrix(:, 143);
    log.outer_loop.Theta_hat.ind21 = LogDataMatrix(:, 144);
    log.outer_loop.Theta_hat.ind31 = LogDataMatrix(:, 145);
    log.outer_loop.Theta_hat.ind41 = LogDataMatrix(:, 146);
    log.outer_loop.Theta_hat.ind51 = LogDataMatrix(:, 147);
    log.outer_loop.Theta_hat.ind02 = LogDataMatrix(:, 148);
    log.outer_loop.Theta_hat.ind12 = LogDataMatrix(:, 149);
    log.outer_loop.Theta_hat.ind22 = LogDataMatrix(:, 150);
    log.outer_loop.Theta_hat.ind32 = LogDataMatrix(:, 151);
    log.outer_loop.Theta_hat.ind42 = LogDataMatrix(:, 152);
    log.outer_loop.Theta_hat.ind52 = LogDataMatrix(:, 153);

    log.inner_loop.reference_model.angular_velocity.x = LogDataMatrix(:, 154);
    log.inner_loop.reference_model.angular_velocity.y = LogDataMatrix(:, 155);
    log.inner_loop.reference_model.angular_velocity.z = LogDataMatrix(:, 156);

    log.inner_loop.K_hat_x.ind00 = LogDataMatrix(:, 157);
    log.inner_loop.K_hat_x.ind10 = LogDataMatrix(:, 158);
    log.inner_loop.K_hat_x.ind20 = LogDataMatrix(:, 159);
    log.inner_loop.K_hat_x.ind01 = LogDataMatrix(:, 160);
    log.inner_loop.K_hat_x.ind11 = LogDataMatrix(:, 161);
    log.inner_loop.K_hat_x.ind21 = LogDataMatrix(:, 162);
    log.inner_loop.K_hat_x.ind02 = LogDataMatrix(:, 163);
    log.inner_loop.K_hat_x.ind12 = LogDataMatrix(:, 164);
    log.inner_loop.K_hat_x.ind22 = LogDataMatrix(:, 165);

    log.inner_loop.K_hat_r.ind00 = LogDataMatrix(:, 166);
    log.inner_loop.K_hat_r.ind10 = LogDataMatrix(:, 167);
    log.inner_loop.K_hat_r.ind20 = LogDataMatrix(:, 168);
    log.inner_loop.K_hat_r.ind01 = LogDataMatrix(:, 169);
    log.inner_loop.K_hat_r.ind11 = LogDataMatrix(:, 170);
    log.inner_loop.K_hat_r.ind21 = LogDataMatrix(:, 171);
    log.inner_loop.K_hat_r.ind02 = LogDataMatrix(:, 172);
    log.inner_loop.K_hat_r.ind12 = LogDataMatrix(:, 173);
    log.inner_loop.K_hat_r.ind22 = LogDataMatrix(:, 174);

    log.inner_loop.Theta_hat.ind00 = LogDataMatrix(:, 175);
    log.inner_loop.Theta_hat.ind10 = LogDataMatrix(:, 176);
    log.inner_loop.Theta_hat.ind20 = LogDataMatrix(:, 177);
    log.inner_loop.Theta_hat.ind30 = LogDataMatrix(:, 178);
    log.inner_loop.Theta_hat.ind40 = LogDataMatrix(:, 179);
    log.inner_loop.Theta_hat.ind50 = LogDataMatrix(:, 180);
    log.inner_loop.Theta_hat.ind01 = LogDataMatrix(:, 181);
    log.inner_loop.Theta_hat.ind11 = LogDataMatrix(:, 182);
    log.inner_loop.Theta_hat.ind21 = LogDataMatrix(:, 183);
    log.inner_loop.Theta_hat.ind31 = LogDataMatrix(:, 184);
    log.inner_loop.Theta_hat.ind41 = LogDataMatrix(:, 185);
    log.inner_loop.Theta_hat.ind51 = LogDataMatrix(:, 186);
    log.inner_loop.Theta_hat.ind02 = LogDataMatrix(:, 187);
    log.inner_loop.Theta_hat.ind12 = LogDataMatrix(:, 188);
    log.inner_loop.Theta_hat.ind22 = LogDataMatrix(:, 189);
    log.inner_loop.Theta_hat.ind32 = LogDataMatrix(:, 190);
    log.inner_loop.Theta_hat.ind42 = LogDataMatrix(:, 191);
    log.inner_loop.Theta_hat.ind52 = LogDataMatrix(:, 192);

    log.outer_loop.r_cmd.x = LogDataMatrix(:, 193);
    log.outer_loop.r_cmd.y = LogDataMatrix(:, 194);
    log.outer_loop.r_cmd.z = LogDataMatrix(:, 195);

    log.outer_loop.mu_PID_baseline.x = LogDataMatrix(:, 196);
    log.outer_loop.mu_PID_baseline.y = LogDataMatrix(:, 197);
    log.outer_loop.mu_PID_baseline.z = LogDataMatrix(:, 198);

    log.outer_loop.mu_adaptive.x = LogDataMatrix(:, 199);
    log.outer_loop.mu_adaptive.y = LogDataMatrix(:, 200);
    log.outer_loop.mu_adaptive.z = LogDataMatrix(:, 201);

    log.inner_loop.omega_cmd.x = LogDataMatrix(:, 202);
    log.inner_loop.omega_cmd.y = LogDataMatrix(:, 203);
    log.inner_loop.omega_cmd.z = LogDataMatrix(:, 204);

    log.inner_loop.r_cmd.x = LogDataMatrix(:, 205);
    log.inner_loop.r_cmd.y = LogDataMatrix(:, 206);
    log.inner_loop.r_cmd.z = LogDataMatrix(:, 207);

    log.inner_loop.tau_PID_baseline.x = LogDataMatrix(:, 208);
    log.inner_loop.tau_PID_baseline.y = LogDataMatrix(:, 209);
    log.inner_loop.tau_PID_baseline.z = LogDataMatrix(:, 210);

    log.inner_loop.tau_adaptive.x = LogDataMatrix(:, 211);
    log.inner_loop.tau_adaptive.y = LogDataMatrix(:, 212);
    log.inner_loop.tau_adaptive.z = LogDataMatrix(:, 213);

    log.outer_loop.dead_zone_value = LogDataMatrix(:, 214);
    log.inner_loop.dead_zone_value = LogDataMatrix(:, 215);

    log.outer_loop.K_hat_g.ind00 = LogDataMatrix(:, 216);
    log.outer_loop.K_hat_g.ind10 = LogDataMatrix(:, 217);
    log.outer_loop.K_hat_g.ind20 = LogDataMatrix(:, 218);
    log.outer_loop.K_hat_g.ind30 = LogDataMatrix(:, 219);
    log.outer_loop.K_hat_g.ind40 = LogDataMatrix(:, 220);
    log.outer_loop.K_hat_g.ind50 = LogDataMatrix(:, 221);
    log.outer_loop.K_hat_g.ind01 = LogDataMatrix(:, 222);
    log.outer_loop.K_hat_g.ind11 = LogDataMatrix(:, 223);
    log.outer_loop.K_hat_g.ind21 = LogDataMatrix(:, 224);
    log.outer_loop.K_hat_g.ind31 = LogDataMatrix(:, 225);
    log.outer_loop.K_hat_g.ind41 = LogDataMatrix(:, 226);
    log.outer_loop.K_hat_g.ind51 = LogDataMatrix(:, 227);
    log.outer_loop.K_hat_g.ind02 = LogDataMatrix(:, 228);
    log.outer_loop.K_hat_g.ind12 = LogDataMatrix(:, 229);
    log.outer_loop.K_hat_g.ind22 = LogDataMatrix(:, 230);
    log.outer_loop.K_hat_g.ind32 = LogDataMatrix(:, 231);
    log.outer_loop.K_hat_g.ind42 = LogDataMatrix(:, 232);
    log.outer_loop.K_hat_g.ind52 = LogDataMatrix(:, 233);

    log.inner_loop.K_hat_g.ind00 = LogDataMatrix(:, 234);
    log.inner_loop.K_hat_g.ind10 = LogDataMatrix(:, 235);
    log.inner_loop.K_hat_g.ind20 = LogDataMatrix(:, 236);
    log.inner_loop.K_hat_g.ind01 = LogDataMatrix(:, 237);
    log.inner_loop.K_hat_g.ind11 = LogDataMatrix(:, 238);
    log.inner_loop.K_hat_g.ind21 = LogDataMatrix(:, 239);
    log.inner_loop.K_hat_g.ind02 = LogDataMatrix(:, 240);
    log.inner_loop.K_hat_g.ind12 = LogDataMatrix(:, 241);
    log.inner_loop.K_hat_g.ind22 = LogDataMatrix(:, 242);

    log.outer_loop.proj_op_activated_K_hat_x = LogDataMatrix(:, 243);
    log.outer_loop.proj_op_activated_K_hat_r = LogDataMatrix(:, 244);
    log.outer_loop.proj_op_activated_Theta_hat = LogDataMatrix(:, 245);
    log.outer_loop.proj_op_activated_K_hat_g = LogDataMatrix(:, 246);
    log.inner_loop.proj_op_activated_K_hat_x = LogDataMatrix(:, 247);
    log.inner_loop.proj_op_activated_K_hat_r = LogDataMatrix(:, 248);
    log.inner_loop.proj_op_activated_Theta_hat = LogDataMatrix(:, 249);
    log.inner_loop.proj_op_activated_K_hat_g = LogDataMatrix(:, 250);

    log.mu_translational_raw_local.x = LogDataMatrix(:, 251);
    log.mu_translational_raw_local.y = LogDataMatrix(:, 252);
    log.mu_translational_raw_local.z = LogDataMatrix(:, 253);

    log.safety_mechanism.tSphere = LogDataMatrix(:, 254);
    log.safety_mechanism.tEllipticCone = LogDataMatrix(:, 255);
    log.safety_mechanism.tPlane = LogDataMatrix(:, 256);
    log.safety_mechanism.tPrime = LogDataMatrix(:, 257);
    log.safety_mechanism.safe_mech_activated = LogDataMatrix(:, 258);

    log.outer_loop.funnel.eta = LogDataMatrix(:, 259);
    log.outer_loop.funnel.active_condition = LogDataMatrix(:, 260);
    log.outer_loop.funnel.xi = LogDataMatrix(:, 261);
   
end




















