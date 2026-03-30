function der = computeDerivedValues_HybTLMRAC(der, log, vp, gains)
%COMPUTEDERIVEDVALUES Compute derived values from the log values

    omega_ref = [log.inner_loop.reference_model.angular_velocity.x';
                 log.inner_loop.reference_model.angular_velocity.y';
                 log.inner_loop.reference_model.angular_velocity.z'];

    r_inner_loop_cmd = [log.inner_loop.omega_cmd.x';
                        log.inner_loop.omega_cmd.y';
                        log.inner_loop.omega_cmd.z'];

    for ii = 1:length(log.time)
        % INNER LOOP omega_ref_dot
        omega_ref_dot = gains.DER.A_ref_rotational * omega_ref(:,ii) + ...
                        gains.DER.B_ref_rotational * r_inner_loop_cmd(:,ii);

        der.inner_loop.omega_ref_dot.x(ii,1) = omega_ref_dot(1);
        der.inner_loop.omega_ref_dot.y(ii,1) = omega_ref_dot(2);
        der.inner_loop.omega_ref_dot.z(ii,1) = omega_ref_dot(3);

        % INNER LOOP feed_forward_accel_term
        feed_forward_accel_term = vp.inertia_mat * omega_ref_dot;

        der.inner_loop.feed_forward_accel_term.x(ii,1) = feed_forward_accel_term(1);
        der.inner_loop.feed_forward_accel_term.y(ii,1) = feed_forward_accel_term(2);
        der.inner_loop.feed_forward_accel_term.z(ii,1) = feed_forward_accel_term(3);

        % OUTER LOOP u_adaptive_K_hat_x 
        K_hat_x_outer_loop = [log.outer_loop.K_hat_x.ind00(ii) log.outer_loop.K_hat_x.ind01(ii) log.outer_loop.K_hat_x.ind02(ii);
                              log.outer_loop.K_hat_x.ind10(ii) log.outer_loop.K_hat_x.ind11(ii) log.outer_loop.K_hat_x.ind12(ii);
                              log.outer_loop.K_hat_x.ind20(ii) log.outer_loop.K_hat_x.ind21(ii) log.outer_loop.K_hat_x.ind22(ii);
                              log.outer_loop.K_hat_x.ind30(ii) log.outer_loop.K_hat_x.ind31(ii) log.outer_loop.K_hat_x.ind32(ii);
                              log.outer_loop.K_hat_x.ind40(ii) log.outer_loop.K_hat_x.ind41(ii) log.outer_loop.K_hat_x.ind42(ii);
                              log.outer_loop.K_hat_x.ind50(ii) log.outer_loop.K_hat_x.ind51(ii) log.outer_loop.K_hat_x.ind52(ii)];
        % OUTER LOOP K_hat_x Frobenius norm
        der.outer_loop.K_hat_x_norm(ii,1) = norm(K_hat_x_outer_loop,'fro');

        x_outer_loop = [log.outer_loop.reference_model.position.x(ii);
                        log.outer_loop.reference_model.position.y(ii);
                        log.outer_loop.reference_model.position.z(ii);
                        log.outer_loop.reference_model.velocity.x(ii);
                        log.outer_loop.reference_model.velocity.y(ii);
                        log.outer_loop.reference_model.velocity.z(ii)];

        u_ad_K_hat_x_outer_loop = K_hat_x_outer_loop' * x_outer_loop;

        der.outer_loop.u_adaptive_K_hat_x.x(ii,1) = u_ad_K_hat_x_outer_loop(1);
        der.outer_loop.u_adaptive_K_hat_x.y(ii,1) = u_ad_K_hat_x_outer_loop(2);
        der.outer_loop.u_adaptive_K_hat_x.z(ii,1) = u_ad_K_hat_x_outer_loop(3);

        % OUTER LOOP u_adaptive_K_hat_r 
        K_hat_r_outer_loop = [log.outer_loop.K_hat_r.ind00(ii) log.outer_loop.K_hat_r.ind01(ii) log.outer_loop.K_hat_r.ind02(ii);
                              log.outer_loop.K_hat_r.ind10(ii) log.outer_loop.K_hat_r.ind11(ii) log.outer_loop.K_hat_r.ind12(ii);
                              log.outer_loop.K_hat_r.ind20(ii) log.outer_loop.K_hat_r.ind21(ii) log.outer_loop.K_hat_r.ind22(ii)];
        % OUTER LOOP K_hat_r Frobenius norm
        der.outer_loop.K_hat_r_norm(ii,1) = norm(K_hat_r_outer_loop,'fro');

        r_cmd_outer_loop = [log.outer_loop.r_cmd.x(ii);
                            log.outer_loop.r_cmd.y(ii);
                            log.outer_loop.r_cmd.z(ii)];

        u_ad_K_hat_r_outer_loop = K_hat_r_outer_loop' * r_cmd_outer_loop;

        der.outer_loop.u_adaptive_K_hat_r.x(ii,1) = u_ad_K_hat_r_outer_loop(1);
        der.outer_loop.u_adaptive_K_hat_r.y(ii,1) = u_ad_K_hat_r_outer_loop(2);
        der.outer_loop.u_adaptive_K_hat_r.z(ii,1) = u_ad_K_hat_r_outer_loop(3);

        % OUTER LOOP u_adaptive_Theta_hat 
        Theta_hat_outer_loop = [log.outer_loop.Theta_hat.ind00(ii) log.outer_loop.Theta_hat.ind01(ii) log.outer_loop.Theta_hat.ind02(ii);
                                log.outer_loop.Theta_hat.ind10(ii) log.outer_loop.Theta_hat.ind11(ii) log.outer_loop.Theta_hat.ind12(ii);
                                log.outer_loop.Theta_hat.ind20(ii) log.outer_loop.Theta_hat.ind21(ii) log.outer_loop.Theta_hat.ind22(ii);
                                log.outer_loop.Theta_hat.ind30(ii) log.outer_loop.Theta_hat.ind31(ii) log.outer_loop.Theta_hat.ind32(ii);
                                log.outer_loop.Theta_hat.ind40(ii) log.outer_loop.Theta_hat.ind41(ii) log.outer_loop.Theta_hat.ind42(ii);
                                log.outer_loop.Theta_hat.ind50(ii) log.outer_loop.Theta_hat.ind51(ii) log.outer_loop.Theta_hat.ind52(ii)];
        % OUTER LOOP Theta_hat Frobenius norm
        der.outer_loop.Theta_hat_norm(ii,1) = norm(Theta_hat_outer_loop,'fro');

        rotation_matrix_321_global_to_local = ...
          rotationMatrix321GlobalToLocal(log.euler_angles.roll(ii), ...
                                         log.euler_angles.pitch(ii), ...
                                         log.euler_angles.yaw(ii));

        velocity_expr_in_local = rotation_matrix_321_global_to_local * ...
          [log.velocity.x(ii); log.velocity.y(ii); log.velocity.z(ii)];

        regressor_vector_aerodynamics_outer_loop = ...
          -0.5 * norm(velocity_expr_in_local) * velocity_expr_in_local;

        phi_outer_loop = [log.outer_loop.mu_PID_baseline.x(ii);
                          log.outer_loop.mu_PID_baseline.y(ii);
                          log.outer_loop.mu_PID_baseline.z(ii);
                          regressor_vector_aerodynamics_outer_loop(1);
                          regressor_vector_aerodynamics_outer_loop(2);
                          regressor_vector_aerodynamics_outer_loop(3)];

        u_ad_Theta_hat_outer_loop = - Theta_hat_outer_loop' * phi_outer_loop;

        der.outer_loop.u_adaptive_Theta_hat.x(ii,1) = u_ad_Theta_hat_outer_loop(1);
        der.outer_loop.u_adaptive_Theta_hat.y(ii,1) = u_ad_Theta_hat_outer_loop(2);
        der.outer_loop.u_adaptive_Theta_hat.z(ii,1) = u_ad_Theta_hat_outer_loop(3);

        % OUTER LOOP u_adaptive_K_hat_g 
        K_hat_g_outer_loop = [log.outer_loop.K_hat_g.ind00(ii) log.outer_loop.K_hat_g.ind01(ii) log.outer_loop.K_hat_g.ind02(ii);
                              log.outer_loop.K_hat_g.ind10(ii) log.outer_loop.K_hat_g.ind11(ii) log.outer_loop.K_hat_g.ind12(ii);
                              log.outer_loop.K_hat_g.ind20(ii) log.outer_loop.K_hat_g.ind21(ii) log.outer_loop.K_hat_g.ind22(ii);
                              log.outer_loop.K_hat_g.ind30(ii) log.outer_loop.K_hat_g.ind31(ii) log.outer_loop.K_hat_g.ind32(ii);
                              log.outer_loop.K_hat_g.ind40(ii) log.outer_loop.K_hat_g.ind41(ii) log.outer_loop.K_hat_g.ind42(ii);
                              log.outer_loop.K_hat_g.ind50(ii) log.outer_loop.K_hat_g.ind51(ii) log.outer_loop.K_hat_g.ind52(ii)];
        % OUTER LOOP K_hat_g Frobenius norm
        der.outer_loop.K_hat_g_norm(ii,1) = norm(K_hat_g_outer_loop,'fro');

        tracking_error_translational = ...
            [log.position.x(ii) - log.outer_loop.reference_model.position.x(ii);
             log.position.y(ii) - log.outer_loop.reference_model.position.y(ii);
             log.position.z(ii) - log.outer_loop.reference_model.position.z(ii);
             log.velocity.x(ii) - log.outer_loop.reference_model.velocity.x(ii);
             log.velocity.y(ii) - log.outer_loop.reference_model.velocity.y(ii);
             log.velocity.z(ii) - log.outer_loop.reference_model.velocity.z(ii)];

        u_ad_K_hat_g_outer_loop = K_hat_g_outer_loop' * tracking_error_translational;

        der.outer_loop.u_adaptive_K_hat_g.x(ii,1) = u_ad_K_hat_g_outer_loop(1);
        der.outer_loop.u_adaptive_K_hat_g.y(ii,1) = u_ad_K_hat_g_outer_loop(2);
        der.outer_loop.u_adaptive_K_hat_g.z(ii,1) = u_ad_K_hat_g_outer_loop(3);

        % INNER LOOP u_adaptive_K_hat_x 
        K_hat_x_inner_loop = [log.inner_loop.K_hat_x.ind00(ii) log.inner_loop.K_hat_x.ind01(ii) log.inner_loop.K_hat_x.ind02(ii);
                              log.inner_loop.K_hat_x.ind10(ii) log.inner_loop.K_hat_x.ind11(ii) log.inner_loop.K_hat_x.ind12(ii);
                              log.inner_loop.K_hat_x.ind20(ii) log.inner_loop.K_hat_x.ind21(ii) log.inner_loop.K_hat_x.ind22(ii)];

        x_inner_loop = [log.inner_loop.reference_model.angular_velocity.x(ii);
                        log.inner_loop.reference_model.angular_velocity.y(ii);
                        log.inner_loop.reference_model.angular_velocity.z(ii)];

        u_ad_K_hat_x_inner_loop = K_hat_x_inner_loop' * x_inner_loop;

        der.inner_loop.u_adaptive_K_hat_x.x(ii,1) = u_ad_K_hat_x_inner_loop(1);
        der.inner_loop.u_adaptive_K_hat_x.y(ii,1) = u_ad_K_hat_x_inner_loop(2);
        der.inner_loop.u_adaptive_K_hat_x.z(ii,1) = u_ad_K_hat_x_inner_loop(3);

        % INNER LOOP u_adaptive_K_hat_r 
        K_hat_r_inner_loop = [log.inner_loop.K_hat_r.ind00(ii) log.inner_loop.K_hat_r.ind01(ii) log.inner_loop.K_hat_r.ind02(ii);
                              log.inner_loop.K_hat_r.ind10(ii) log.inner_loop.K_hat_r.ind11(ii) log.inner_loop.K_hat_r.ind12(ii);
                              log.inner_loop.K_hat_r.ind20(ii) log.inner_loop.K_hat_r.ind21(ii) log.inner_loop.K_hat_r.ind22(ii)];

        r_cmd_inner_loop = [log.inner_loop.r_cmd.x(ii);
                            log.inner_loop.r_cmd.y(ii);
                            log.inner_loop.r_cmd.z(ii)];

        u_ad_K_hat_r_inner_loop = K_hat_r_inner_loop' * r_cmd_inner_loop;

        der.inner_loop.u_adaptive_K_hat_r.x(ii,1) = u_ad_K_hat_r_inner_loop(1);
        der.inner_loop.u_adaptive_K_hat_r.y(ii,1) = u_ad_K_hat_r_inner_loop(2);
        der.inner_loop.u_adaptive_K_hat_r.z(ii,1) = u_ad_K_hat_r_inner_loop(3);

        % INNER LOOP u_adaptive_Theta_hat 
        Theta_hat_inner_loop = [log.inner_loop.Theta_hat.ind00(ii) log.inner_loop.Theta_hat.ind01(ii) log.inner_loop.Theta_hat.ind02(ii);
                                log.inner_loop.Theta_hat.ind10(ii) log.inner_loop.Theta_hat.ind11(ii) log.inner_loop.Theta_hat.ind12(ii);
                                log.inner_loop.Theta_hat.ind20(ii) log.inner_loop.Theta_hat.ind21(ii) log.inner_loop.Theta_hat.ind22(ii);
                                log.inner_loop.Theta_hat.ind30(ii) log.inner_loop.Theta_hat.ind31(ii) log.inner_loop.Theta_hat.ind32(ii);
                                log.inner_loop.Theta_hat.ind40(ii) log.inner_loop.Theta_hat.ind41(ii) log.inner_loop.Theta_hat.ind42(ii);
                                log.inner_loop.Theta_hat.ind50(ii) log.inner_loop.Theta_hat.ind51(ii) log.inner_loop.Theta_hat.ind52(ii)];

        regressor_vector_omegaXIomega_inner_loop = ...
          [log.angular_velocity.y(ii) * log.angular_velocity.z(ii);
           log.angular_velocity.x(ii) * log.angular_velocity.z(ii);
           log.angular_velocity.x(ii) * log.angular_velocity.y(ii)];

        phi_inner_loop = [log.inner_loop.tau_PID_baseline.x(ii);
                          log.inner_loop.tau_PID_baseline.y(ii);
                          log.inner_loop.tau_PID_baseline.z(ii);
                          regressor_vector_omegaXIomega_inner_loop(1);
                          regressor_vector_omegaXIomega_inner_loop(2);
                          regressor_vector_omegaXIomega_inner_loop(3)];

        u_ad_Theta_hat_inner_loop = - Theta_hat_inner_loop' * phi_inner_loop;

        der.inner_loop.u_adaptive_Theta_hat.x(ii,1) = u_ad_Theta_hat_inner_loop(1);
        der.inner_loop.u_adaptive_Theta_hat.y(ii,1) = u_ad_Theta_hat_inner_loop(2);
        der.inner_loop.u_adaptive_Theta_hat.z(ii,1) = u_ad_Theta_hat_inner_loop(3);

        % INNER LOOP u_adaptive_K_hat_g 
        K_hat_g_inner_loop = [log.inner_loop.K_hat_g.ind00(ii) log.inner_loop.K_hat_g.ind01(ii) log.inner_loop.K_hat_g.ind02(ii);
                              log.inner_loop.K_hat_g.ind10(ii) log.inner_loop.K_hat_g.ind11(ii) log.inner_loop.K_hat_g.ind12(ii);
                              log.inner_loop.K_hat_g.ind20(ii) log.inner_loop.K_hat_g.ind21(ii) log.inner_loop.K_hat_g.ind22(ii)];

        tracking_error_rotational = ...
            [log.angular_velocity.x(ii) - log.inner_loop.reference_model.angular_velocity.x(ii);
             log.angular_velocity.y(ii) - log.inner_loop.reference_model.angular_velocity.y(ii);
             log.angular_velocity.z(ii) - log.inner_loop.reference_model.angular_velocity.z(ii)];

        u_ad_K_hat_g_inner_loop = K_hat_g_inner_loop' * tracking_error_rotational;

        der.inner_loop.u_adaptive_K_hat_g.x(ii,1) = u_ad_K_hat_g_inner_loop(1);
        der.inner_loop.u_adaptive_K_hat_g.y(ii,1) = u_ad_K_hat_g_inner_loop(2);
        der.inner_loop.u_adaptive_K_hat_g.z(ii,1) = u_ad_K_hat_g_inner_loop(3);
          
        % OUTER LOOP trajectory tracking error norm
        der.outer_loop.tracking_error_norm(ii,1) = norm(tracking_error_translational);

        % OUTER LOOP tracking error wrt User-Defined Trajectory
        tracking_error_userdeftraj_translational = ...
            [log.position.x(ii) - log.user_defined_position.x(ii);
             log.position.y(ii) - log.user_defined_position.y(ii);
             log.position.z(ii) - log.user_defined_position.z(ii);
             log.velocity.x(ii) - log.user_defined_velocity.x(ii);
             log.velocity.y(ii) - log.user_defined_velocity.y(ii);
             log.velocity.z(ii) - log.user_defined_velocity.z(ii)];

        der.outer_loop.tracking_error_userdeftraj_norm(ii,1) = norm(tracking_error_userdeftraj_translational);

        % INNER LOOP trajectory tracking error norm
        der.inner_loop.tracking_error_norm(ii,1) = norm(tracking_error_rotational);

    end

    % OUTER LOOP L2 norm
    der.outer_loop.tracking_error_L2norm = computeL2norm( ...
        log.time, ...
        der.outer_loop.tracking_error_norm, ...
        10);

    % OUTER LOOP L2 norm wrt User-Defined Trajectory
    der.outer_loop.tracking_error_userdeftraj_L2norm = computeL2norm( ...
        log.time, ...
        der.outer_loop.tracking_error_userdeftraj_norm, ...
        10);


end

