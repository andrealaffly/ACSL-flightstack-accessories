function [der, controller_matrices] = computeDerivedValues_FunTLMRAC(der, log, vp, gains)
%COMPUTEDERIVEDVALUES Compute derived values from the log values

    controller_matrices = controllerMatrices_FunTLMRAC(vp, gains);

    omega_ref = [log.inner_loop.reference_model.angular_velocity.x';
                 log.inner_loop.reference_model.angular_velocity.y';
                 log.inner_loop.reference_model.angular_velocity.z'];

    r_inner_loop_cmd = [log.inner_loop.omega_cmd.x';
                        log.inner_loop.omega_cmd.y';
                        log.inner_loop.omega_cmd.z'];

    for ii = 1:length(log.time)
        % INNER LOOP omega_ref_dot
        omega_ref_dot = controller_matrices.A_ref_rotational * omega_ref(:,ii) + ...
                        controller_matrices.B_ref_rotational * r_inner_loop_cmd(:,ii);

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

        % OUTER LOOP epsilon Two-Layer
        epsilon_twolayer_translational = tracking_error_translational;
          
        % OUTER LOOP trajectory tracking error norm
        der.outer_loop.tracking_error_norm(ii,1) = norm(tracking_error_translational);

        % OUTER LOOP Funnel H function
        der.outer_loop.funnel.H_function(ii,1) = ...
            gains.ADAPTIVE.eta_max_funnel_translational - ...
            log.outer_loop.funnel.eta(ii)^2 - ...
            epsilon_twolayer_translational' * ...
            gains.ADAPTIVE.M_funnel_translational * ...
            epsilon_twolayer_translational;

        % OUTER LOOP Funnel Ve function
        der.outer_loop.funnel.Ve_function(ii,1) = ...
            (epsilon_twolayer_translational' * ...
            controller_matrices.P_translational * ...
            epsilon_twolayer_translational) / ...
            der.outer_loop.funnel.H_function(ii);


        % OUTER LOOP K_hat_x_dot
        K_hat_x_dot_outer_loop = adaptiveLawFunnelDeadzoneEmodification( ...
          -gains.ADAPTIVE.Gamma_x_translational, ...
          log.outer_loop.dead_zone_value(ii), ...
          x_outer_loop, ...
          epsilon_twolayer_translational, ...
          controller_matrices.P_translational, ...
          controller_matrices.B_translational, ...
          gains.ADAPTIVE.sigma_x_translational, ...
          K_hat_x_outer_loop, ...
          der.outer_loop.funnel.H_function(ii), ...
          der.outer_loop.funnel.Ve_function(ii), ...
          gains.ADAPTIVE.M_funnel_translational);

        K_hat_x_dot_outer_loop = projectionMatrix( ...
          K_hat_x_outer_loop, ...
          K_hat_x_dot_outer_loop, ...
          gains.ADAPTIVE.x_e_x_translational, ...
          controller_matrices.epsilon_x_translational, ...
          controller_matrices.S_x_translational);

        der.outer_loop.K_hat_x_dot.ind00(ii,1) = K_hat_x_dot_outer_loop(1,1);
        der.outer_loop.K_hat_x_dot.ind10(ii,1) = K_hat_x_dot_outer_loop(2,1);
        der.outer_loop.K_hat_x_dot.ind20(ii,1) = K_hat_x_dot_outer_loop(3,1);
        der.outer_loop.K_hat_x_dot.ind30(ii,1) = K_hat_x_dot_outer_loop(4,1);
        der.outer_loop.K_hat_x_dot.ind40(ii,1) = K_hat_x_dot_outer_loop(5,1);
        der.outer_loop.K_hat_x_dot.ind50(ii,1) = K_hat_x_dot_outer_loop(6,1);
        der.outer_loop.K_hat_x_dot.ind01(ii,1) = K_hat_x_dot_outer_loop(1,2);
        der.outer_loop.K_hat_x_dot.ind11(ii,1) = K_hat_x_dot_outer_loop(2,2);
        der.outer_loop.K_hat_x_dot.ind21(ii,1) = K_hat_x_dot_outer_loop(3,2);
        der.outer_loop.K_hat_x_dot.ind31(ii,1) = K_hat_x_dot_outer_loop(4,2);
        der.outer_loop.K_hat_x_dot.ind41(ii,1) = K_hat_x_dot_outer_loop(5,2);
        der.outer_loop.K_hat_x_dot.ind51(ii,1) = K_hat_x_dot_outer_loop(6,2);
        der.outer_loop.K_hat_x_dot.ind02(ii,1) = K_hat_x_dot_outer_loop(1,3);
        der.outer_loop.K_hat_x_dot.ind12(ii,1) = K_hat_x_dot_outer_loop(2,3);
        der.outer_loop.K_hat_x_dot.ind22(ii,1) = K_hat_x_dot_outer_loop(3,3);
        der.outer_loop.K_hat_x_dot.ind32(ii,1) = K_hat_x_dot_outer_loop(4,3);
        der.outer_loop.K_hat_x_dot.ind42(ii,1) = K_hat_x_dot_outer_loop(5,3);
        der.outer_loop.K_hat_x_dot.ind52(ii,1) = K_hat_x_dot_outer_loop(6,3);

        % OUTER LOOP K_hat_r_dot
        K_hat_r_dot_outer_loop = adaptiveLawFunnelDeadzoneEmodification( ...
          -gains.ADAPTIVE.Gamma_r_translational, ...
          log.outer_loop.dead_zone_value(ii), ...
          r_cmd_outer_loop, ...
          epsilon_twolayer_translational, ...
          controller_matrices.P_translational, ...
          controller_matrices.B_translational, ...
          gains.ADAPTIVE.sigma_r_translational, ...
          K_hat_r_outer_loop, ...
          der.outer_loop.funnel.H_function(ii), ...
          der.outer_loop.funnel.Ve_function(ii), ...
          gains.ADAPTIVE.M_funnel_translational);

        K_hat_r_dot_outer_loop = projectionMatrix( ...
          K_hat_r_outer_loop, ...
          K_hat_r_dot_outer_loop, ...
          gains.ADAPTIVE.x_e_r_translational, ...
          controller_matrices.epsilon_r_translational, ...
          controller_matrices.S_r_translational);

        der.outer_loop.K_hat_r_dot.ind00(ii,1) = K_hat_r_dot_outer_loop(1,1);
        der.outer_loop.K_hat_r_dot.ind10(ii,1) = K_hat_r_dot_outer_loop(2,1);
        der.outer_loop.K_hat_r_dot.ind20(ii,1) = K_hat_r_dot_outer_loop(3,1);
        der.outer_loop.K_hat_r_dot.ind01(ii,1) = K_hat_r_dot_outer_loop(1,2);
        der.outer_loop.K_hat_r_dot.ind11(ii,1) = K_hat_r_dot_outer_loop(2,2);
        der.outer_loop.K_hat_r_dot.ind21(ii,1) = K_hat_r_dot_outer_loop(3,2);
        der.outer_loop.K_hat_r_dot.ind02(ii,1) = K_hat_r_dot_outer_loop(1,3);
        der.outer_loop.K_hat_r_dot.ind12(ii,1) = K_hat_r_dot_outer_loop(2,3);
        der.outer_loop.K_hat_r_dot.ind22(ii,1) = K_hat_r_dot_outer_loop(3,3);

        % OUTER LOOP Theta_hat_dot
        Theta_hat_dot_outer_loop = adaptiveLawFunnelDeadzoneEmodification( ...
          gains.ADAPTIVE.Gamma_Theta_translational, ...
          log.outer_loop.dead_zone_value(ii), ...
          phi_outer_loop, ...
          epsilon_twolayer_translational, ...
          controller_matrices.P_translational, ...
          controller_matrices.B_translational, ...
          gains.ADAPTIVE.sigma_Theta_translational, ...
          Theta_hat_outer_loop, ...
          der.outer_loop.funnel.H_function(ii), ...
          der.outer_loop.funnel.Ve_function(ii), ...
          gains.ADAPTIVE.M_funnel_translational);

        Theta_hat_dot_outer_loop = projectionMatrix( ...
          Theta_hat_outer_loop, ...
          Theta_hat_dot_outer_loop, ...
          gains.ADAPTIVE.x_e_Theta_translational, ...
          controller_matrices.epsilon_Theta_translational, ...
          controller_matrices.S_Theta_translational);

        der.outer_loop.Theta_hat_dot.ind00(ii,1) = Theta_hat_dot_outer_loop(1,1);
        der.outer_loop.Theta_hat_dot.ind10(ii,1) = Theta_hat_dot_outer_loop(2,1);
        der.outer_loop.Theta_hat_dot.ind20(ii,1) = Theta_hat_dot_outer_loop(3,1);
        der.outer_loop.Theta_hat_dot.ind30(ii,1) = Theta_hat_dot_outer_loop(4,1);
        der.outer_loop.Theta_hat_dot.ind40(ii,1) = Theta_hat_dot_outer_loop(5,1);
        der.outer_loop.Theta_hat_dot.ind50(ii,1) = Theta_hat_dot_outer_loop(6,1);
        der.outer_loop.Theta_hat_dot.ind01(ii,1) = Theta_hat_dot_outer_loop(1,2);
        der.outer_loop.Theta_hat_dot.ind11(ii,1) = Theta_hat_dot_outer_loop(2,2);
        der.outer_loop.Theta_hat_dot.ind21(ii,1) = Theta_hat_dot_outer_loop(3,2);
        der.outer_loop.Theta_hat_dot.ind31(ii,1) = Theta_hat_dot_outer_loop(4,2);
        der.outer_loop.Theta_hat_dot.ind41(ii,1) = Theta_hat_dot_outer_loop(5,2);
        der.outer_loop.Theta_hat_dot.ind51(ii,1) = Theta_hat_dot_outer_loop(6,2);
        der.outer_loop.Theta_hat_dot.ind02(ii,1) = Theta_hat_dot_outer_loop(1,3);
        der.outer_loop.Theta_hat_dot.ind12(ii,1) = Theta_hat_dot_outer_loop(2,3);
        der.outer_loop.Theta_hat_dot.ind22(ii,1) = Theta_hat_dot_outer_loop(3,3);
        der.outer_loop.Theta_hat_dot.ind32(ii,1) = Theta_hat_dot_outer_loop(4,3);
        der.outer_loop.Theta_hat_dot.ind42(ii,1) = Theta_hat_dot_outer_loop(5,3);
        der.outer_loop.Theta_hat_dot.ind52(ii,1) = Theta_hat_dot_outer_loop(6,3);

        % OUTER LOOP K_hat_g_dot
        K_hat_g_dot_outer_loop = adaptiveLawFunnelDeadzoneEmodification( ...
          -gains.ADAPTIVE.Gamma_g_translational, ...
          log.outer_loop.dead_zone_value(ii), ...
          tracking_error_translational, ...
          epsilon_twolayer_translational, ... 
          controller_matrices.P_translational, ...
          controller_matrices.B_translational, ...
          gains.ADAPTIVE.sigma_g_translational, ...
          K_hat_g_outer_loop, ...
          der.outer_loop.funnel.H_function(ii), ...
          der.outer_loop.funnel.Ve_function(ii), ...
          gains.ADAPTIVE.M_funnel_translational);

        K_hat_g_dot_outer_loop = projectionMatrix( ...
          K_hat_g_outer_loop, ...
          K_hat_g_dot_outer_loop, ...
          gains.ADAPTIVE.x_e_g_translational, ...
          controller_matrices.epsilon_g_translational, ...
          controller_matrices.S_g_translational);

        der.outer_loop.K_hat_g_dot.ind00(ii,1) = K_hat_g_dot_outer_loop(1,1);
        der.outer_loop.K_hat_g_dot.ind10(ii,1) = K_hat_g_dot_outer_loop(2,1);
        der.outer_loop.K_hat_g_dot.ind20(ii,1) = K_hat_g_dot_outer_loop(3,1);
        der.outer_loop.K_hat_g_dot.ind30(ii,1) = K_hat_g_dot_outer_loop(4,1);
        der.outer_loop.K_hat_g_dot.ind40(ii,1) = K_hat_g_dot_outer_loop(5,1);
        der.outer_loop.K_hat_g_dot.ind50(ii,1) = K_hat_g_dot_outer_loop(6,1);
        der.outer_loop.K_hat_g_dot.ind01(ii,1) = K_hat_g_dot_outer_loop(1,2);
        der.outer_loop.K_hat_g_dot.ind11(ii,1) = K_hat_g_dot_outer_loop(2,2);
        der.outer_loop.K_hat_g_dot.ind21(ii,1) = K_hat_g_dot_outer_loop(3,2);
        der.outer_loop.K_hat_g_dot.ind31(ii,1) = K_hat_g_dot_outer_loop(4,2);
        der.outer_loop.K_hat_g_dot.ind41(ii,1) = K_hat_g_dot_outer_loop(5,2);
        der.outer_loop.K_hat_g_dot.ind51(ii,1) = K_hat_g_dot_outer_loop(6,2);
        der.outer_loop.K_hat_g_dot.ind02(ii,1) = K_hat_g_dot_outer_loop(1,3);
        der.outer_loop.K_hat_g_dot.ind12(ii,1) = K_hat_g_dot_outer_loop(2,3);
        der.outer_loop.K_hat_g_dot.ind22(ii,1) = K_hat_g_dot_outer_loop(3,3);
        der.outer_loop.K_hat_g_dot.ind32(ii,1) = K_hat_g_dot_outer_loop(4,3);
        der.outer_loop.K_hat_g_dot.ind42(ii,1) = K_hat_g_dot_outer_loop(5,3);
        der.outer_loop.K_hat_g_dot.ind52(ii,1) = K_hat_g_dot_outer_loop(6,3);

        % INNER LOOP epsilon Two-Layer
        epsilon_twolayer_rotational = tracking_error_rotational;

        % INNER LOOP trajectory tracking error norm
        der.inner_loop.tracking_error_norm(ii,1) = norm(tracking_error_rotational);

        % INNER LOOP K_hat_x_dot
        K_hat_x_dot_inner_loop = adaptiveLawDeadzoneEmodification( ...
          -gains.ADAPTIVE.Gamma_x_rotational, ...
          log.inner_loop.dead_zone_value(ii), ...
          x_inner_loop, ...
          epsilon_twolayer_rotational, ...
          controller_matrices.P_rotational, ...
          controller_matrices.B_rotational, ...
          gains.ADAPTIVE.sigma_x_rotational, ...
          K_hat_x_inner_loop);

        K_hat_x_dot_inner_loop = projectionMatrix( ...
          K_hat_x_inner_loop, ...
          K_hat_x_dot_inner_loop, ...
          gains.ADAPTIVE.x_e_x_rotational, ...
          controller_matrices.epsilon_x_rotational, ...
          controller_matrices.S_x_rotational);

        der.inner_loop.K_hat_x_dot.ind00(ii,1) = K_hat_x_dot_inner_loop(1,1);
        der.inner_loop.K_hat_x_dot.ind10(ii,1) = K_hat_x_dot_inner_loop(2,1);
        der.inner_loop.K_hat_x_dot.ind20(ii,1) = K_hat_x_dot_inner_loop(3,1);
        der.inner_loop.K_hat_x_dot.ind01(ii,1) = K_hat_x_dot_inner_loop(1,2);
        der.inner_loop.K_hat_x_dot.ind11(ii,1) = K_hat_x_dot_inner_loop(2,2);
        der.inner_loop.K_hat_x_dot.ind21(ii,1) = K_hat_x_dot_inner_loop(3,2);
        der.inner_loop.K_hat_x_dot.ind02(ii,1) = K_hat_x_dot_inner_loop(1,3);
        der.inner_loop.K_hat_x_dot.ind12(ii,1) = K_hat_x_dot_inner_loop(2,3);
        der.inner_loop.K_hat_x_dot.ind22(ii,1) = K_hat_x_dot_inner_loop(3,3);

        % INNER LOOP K_hat_r_dot
        K_hat_r_dot_inner_loop = adaptiveLawDeadzoneEmodification( ...
          -gains.ADAPTIVE.Gamma_r_rotational, ...
          log.inner_loop.dead_zone_value(ii), ...
          r_cmd_inner_loop, ...
          epsilon_twolayer_rotational, ...
          controller_matrices.P_rotational, ...
          controller_matrices.B_rotational, ...
          gains.ADAPTIVE.sigma_r_rotational, ...
          K_hat_r_inner_loop);

        K_hat_r_dot_inner_loop = projectionMatrix( ...
          K_hat_r_inner_loop, ...
          K_hat_r_dot_inner_loop, ...
          gains.ADAPTIVE.x_e_r_rotational, ...
          controller_matrices.epsilon_r_rotational, ...
          controller_matrices.S_r_rotational);

        der.inner_loop.K_hat_r_dot.ind00(ii,1) = K_hat_r_dot_inner_loop(1,1);
        der.inner_loop.K_hat_r_dot.ind10(ii,1) = K_hat_r_dot_inner_loop(2,1);
        der.inner_loop.K_hat_r_dot.ind20(ii,1) = K_hat_r_dot_inner_loop(3,1);
        der.inner_loop.K_hat_r_dot.ind01(ii,1) = K_hat_r_dot_inner_loop(1,2);
        der.inner_loop.K_hat_r_dot.ind11(ii,1) = K_hat_r_dot_inner_loop(2,2);
        der.inner_loop.K_hat_r_dot.ind21(ii,1) = K_hat_r_dot_inner_loop(3,2);
        der.inner_loop.K_hat_r_dot.ind02(ii,1) = K_hat_r_dot_inner_loop(1,3);
        der.inner_loop.K_hat_r_dot.ind12(ii,1) = K_hat_r_dot_inner_loop(2,3);
        der.inner_loop.K_hat_r_dot.ind22(ii,1) = K_hat_r_dot_inner_loop(3,3);

        % INNER LOOP Theta_hat_dot
        Theta_hat_dot_inner_loop = adaptiveLawDeadzoneEmodification( ...
          gains.ADAPTIVE.Gamma_Theta_rotational, ...
          log.inner_loop.dead_zone_value(ii), ...
          phi_inner_loop, ...
          epsilon_twolayer_rotational, ...
          controller_matrices.P_rotational, ...
          controller_matrices.B_rotational, ...
          gains.ADAPTIVE.sigma_Theta_rotational, ...
          Theta_hat_inner_loop);

        Theta_hat_dot_inner_loop = projectionMatrix( ...
          Theta_hat_inner_loop, ...
          Theta_hat_dot_inner_loop, ...
          gains.ADAPTIVE.x_e_Theta_rotational, ...
          controller_matrices.epsilon_Theta_rotational, ...
          controller_matrices.S_Theta_rotational);

        der.inner_loop.Theta_hat_dot.ind00(ii,1) = Theta_hat_dot_inner_loop(1,1);
        der.inner_loop.Theta_hat_dot.ind10(ii,1) = Theta_hat_dot_inner_loop(2,1);
        der.inner_loop.Theta_hat_dot.ind20(ii,1) = Theta_hat_dot_inner_loop(3,1);
        der.inner_loop.Theta_hat_dot.ind30(ii,1) = Theta_hat_dot_inner_loop(4,1);
        der.inner_loop.Theta_hat_dot.ind40(ii,1) = Theta_hat_dot_inner_loop(5,1);
        der.inner_loop.Theta_hat_dot.ind50(ii,1) = Theta_hat_dot_inner_loop(6,1);
        der.inner_loop.Theta_hat_dot.ind01(ii,1) = Theta_hat_dot_inner_loop(1,2);
        der.inner_loop.Theta_hat_dot.ind11(ii,1) = Theta_hat_dot_inner_loop(2,2);
        der.inner_loop.Theta_hat_dot.ind21(ii,1) = Theta_hat_dot_inner_loop(3,2);
        der.inner_loop.Theta_hat_dot.ind31(ii,1) = Theta_hat_dot_inner_loop(4,2);
        der.inner_loop.Theta_hat_dot.ind41(ii,1) = Theta_hat_dot_inner_loop(5,2);
        der.inner_loop.Theta_hat_dot.ind51(ii,1) = Theta_hat_dot_inner_loop(6,2);
        der.inner_loop.Theta_hat_dot.ind02(ii,1) = Theta_hat_dot_inner_loop(1,3);
        der.inner_loop.Theta_hat_dot.ind12(ii,1) = Theta_hat_dot_inner_loop(2,3);
        der.inner_loop.Theta_hat_dot.ind22(ii,1) = Theta_hat_dot_inner_loop(3,3);
        der.inner_loop.Theta_hat_dot.ind32(ii,1) = Theta_hat_dot_inner_loop(4,3);
        der.inner_loop.Theta_hat_dot.ind42(ii,1) = Theta_hat_dot_inner_loop(5,3);
        der.inner_loop.Theta_hat_dot.ind52(ii,1) = Theta_hat_dot_inner_loop(6,3);

         % INNER LOOP K_hat_g_dot
        K_hat_g_dot_inner_loop = adaptiveLawDeadzoneEmodification( ...
          -gains.ADAPTIVE.Gamma_g_rotational, ...
          log.inner_loop.dead_zone_value(ii), ...
          tracking_error_rotational, ...
          epsilon_twolayer_rotational, ...
          controller_matrices.P_rotational, ...
          controller_matrices.B_rotational, ...
          gains.ADAPTIVE.sigma_g_rotational, ...
          K_hat_g_inner_loop);

        K_hat_g_dot_inner_loop = projectionMatrix( ...
          K_hat_g_inner_loop, ...
          K_hat_g_dot_inner_loop, ...
          gains.ADAPTIVE.x_e_g_rotational, ...
          controller_matrices.epsilon_g_rotational, ...
          controller_matrices.S_g_rotational);

        der.inner_loop.K_hat_g_dot.ind00(ii,1) = K_hat_g_dot_inner_loop(1,1);
        der.inner_loop.K_hat_g_dot.ind10(ii,1) = K_hat_g_dot_inner_loop(2,1);
        der.inner_loop.K_hat_g_dot.ind20(ii,1) = K_hat_g_dot_inner_loop(3,1);
        der.inner_loop.K_hat_g_dot.ind01(ii,1) = K_hat_g_dot_inner_loop(1,2);
        der.inner_loop.K_hat_g_dot.ind11(ii,1) = K_hat_g_dot_inner_loop(2,2);
        der.inner_loop.K_hat_g_dot.ind21(ii,1) = K_hat_g_dot_inner_loop(3,2);
        der.inner_loop.K_hat_g_dot.ind02(ii,1) = K_hat_g_dot_inner_loop(1,3);
        der.inner_loop.K_hat_g_dot.ind12(ii,1) = K_hat_g_dot_inner_loop(2,3);
        der.inner_loop.K_hat_g_dot.ind22(ii,1) = K_hat_g_dot_inner_loop(3,3);

        % OUTER LOOP FUNNEL
        der.outer_loop.funnel.diameter = ...
            gains.ADAPTIVE.eta_max_funnel_translational - ...
            log.outer_loop.funnel.eta.^2;

    end

end

