function der = PyC_computeDerivedValues_FunMRAC(log, der, gains)

% OUTER LOOP FUNNEL Diameter
der.outer_loop.funnel.diameter = ...
    gains.eta_max_funnel_tran - log.outer_loop.funnel.eta.^2;

for ii = 1:length(log.time)
    % OUTER LOOP trajectory tracking error
    der.outer_loop.tracking_error(ii,:) = ...
        [log.position.x(ii) - log.outer_loop.reference_model.position.x(ii);
         log.position.y(ii) - log.outer_loop.reference_model.position.y(ii);
         log.position.z(ii) - log.outer_loop.reference_model.position.z(ii);
         log.velocity.x(ii) - log.outer_loop.reference_model.velocity.x(ii);
         log.velocity.y(ii) - log.outer_loop.reference_model.velocity.y(ii);
         log.velocity.z(ii) - log.outer_loop.reference_model.velocity.z(ii)];

    % OUTER LOOP trajectory tracking error norm
    der.outer_loop.tracking_error_norm(ii,1) = norm(der.outer_loop.tracking_error(ii));

    % INNER LOOP trajectory tracking error
    der.inner_loop.tracking_error(ii,:) = ...
        [log.angular_velocity.x(ii) - log.inner_loop.reference_model.angular_velocity.x(ii);
         log.angular_velocity.y(ii) - log.inner_loop.reference_model.angular_velocity.y(ii);
         log.angular_velocity.z(ii) - log.inner_loop.reference_model.angular_velocity.z(ii)];
    
    % INNER LOOP trajectory tracking error norm
    der.inner_loop.tracking_error_norm(ii,1) = norm(der.inner_loop.tracking_error(ii));

    % OUTER LOOP FUNNEL (e^T M e)
    der.outer_loop.funnel.eMe(ii,:) = ...
        der.outer_loop.tracking_error(ii,:) * ...
        gains.M_funnel_tran * ...
        der.outer_loop.tracking_error(ii,:)';

    der.outer_loop.e_tran_dot_vector(ii,:) = ...
        [log.outer_loop.e_tran_dot.x(ii);
         log.outer_loop.e_tran_dot.y(ii);
         log.outer_loop.e_tran_dot.z(ii);
         log.outer_loop.e_tran_dot.vx(ii);
         log.outer_loop.e_tran_dot.vy(ii);
         log.outer_loop.e_tran_dot.vz(ii)];

    % OUTER LOOP trajectory tracking error derivative norm
    der.outer_loop.e_tran_dot_norm(ii,1) = norm(der.outer_loop.e_tran_dot_vector(ii));

end

end

