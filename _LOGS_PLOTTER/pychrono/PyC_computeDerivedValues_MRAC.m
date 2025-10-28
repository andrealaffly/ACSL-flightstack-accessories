function der = PyC_computeDerivedValues_MRAC(log, der, gains)

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

    % OUTER LOOP tracking error wrt User-Defined Trajectory
    tracking_error_userdeftraj_translational = ...
        [log.position.x(ii) - log.user_defined_position.x(ii);
         log.position.y(ii) - log.user_defined_position.y(ii);
         log.position.z(ii) - log.user_defined_position.z(ii);
         log.velocity.x(ii) - log.user_defined_velocity.x(ii);
         log.velocity.y(ii) - log.user_defined_velocity.y(ii);
         log.velocity.z(ii) - log.user_defined_velocity.z(ii)];

    der.outer_loop.tracking_error_userdeftraj_norm(ii,1) = norm(tracking_error_userdeftraj_translational);

    % INNER LOOP trajectory tracking error
    der.inner_loop.tracking_error(ii,:) = ...
        [log.angular_velocity.x(ii) - log.inner_loop.reference_model.angular_velocity.x(ii);
         log.angular_velocity.y(ii) - log.inner_loop.reference_model.angular_velocity.y(ii);
         log.angular_velocity.z(ii) - log.inner_loop.reference_model.angular_velocity.z(ii)];
    
    % INNER LOOP trajectory tracking error norm
    der.inner_loop.tracking_error_norm(ii,1) = norm(der.inner_loop.tracking_error(ii));

end


end

